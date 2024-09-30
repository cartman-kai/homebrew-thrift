# Cartman-kai homebrew-thrift

Some old version of thrift Formulas which no longer included in homebrew-core.
These old versions of Formulas need to be compiled, and no bottle is provided.

## How do I install these formulae?

`brew install cartman-kai/thrift/<formula>`

Or `brew tap cartman-kai/thrift` and then `brew install <formula>`.

Install thrift@0.11

```shell
brew tap cartman-kai/thrift
brew install thrift@0.11
```

## support versions

* thrift@0.9 (0.9.3.1)
* thrift@0.10(default without c++ library)
* thrift@0.11
* thrift@0.12
* thrift@0.13
* thrift@0.14 (0.14.2)
* thrift@0.15
* thrift@0.16
* thrift@0.17
* thrift@0.18
* thrift@0.19
* thrift@0.20

## Changelog

* 2024-09-30 **Fixed Patch URL issue**. Affected versions: 0.15 - 0.19. Verified successful installation and usage on macOS Ventura (13.6.9).

* 2024-09-24 add thrift@0.20.

* 2024-07-12 add thrift@0.9, copy from homebrew-core/Formal (delete bottle).

* 2024-03-31 copy thrift@0.19 from homebrew-core/Formal (delete bottle).

* 2023-10-07 copy thrift@0.18 from homebrew-core/Formal (delete bottle).

* 2023-05-27 fix url can't download issue.(replace url to archive.apache.org).

* 2023-03-09 copy thrift@0.17 from homebrew-core/Formal (delete bottle).

* 2022-09-23 add thrift@0.15 thrift@0.16, fix thrift@0.14 dependencies.

* 2021-12-19 thrift@0.10 change configure args, default **not support C++ Complier Library**.

* 2021-09-22 copy thrift@0.14 from homebrew-core/Formal (delete bottle) 

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Configure options

Because [Remove all options from Homebrew/homebrew-core formulae](https://github.com/Homebrew/homebrew-core/issues/31510)

If you want install thrift with some language, use `brew edit <formual>`, modify configure args. (default brew editor is nano)


```
brew edit cartman-kai/thrift/thrift@0.11
```

thrift default enable support languages, so modify without-\<language\> line like this.

```ruby
args = %W[
  --disable-debug
  --disable-tests
  --prefix=#{prefix}
  --libdir=#{lib}
  --with-openssl=#{Formula["openssl@1.1"].opt_prefix}
  --without-erlang
  --without-haskell
  --without-java
  --without-perl
  --without-ruby
  --without-swift
]
```


## Issues

thrift@0.10 --with-boost On Linux Or macOS Monterey complier error.

On Linux will have the problem that ld cannot find `int boost::math::signbit<double>(double)`, testing on Fedora34/Ubuntu 20.04.2

```
/usr/bin/ld: /tmp/thriftA0.10-20210726-11963-gdbcaw/thrift-0.10.0/lib/cpp/.libs/libthrift-0.10.0.so: undefined reference to `int boost::math::signbit<double>(double)'
```

On macOS Monterey

```../../compiler/cpp/thrift --gen cpp -r ../../tutorial/tutorial.thrift
dyld[90108]: symbol not found in flat namespace '_ZN5boost4math7signbitIdEEiT'
make[3]: *** [gen-cpp/shared_types.cpp] Abort trap: 6
make[2]: *** [all-recursive] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2
```

This is the same problem. `ld` or `dlyd` cannot link `int boost::math::signbit` function. It may be related to C++ Complier or libtool.

In short, thrift@0.10 is **not recommended** for C++ Project, it is no longer supported.
