# Review Manifest — [Issue 名称]

> 独立审查的完整变更边界。Issue 开始时写 Initial，审查前刷新 Current；不得遗漏未跟踪文件。

## 0. 身份与预算

- Issue：`ISSUE-[ID]`
- 仓库根目录：[绝对路径]
- 分支：[名称]
- Fixed revision：[commit/merge-base]
- Before snapshot：[仓库外临时路径或 evidence 路径]
- Snapshot time：`YYYY-MM-DD HH:mm TZ`
- Reviewer budget：[超时、输出上限、复审剩余次数]

## 1. 初始工作区

- Staged：[文件或无]
- Unstaged：[文件或无]
- Untracked：[文件或无]
- 允许写入：[路径]
- 禁止写入：[路径]

## 2. Before/After 清单

| 文件 | 初始状态 | 当前状态 | Before hash | After hash | Issue 归属 | Diff/内容入口 |
|---|---|---|---|---|---|---|
| [路径] | tracked/modified/untracked/absent | modified/new/deleted | [hash/absent] | [hash/absent] | current/pre-existing/unrelated/uncertain | [命令/路径] |

新增未跟踪文件按 `absent → 当前完整内容` 审查。Issue 开始前已脏且本次继续修改的文件必须从 before snapshot 比较。

## 3. 完整性核查

- [ ] 重新枚举 staged、unstaged、untracked、删除和重命名文件。
- [ ] 每个当前 Issue 文件都有 before/after 证据。
- [ ] 允许范围外变化已分类，没有被静默忽略。
- [ ] `uncertain` 文件已解决，或明确阻塞 Review PASS。
- [ ] reviewer 输入覆盖所有 `current` 和 `uncertain` 文件。
