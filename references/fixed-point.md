# Fixed Point 与 Review Manifest

创建 Issue、派发实现或独立审查时读取。目标是让 reviewer 看到“当前 Issue 真正改变了什么”，包括未跟踪文件，同时保留用户原有的脏工作区。

## 1. Issue 开始时捕获

记录一个 Review Manifest，至少包含：

- 仓库根目录和当前分支。
- `HEAD`、merge-base 或其他可解析 revision。
- 允许写入范围与禁止写入范围。
- staged、unstaged、untracked 文件清单。
- 允许写入范围内每个既有文件的初始内容哈希。
- 已经修改或未跟踪、且本 Issue 还要继续修改的文件，其完整 before-content 快照位置与哈希。

before-content 放在仓库外的临时目录或项目明确的 evidence 区，不能覆盖、stash、reset 或提交用户原有改动。快照位置必须可供 reviewer 读取；Issue 关闭后按项目保留策略处理。

若当前工作区干净且 Issue 不会修改既有未跟踪文件，可直接使用 commit/merge-base 作为 fixed point。只记录 commit 字符串不等于捕获脏工作区。

## 2. 审查前生成变更清单

审查前重新枚举 staged、unstaged、untracked 和删除文件，生成 Review Manifest 的 after 部分：

| 文件 | 初始状态 | 当前状态 | Before hash | After hash | Issue 归属 | Diff 入口 |
|---|---|---|---|---|---|---|
| [路径] | tracked/modified/untracked/absent | modified/new/deleted | [hash/absent] | [hash/absent] | current/pre-existing/unrelated/uncertain | [命令或快照] |

Review 输入必须覆盖：

- 相对 fixed commit 的 tracked/staged diff。
- 当前所有 untracked 文件；新增文件按“空文件 → 当前内容”审查。
- Issue 开始前已脏且又被当前 Issue 修改的文件；按 before-content → 当前内容审查。
- 删除和重命名，以及允许写入范围外的意外变化。

普通 `git diff <revision>` 不包含未跟踪文件，不能单独作为完整审查输入。可用 `git status --porcelain=v1` 与 `git ls-files --others --exclude-standard` 枚举候选，再逐项提供 diff 或完整内容。

## 3. 归属与阻塞规则

- `pre-existing` 和 `unrelated` 变化保留，不纳入 finding，除非当前 Issue 会破坏它们。
- 同一文件混有既有改动和当前改动，必须使用 before-content 区分；不能仅凭行号或作者报告猜测。
- 无法重建 before-content 时，将该文件标记 `uncertain`。它影响目标行为、测试或公共契约时，独立审查不能 PASS；主 Agent 应缩小写入范围、取得可靠快照或请求用户决定。
- reviewer 返回后，主 Agent 对照 Review Manifest 核查其是否覆盖每个 `current` 和 `uncertain` 文件。遗漏文件视为审查未完成。

## 4. 完成条件

Review Manifest 覆盖当前 Issue 的所有新增、修改、删除和重命名文件；每个文件都有可读取的 before/after 证据及归属，reviewer 的输入没有遗漏未跟踪文件。
