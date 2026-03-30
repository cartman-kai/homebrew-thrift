# cartman-kai/homebrew-thrift

这是一个 Homebrew tap，用于维护已从 `homebrew-core` 移除的 Apache Thrift 历史版本 formula。

这些 formula 需要从源码编译安装，不提供 bottle。

[English README](./README.md)

## 安装方法

可以直接安装指定 formula：

```bash
brew install cartman-kai/thrift/<formula>
```

也可以先添加 tap，再安装：

```bash
brew tap cartman-kai/thrift
brew install thrift@0.11
```

## 支持的 Formula

- `thrift@0.9` (`0.9.3.1`)
- `thrift@0.10`（默认不构建 C++ library）
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

## 维护说明

- 当前最新版本为 `thrift@0.21`。
- 目前维护的历史版本范围为 `thrift@0.9` 到 `thrift@0.21`。
- 最近的维护重点主要是补齐历史版本、修复 patch URL，以及将旧版本源码地址切换到 `archive.apache.org`。
- 大部分旧 formula 来自 `homebrew-core` 历史版本，并已调整为仅支持源码安装、不提供 bottle。

## 自定义语言支持

Homebrew core 已移除 formula 安装选项：
[Remove all options from Homebrew/homebrew-core formulae](https://github.com/Homebrew/homebrew-core/issues/31510)

如果你需要启用或禁用某些语言绑定，可以在本地编辑 formula，并修改 `./configure` 参数：

```bash
brew edit cartman-kai/thrift/thrift@0.11
```

例如，删除对应的 `--without-<language>` 参数：

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

## 已知问题

`thrift@0.10` 在启用基于 Boost 的 C++ 支持时，可能会在 Linux 或 macOS Monterey 上构建失败。

在 Linux 上，链接器可能无法解析 `boost::math::signbit`：

```text
/usr/bin/ld: /tmp/thriftA0.10-20210726-11963-gdbcaw/thrift-0.10.0/lib/cpp/.libs/libthrift-0.10.0.so: undefined reference to `int boost::math::signbit<double>(double)'
```

在 macOS Monterey 上，生成后的代码可能因为缺失符号而编译失败：

```text
../../compiler/cpp/thrift --gen cpp -r ../../tutorial/tutorial.thrift
dyld[90108]: symbol not found in flat namespace '_ZN5boost4math7signbitIdEEiT'
make[3]: *** [gen-cpp/shared_types.cpp] Abort trap: 6
make[2]: *** [all-recursive] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2
```

这更像是工具链或 `libtool` 兼容性问题。实际使用中，不建议将 `thrift@0.10` 用于 C++ 项目。

## 参考文档

可以查看 `brew help`、`man brew`，或访问官方 [Homebrew 文档](https://docs.brew.sh)。
