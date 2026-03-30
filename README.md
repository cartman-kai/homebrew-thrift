# cartman-kai/homebrew-thrift

Homebrew tap for archived Apache Thrift formulae that are no longer available in `homebrew-core`.

These formulae are built from source. Bottles are not provided.

[中文说明](./README.zh-CN.md)

## Installation

Install a formula directly:

```bash
brew install cartman-kai/thrift/<formula>
```

Or tap the repository first, then install a formula:

```bash
brew tap cartman-kai/thrift
brew install thrift@0.11
```

## Supported Formulae

- `thrift@0.9` (`0.9.3.1`)
- `thrift@0.10` (built without the C++ library by default)
- `thrift@0.11`
- `thrift@0.12`
- `thrift@0.13`
- `thrift@0.14` (`0.14.2`)
- `thrift@0.15`
- `thrift@0.16`
- `thrift@0.17`
- `thrift@0.18`
- `thrift@0.19`
- `thrift@0.20`
- `thrift@0.21`

## Maintenance Notes

- Latest version in this tap: `thrift@0.21`.
- Supported historical releases currently cover `thrift@0.9` through `thrift@0.21`.
- Recent maintenance work focused on adding missing archived versions, fixing patch URLs, and switching old source downloads to `archive.apache.org`.
- Older formulae are largely copied from `homebrew-core` history and adjusted for source builds without bottles.

## Customizing Language Support

Homebrew core formula options were removed upstream:
[Remove all options from Homebrew/homebrew-core formulae](https://github.com/Homebrew/homebrew-core/issues/31510)

If you need to enable or disable language bindings, edit the formula locally and adjust the `./configure` arguments:

```bash
brew edit cartman-kai/thrift/thrift@0.11
```

For example, remove the matching `--without-<language>` flags:

```ruby
args = %W[
  --disable-debug
  --disable-tests
  --prefix=#{prefix}
  --libdir=#{lib}
  --with-openssl=#{Formula["openssl@3"].opt_prefix}
  --without-erlang
  --without-haskell
  --without-java
  --without-perl
  --without-ruby
  --without-swift
]
```

## Known Issue

`thrift@0.10` may fail when built with Boost-based C++ support on Linux or on macOS Monterey.

On Linux, the linker may fail to resolve `boost::math::signbit`:

```text
/usr/bin/ld: /tmp/thriftA0.10-20210726-11963-gdbcaw/thrift-0.10.0/lib/cpp/.libs/libthrift-0.10.0.so: undefined reference to `int boost::math::signbit<double>(double)'
```

On macOS Monterey, the generated code build may fail with a missing symbol:

```text
../../compiler/cpp/thrift --gen cpp -r ../../tutorial/tutorial.thrift
dyld[90108]: symbol not found in flat namespace '_ZN5boost4math7signbitIdEEiT'
make[3]: *** [gen-cpp/shared_types.cpp] Abort trap: 6
make[2]: *** [all-recursive] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2
```

This appears to be a toolchain or libtool compatibility issue. In practice, `thrift@0.10` is not recommended for C++ projects.

## Documentation

See `brew help`, `man brew`, or the official [Homebrew documentation](https://docs.brew.sh).
