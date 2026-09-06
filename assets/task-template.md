# Task Plan — [Issue 名称]

> 当前可见的执行计划。一次只推进一个 tracer-bullet/TDD slice；新证据可以调整未开始任务。

## 0. 关联

- Issue：`ISSUE-[ID]`
- Delta-Spec/Design：[路径 + revision]
- Fixed point：[commit/快照]
- 状态：`ready / in_progress / blocked / completed`

## 1. 前置任务

| Task ID | 目标 | 依赖 | 验证 | 状态 |
|---|---|---|---|---|
| TASK-001 | [调查/prefactor/环境准备] | [ID 或无] | [命令/证据] | [状态] |

## 2. TDD Slices

| Slice ID | Acceptance/Test ID | Red 预期 | 最小 Green 目标 | 验证命令 | 状态/证据 |
|---|---|---|---|---|---|
| SLICE-001 | CHK-001 / TEST-001 | [因目标行为缺失而失败] | [最小可观察行为] | [命令] | [状态 + 证据] |

按表格顺序逐项执行：可信 red → 最小 green → 受影响测试 → 当前 slice 清理。后续 slice 不提前实现。

## 3. Issue Gate 与交付

| Task ID | 动作 | 完成条件 | 状态/证据 |
|---|---|---|---|
| TASK-V01 | 更新 Verification | 所有 Check 有当前修订证据 | [状态] |
| TASK-R01 | 独立 review | 无 blocker/major | [状态] |
| TASK-C01 | Closure 与回写 | 候选处置且下一 frontier 已确定 | [状态] |

## 4. 计划变化

| 日期 | 原任务 | 变化及原因 | 对规格/设计的影响 |
|---|---|---|---|
| YYYY-MM-DD | [ID] | [变化] | [无或目标文档 ID] |

已完成结果保持可追踪。出现超出 change budget 的工作时暂停新增代码，先更新设计或拆分 Issue。
