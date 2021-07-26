# Cartman-kai Thrift

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
## Include Versions

* thrift@0.10
* thrift@0.11
* thrift@0.12
* thrift@0.13


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
      # --without-php
      # --without-php_extension
      # --without-python
      --without-ruby
      --without-swift
    ]
```


## Issue

thrift@0.10 On Linux

Install thrift@0.10 on Linux will have the problem that ld cannot find `int boost::math::signbit<double>(double)`, testing on Fedora34/Ubuntu 20.04.2

```
/usr/bin/ld: /tmp/thriftA0.10-20210726-11963-gdbcaw/thrift-0.10.0/lib/cpp/.libs/libthrift-0.10.0.so: undefined reference to `int boost::math::signbit<double>(double)'
```

MacOS is OK.