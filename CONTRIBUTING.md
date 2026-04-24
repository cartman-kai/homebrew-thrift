# Contributing

Thank you for contributing to this Homebrew tap. This repository maintains archived Apache Thrift formulae so older versions can still be installed from source with Homebrew.

## Development Guidelines

- Keep each change focused on one task, such as adding a version, fixing a source URL, or updating a dependency.
- Formula files live in `Formula/` and use the naming pattern `thrift@<major>.<minor>.rb`.
- Follow the existing Homebrew Ruby DSL style: two-space indentation and clear `depends_on`, `stable`, `head`, `install`, and `test` sections.

## Local Validation

Before submitting a change, validate the affected formula locally.

```bash
brew audit --strict --formula ./Formula/thrift@0.21.rb
brew install --build-from-source ./Formula/thrift@0.21.rb
brew test thrift@0.21
```

If you are changing another version, replace the formula name in the commands above.

## Pull Requests

Please include the following in your PR description:

- which formula was changed
- why the change is needed
- which local validation commands were run
- any platform limits, patch details, or upstream archive issues

## Common Change Types

- Add a version: add the formula and verify `url`, `mirror`, `sha256`, dependencies, and `test do`.
- Fix an old version: keep changes minimal and limit them to source URLs, checksums, patches, or dependency compatibility.
- Update documentation: keep `README.md` and related docs in sync with supported versions and maintenance notes.

---

# 贡献说明

感谢为这个 Homebrew tap 做贡献。这个仓库主要维护 Apache Thrift 的历史版本 formula，目标是让旧版本仍然可以通过 Homebrew 从源码安装。

## 开发约定

- 每次修改尽量只处理一个独立问题，例如新增一个版本、修复一个下载地址、或调整一个依赖。
- Formula 文件位于 `Formula/`，命名格式为 `thrift@<major>.<minor>.rb`。
- 保持现有 Homebrew Ruby DSL 风格：两个空格缩进，`depends_on`、`stable`、`head`、`install`、`test` 结构清晰。

## 本地验证

提交前请至少验证你改动涉及的 formula。

```bash
brew audit --strict --formula ./Formula/thrift@0.21.rb
brew install --build-from-source ./Formula/thrift@0.21.rb
brew test thrift@0.21
```

如果你修改的是其他版本，请把命令中的版本号替换成对应 formula。

## 提交 Pull Request

PR 描述建议包含以下内容：

- 修改了哪个 formula
- 为什么需要这个改动
- 本地执行过哪些验证命令
- 是否存在平台限制、补丁依赖或上游归档地址问题

## 常见修改场景

- 新增版本：补充新 formula，并确认 `url`、`mirror`、`sha256`、依赖和 `test do` 可用。
- 修复历史版本：优先保持改动最小，只修复下载地址、校验和、补丁或依赖兼容性问题。
- 更新文档：同步更新 `README.md` 和相关说明文件中的支持版本与维护说明。
