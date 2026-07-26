# cartman-kai/homebrew-thrift

Homebrew tap for archived Apache Thrift formulae that are no longer available in `homebrew-core`.

These formulae are built from source. Bottles are not provided.

[中文说明](./README.zh-CN.md)

## Installation

Homebrew 6.0 and later require non-official taps to be trusted before their formulae can be loaded:

```bash
brew tap cartman-kai/thrift
brew trust cartman-kai/thrift
```

Install a formula directly:

```bash
brew install cartman-kai/thrift/<formula>
```

After tapping and trusting the repository, you can also install by formula name:

```bash
brew install thrift@0.11
```

All formulae are keg-only so that multiple Thrift versions can coexist. Add the selected version to `PATH` when needed:

```bash
export PATH="$(brew --prefix thrift@0.11)/bin:$PATH"
```

## Supported Formulae

- `thrift@0.9` (`0.9.3.1`)
- `thrift@0.10`
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
- `thrift@0.22`
- `thrift@0.23`

## C++ Compatibility

The C++ libraries and generated-code tests use C++14 because the current Boost dependency requires it. Projects that consume the installed Thrift headers should use a C++14-compatible compiler and compile generated C++ code with `-std=c++14` or later. CI explicitly verifies C++14.

## Maintenance Notes

- Latest version in this tap: `thrift@0.23`.
- Supported historical releases currently cover `thrift@0.9` through `thrift@0.23`.
- Recent maintenance work focused on adding missing archived versions, fixing patch URLs, and switching old source downloads to `archive.apache.org`.
- Older formulae are largely copied from `homebrew-core` history and adjusted for source builds without bottles.
- Changed formulae are built from source on Apple Silicon macOS. Newly added formulae are also tested on Intel macOS and Linux.

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
  --with-openssl=#{formula_opt_prefix("openssl@3")}
  --without-erlang
  --without-haskell
  --without-java
  --without-perl
  --without-ruby
  --without-swift
]
```

## Documentation

See `brew help`, `man brew`, or the official [Homebrew documentation](https://docs.brew.sh).
