# cartman-kai/homebrew-thrift

这是一个 Homebrew tap，用于维护已从 `homebrew-core` 移除的 Apache Thrift 历史版本 formula。

这些 formula 需要从源码编译安装，不提供 bottle。

[English README](./README.md)

## 安装方法

从 Homebrew 6.0 开始，加载非官方 tap 的 formula 前需要先信任该 tap：

```bash
brew tap cartman-kai/thrift
brew trust cartman-kai/thrift
```

可以直接安装指定 formula：

```bash
brew install cartman-kai/thrift/<formula>
```

添加并信任 tap 后，也可以直接使用 formula 名称安装：

```bash
brew install thrift@0.11
```

所有 formula 均为 keg-only，以便多个 Thrift 版本共存。需要使用某个版本时，将其加入 `PATH`：

```bash
export PATH="$(brew --prefix thrift@0.11)/bin:$PATH"
```

## 支持的 Formula

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

## C++ 兼容性

由于当前 Boost 依赖要求 C++14，C++ library 和生成代码测试均使用 C++14。使用已安装 Thrift 头文件的项目应采用支持 C++14 的编译器，并通过 `-std=c++14` 或更高标准编译生成的 C++ 代码。CI 会明确验证 C++14。

## 维护说明

- 当前最新版本为 `thrift@0.23`。
- 目前维护的历史版本范围为 `thrift@0.9` 到 `thrift@0.23`。
- 最近的维护重点主要是补齐历史版本、修复 patch URL，以及将旧版本源码地址切换到 `archive.apache.org`。
- 大部分旧 formula 来自 `homebrew-core` 历史版本，并已调整为仅支持源码安装、不提供 bottle。
- 修改过的 formula 会在 Apple Silicon macOS 上从源码构建；新增 formula 还会在 Intel macOS 和 Linux 上测试。

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
  --with-openssl=#{formula_opt_prefix("openssl@3")}
  --without-erlang
  --without-haskell
  --without-java
  --without-perl
  --without-ruby
  --without-swift
]
```

## 参考文档

可以查看 `brew help`、`man brew`，或访问官方 [Homebrew 文档](https://docs.brew.sh)。
