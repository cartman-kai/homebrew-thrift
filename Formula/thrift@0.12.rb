class ThriftAT012 < Formula
  desc "Framework for scalable cross-language services development"
  homepage "https://thrift.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=thrift/0.12.0/thrift-0.12.0.tar.gz"
  mirror "https://archive.apache.org/dist/thrift/0.12.0/thrift-0.12.0.tar.gz"
  sha256 "c336099532b765a6815173f62df0ed897528a9d551837d627c1f87fadad90428"
  license "Apache-2.0"

  head "https://github.com/apache/thrift.git"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "openssl"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/homebrew-core/1cf441a0/Patches/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./bootstrap.sh" unless build.stable?

    args = %W[
      --disable-debug
      --disable-tests
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-openssl=#{formula_opt_prefix("openssl")}
      --without-erlang
      --without-haskell
      --without-java
      --without-perl
      --without-php
      --without-php_extension
      --without-python
      --without-ruby
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
    (testpath/"test.thrift").write <<~THRIFT
      service MultiplicationService {
        i32 multiply(1:i32 x, 2:i32 y),
      }
    THRIFT

    system bin/"thrift", "-r", "--gen", "cpp", "test.thrift"

    system ENV.cxx, "-std=c++14", "gen-cpp/MultiplicationService.cpp",
      "gen-cpp/MultiplicationService_server.skeleton.cpp",
      "-I#{include}",
      "-L#{lib}", "-lthrift"
  end
end
