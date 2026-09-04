# Issue — [Issue 名称]

> 一个可聚焦、可交付、可验收的推进单元。Task 是执行动作，Issue 负责从必要调查到可复现证据的闭环。

## 0. 身份与状态

- Issue ID：`ISSUE-[ID]`
- Epic ID：[ID 或无]
- 类型：`investigation | design | behavior | refactor | infrastructure | migration | integration | hardening`
- 状态：`proposed | ready | in_progress | blocked | verifying | accepted | rejected | superseded | cancelled`
- Baseline revision：[ID + source revision]
- 依赖 Issue：[ID 或无]
- 执行者：[Agent/角色]
- 创建时间：`YYYY-MM-DD`
- 最后更新：`YYYY-MM-DD`

## 1. 目标、非目标与退出条件

### 目标结果

[一句话描述完成后可观察到的结果]

### 非目标

- [本 Issue 不处理什么]

### 退出条件

- [ ] [可验证条件]
- [ ] [所需文档、代码、测试或证据]

## 2. Context Pack

### 2.1 相关约束与验收

| ID | 内容 | 来源路径 |
|---|---|---|
| [REQ/INV/QP ID] | [与本 Issue 相关的内容] | [路径] |

### 2.2 相关工程入口

- 代码路径：[路径]
- 测试路径：[路径]
- 接口/契约：[路径]
- 构建/运行入口：[路径或命令]
- 前序交接：[路径或摘要]

### 2.3 写入范围

- 允许修改：[路径或边界]
- 禁止修改：[路径或边界]
- 与其他 Issue 共享的接口：[接口 + 协调方式]

Context Pack 不足时允许继续读取必要材料，但要记录新增事实及其回写位置。

## 3. 已知事实与未知项

| ID | 类型 | 内容 | 证据 | 对执行的影响 |
|---|---|---|---|---|
| F-001 | `verified | inferred | unknown` | [内容] | [路径/命令/测试] | [影响] |

## 4. 调查与局部设计

只写本 Issue 需要的设计。已在上层确定的内容通过 ID 和路径引用。

### 调查问题

- [问题 + 获取证据的方法]

### 局部设计或备选方案

[方案、取舍和决策条件；无需要时写“不需要 + 理由”]

## 5. 验收与验证计划

| Check ID | 验收行为/质量目标 | 验证方法 | 预期证据 |
|---|---|---|---|
| CHK-001 | [目标] | [测试、命令、基准、检查或人工步骤] | [证据] |

行为变更优先使用 Given/When/Then 或同等清晰的行为描述。调查、重构、性能和安全 Issue 使用与类型匹配的证据，不伪造 TDD 过程。

### 计划运行的门禁

- TDD 内环：[命令/测试]
- Issue Gate：[命令/检查]
- Integration Gate：[需要时填写]
- Epic Gate：[通常由主 Agent 执行或引用]

## 6. 执行计划

按依赖顺序列出可验证动作；计划可以随新证据更新。

- [ ] [Task 1]
- [ ] [Task 2]

## 7. 执行证据

### 7.1 变更

| 文件/边界 | 变化摘要 | 对应 Check/Requirement |
|---|---|---|
| [路径] | [摘要] | [ID] |

### 7.2 验证结果

| Check ID | 实际命令/方法 | 结果 | 证据/失败分类 |
|---|---|---|---|
| CHK-001 | [命令] | `pass | fail | not_run` | [摘要或路径] |

失败分类：`change_regression | pre_existing | environment | flaky | unknown`。

### 7.3 TDD/实施摘要

[记录关键行为如何被测试驱动或为什么采用其他验证方法；不要粘贴完整代码和长日志]

## 8. 上浮项、阻塞与重构

| ID | 类型 | 内容 | 级别 | 是否阻塞 | 下一步/去向 | 状态 |
|---|---|---|---|---|---|---|
| ESC-001 | `scope | design | project_constraint | dependency | refactor` | [内容] | `Issue | Epic | Project` | [是/否] | [路径/决策] | [状态] |

关键冲突立即处理，不等待阶段结束。非阻塞重构只有在有明确收益和处理时机时才记录。

## 9. 交接与验收

- 达成的结果：[摘要]
- 未达成项及原因：[内容或无]
- 关键证据：[路径或 Check ID]
- 新增事实的回写位置：[路径或无]
- Baseline drift：[无，或具体变化]
- 后续可推进 Issue：[ID]
- 主 Agent 验收结论：`pending | accepted | rejected`
- 结论依据：[实际 diff、命令和证据]

执行记录过长时拆到独立 evidence/handoff 文件，本文件只保留索引和当前结论。
