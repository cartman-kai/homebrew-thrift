class ThriftAT010 < Formula
  desc "Framework for scalable cross-language services development"
  homepage "https://thrift.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=thrift/0.10.0/thrift-0.10.0.tar.gz"
  mirror "https://archive.apache.org/dist/thrift/0.10.0/thrift-0.10.0.tar.gz"
  sha256 "2289d02de6e8db04cbbabb921aeb62bfe3098c4c83f36eec6c31194301efa10b"
  license "Apache-2.0"

  head "https://github.com/apache/thrift.git", branch: "0.10.0"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "boost" => [:build, :test]
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libevent"
  depends_on "openssl@3"

  def install
    if build.stable?
      # Fix -flat_namespace being used on newer macOS releases.
      inreplace "configure", "case ${MACOSX_DEPLOYMENT_TARGET-10.0},$host in",
        "case ${MACOSX_DEPLOYMENT_TARGET},$host in"
      inreplace "configure", "10.[012]*)", "10.[012],*|,*powerpc*)"
      inreplace "configure", "10.*)", "*)"
    else
      system "./bootstrap.sh"
    end

    args = %W[
      --disable-debug
      --disable-tests
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-boost=#{formula_opt_prefix("boost")}
      --with-openssl=#{formula_opt_prefix("openssl@3")}
      --without-erlang
      --without-haskell
      --without-java
      --without-perl
      --without-php
      --without-php_extension
      --without-python
      --without-ruby
      --without-swift
    ]

    ENV.append "CXXFLAGS", "-std=c++14"

    # Don't install extensions to /usr:
    ENV["PY_PREFIX"] = prefix
    ENV["PHP_PREFIX"] = prefix
    ENV["JAVA_PREFIX"] = buildpath

    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.thrift").write <<~EOS
      service MultiplicationService {
        i32 multiply(1:i32 x, 2:i32 y),
      }
    EOS

    system "#{bin}/thrift", "-r", "--gen", "cpp", "test.thrift"

    system ENV.cxx, "-std=c++14", "gen-cpp/MultiplicationService.cpp",
      "gen-cpp/MultiplicationService_server.skeleton.cpp",
      "-I#{include}",
      "-L#{lib}", "-lthrift"
  end
end
