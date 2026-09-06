# Issue — [Issue 名称]

> 一个可在新上下文中独立理解、实现和验收的 tracer bullet。执行细节和证据放在同目录子文档，本文件保存边界、Context Pack 和状态索引。

## 0. 身份与状态

- Issue ID：`ISSUE-[ID]`
- Epic ID：`EPIC-[ID]`
- 类型：`behavior / bug / investigation / prefactor / refactor / migration / integration / hardening`
- 状态：`proposed / ready / in_progress / blocked / verifying / reviewing / accepted / rejected / superseded / cancelled`
- Baseline revision：[开始时的 Baseline ID + source revision]
- Review fixed point：[commit 或内容快照]
- 依赖 Issue：[ID 或无]
- 执行者：[Agent/角色]
- 创建/更新时间：`YYYY-MM-DD`

## 1. 目标与非目标

### 可观察结果

[完成后调用者、用户或系统能观察到什么]

### 非目标

- [明确排除内容及原因]

### 退出条件

- [ ] Delta-Spec 的 Acceptance 均满足或有批准的豁免。
- [ ] Task 的必要 slice 完成，Verification Gate 通过。
- [ ] 独立 review 通过，Closure 和回写完成。
- [ ] [本 Issue 特有条件]

## 2. Context Pack

| 内容 | 路径/ID | 为什么相关 |
|---|---|---|
| Project/Epic 约束 | [路径 + ID] | [关系] |
| Baseline facts | [路径 + Fact ID] | [前提] |
| 代码入口 | [路径/符号] | [入口] |
| 测试与构建入口 | [路径/命令] | [用途] |
| 公共 interface/契约 | [路径 + ID] | [关系] |
| 前序 Issue Closure | [路径] | [继承事实] |

- 允许修改：[路径、模块或 seam]
- 禁止修改：[路径、公共契约或职责]
- 与并行 Issue 共享的内容：[对象 + 协调方式]

Context Pack 是起点。执行者可以读取完成目标所需的额外材料，并把新事实记录到适当文档。

## 3. 需求与依赖

| Epic Requirement | 本 Issue 贡献 | 依赖/阻塞关系 |
|---|---|---|
| REQ-001 | [贡献] | [Issue ID 或无] |

## 4. 子文档索引

| 产物 | 路径 | 状态 | 完成条件 |
|---|---|---|---|
| Delta-Spec | [delta-spec.md] | [状态] | 行为、验收和非功能增量明确 |
| Delta-Design | [delta-design.md] | [状态] | 复用、seam、方案、change budget 和测试策略明确 |
| Task | [task.md] | [状态] | 当前可见 TDD slice 可执行 |
| Verification | [verification.md] | [状态] | 需求、测试深度和工程门禁有证据 |
| Closure | [closure.md] | [状态] | review、债务、偏差和回写完成 |

## 5. Blocker 与上浮

| ID | 事实/问题 | 级别 | 是否阻塞 | 下一步与责任方 | 状态 |
|---|---|---|---|---|---|
| ESC-001 | [内容] | `Issue / Epic / Project / External` | [是/否] | [动作] | [状态] |

目标、验收、公共契约或 Project 不变量冲突时暂停受影响实现并上浮。局部非阻塞发现进入 Task、债务或后续 Issue。
