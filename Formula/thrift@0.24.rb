class ThriftAT024 < Formula
  desc "Framework for scalable cross-language services development"
  homepage "https://thrift.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=thrift/0.24.0/thrift-0.24.0.tar.gz"
  mirror "https://archive.apache.org/dist/thrift/0.24.0/thrift-0.24.0.tar.gz"
  sha256 "e0fa5839a4c5c1d631b0931cf2c554ebbfa4e2fee3a9fb3ffd4f82ce4396c6e4"
  license "Apache-2.0"
  compatibility_version 3

  head do
    url "https://github.com/apache/thrift.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkgconf" => :build
  end

  keg_only :versioned_formula

  depends_on "bison" => :build
  depends_on "boost" => [:build, :test]
  depends_on "openssl@3"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "./bootstrap.sh" unless build.stable?

    args = %W[
      --disable-debug
      --disable-tests
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-openssl=#{formula_opt_prefix("openssl@3")}
      --without-java
      --without-kotlin
      --without-python
      --without-py3
      --without-ruby
      --without-haxe
      --without-netstd
      --without-perl
      --without-php
      --without-php_extension
      --without-dart
      --without-erlang
      --without-go
      --without-d
      --without-nodejs
      --without-nodets
      --without-lua
      --without-rs
      --without-swift
    ]

    ENV.append "CXXFLAGS", "-std=c++14"

    # 避免将语言扩展安装到 /usr。
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
