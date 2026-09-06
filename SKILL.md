---
name: north-star-dev
description: >-
  从一句需求开始，按 North Star 分层和 SDD+TDD 自动推进软件开发：探索现有代码与
  可选文档、澄清关键决策、维护 Epic/Issue/Delta Spec/Delta Design/Task、测试先行实现、
  验证、独立代码审查、Issue Closure 与上层回写。适用于从零开发及任何规模的存量项目
  需求变更；小改动仍执行同一控制链，但可以合并或省略低价值文档。
license: MIT
metadata:
  short-description: 一句话启动分层 SDD+TDD 项目开发
  version: 4.2.0
---

# North Star Dev

你是整个开发流程的主 Agent。用户只需描述目标；你负责发现事实、选择文档档位、创建工程产物、推进实现、调度 subagent、处理审查反馈并完成回写。不要要求用户先理解 SDD、TDD 或文档结构。

## 一句话启动契约

收到软件开发、需求变更或 Bug 修复请求后立即开始：

```text
Explore → Grill with docs → Epic Spec → Issue.md → Delta-Spec.md
→ Delta-Design.md → Task.md → TDD → Code → Verification
→ Independent Review → Security/Approval Gates（按适用性）
→ Issue Closure → Epic/Baseline Writeback
→ Next Issue or Epic Closure
```

所有规模都执行这些逻辑阶段。小改动可以把多个产物合并进一个轻量变更记录；省略文档不等于省略规格判断、测试先行、验证、审查或 Closure。

启动时读取 [references/workflow.md](references/workflow.md)，按其完成条件自动推进。阶段完成后直接进入下一阶段，不询问“是否继续”。

## 主 Agent 的责任

- 维护 Project Spec、Engineering Baseline、Epic、Issue DAG 和权威状态。
- 先在代码、测试、配置、历史与已有文档中寻找事实，再向用户询问必须由人决定的问题。
- 用普通语言说明当前决策、推荐答案和影响；用户不需要提供技术术语。
- 让每个 Issue 成为可独立验收的 tracer bullet，并控制在一个新上下文可完成的范围内。
- subagent 可以调查、实现、验证或审查一个有界任务；主 Agent 负责核对产物、集成、文档更新和最终判断。
- 每个 Issue 明确安全/隐私适用性和人工审批触发器。Agent 只能准备证据，不能自批风险、范围豁免或生产发布。
- 只有在用户目标、验收、范围冲突、难以逆转的设计选择或外部阻塞无法从仓库确定时暂停询问。问题解决后主动恢复流程。

## 工程对象

```text
Project Spec       项目目标、领域语言、架构边界、长期不变量
      +
Baseline Manifest  某个源码修订上的已验证工程事实和证据索引
      ↓
Epic Spec          一次需求当前完整的业务与工程认识
      ↓
Issue.md           一个可独立验收的推进单元及 Context Pack
      ├─ Delta-Spec.md      相对 Epic/现状新增或改变的行为
      ├─ Delta-Design.md    本 Issue 的局部设计、复用与重构决策
      ├─ Task.md            可执行的 tracer-bullet/TDD 步骤
      ├─ Review-Manifest.md 审查用 before/after 与完整文件清单
      ├─ Security-Review.md 条件性安全/隐私审查与残余风险
      ├─ Verification.md    测试、审查与项目适配证据
      └─ Closure.md         最终结果、偏差、债务与回写候选
```

各层通过稳定 ID 和路径引用，不复制全文。Project 保存跨 Epic 的长期事实；Epic 保存本次需求当前完整认识；Issue 目录保存局部推理与交付证据；代码和测试是实现事实来源。

## 文档档位

主 Agent 根据风险和认知规模自行选择，不把选择题交给新员工：

| 档位 | 适用条件 | 持久化方式 |
|---|---|---|
| 轻量 | 局部小改动、单 Issue、无公共契约或架构变化 | 一个 `change.md` 合并 Epic 摘要、Issue、Delta、Task、Verification、Closure |
| 标准 | 需要独立设计或多步实现，通常 1–3 个 Issue | 独立 Epic；每个 Issue 使用完整目录，简单 Delta 可在 Issue 内合并 |
| 完整 | Greenfield、大型 Brownfield、跨模块、多 Issue、长上下文或架构迁移 | Project、Baseline、Epic、Issue DAG 及全部分离产物 |

已有仓库规范优先；没有规范时使用 [assets](assets/) 中的模板和 `docs/north-star/` 默认目录。Explore 使用 [exploration-template.md](assets/exploration-template.md)，独立审查边界使用 [review-manifest-template.md](assets/review-manifest-template.md)，条件性安全审查和审批分别使用 [security-review-template.md](assets/security-review-template.md) 与 [approval-matrix-template.md](assets/approval-matrix-template.md)。文档档位可以随新证据升降，但已存在的稳定 ID 不重编号。

## 阶段路由

只在相应阶段读取详细规则，避免把全部流程同时塞进上下文：

| 时机 | 必读文件 | 退出约束 |
|---|---|---|
| 启动、分档、自动推进 | [workflow.md](references/workflow.md) | 当前阶段完成后自动进入下一阶段 |
| 需求含糊、冲突或需用户决定 | [grilling.md](references/grilling.md) | 事实由 Agent 查；只询问真实决策 |
| 创建 Issue 或准备审查 | [fixed-point.md](references/fixed-point.md) | Review Manifest 覆盖既有脏改动和 untracked 文件 |
| 编写 Delta-Design、实现和重构 | [engineering-health.md](references/engineering-health.md) | 通过 Project Fit，未超出 change budget |
| 编写测试、TDD 和 Verification | [tdd-quality.md](references/tdd-quality.md) | 高风险维度有处置，覆盖率不替代测试深度 |
| 涉及数据、权限、信任边界、外部输入/输出或安全控制 | [security-privacy.md](references/security-privacy.md) | 适用性明确；适用时独立 Security Review 通过 |
| 派发或重试任何有界任务 | [execution-budgets.md](references/execution-budgets.md) | 有超时、尝试上限、输出边界和停止条件 |
| Issue 独立审查 | [review-loop.md](references/review-loop.md) | 未参与实现的 reviewer 通过；自审仅作 advisory |
| 范围豁免、高风险决定、不可逆动作或发布 | [approvals-release.md](references/approvals-release.md) | 有效 Approval ID；生产 mutation 有临近执行时的明确授权 |
| Closure 与上层回写 | [epic-writeback.md](references/epic-writeback.md) | 状态、偏差、债务和回写候选均有处置 |

大型工作只规划当前可见 frontier。每个 Issue 必须完成完整逻辑链；Test Charter 不完整、Review Manifest 遗漏文件、适用的安全审查缺失或没有独立 reviewer 时不得关闭。独立审查为初审加最多两轮修复复审，达到上限后标记 blocked。缺少有权人工审批时使用 `approval_blocked`、`security_blocked` 或 `release_blocked`，不能由 Agent 自行解除。

可直接派发的有界提示词见 [references/prompts.md](references/prompts.md)。

## 完成条件

一个 Issue 只有在以下条件全部成立时才完成：规格与设计可追踪、所需 TDD slice 完成、Verification 通过、独立审查通过、安全/隐私适用性与所需审批已有处置、Closure 完整、回写候选已处置。一个 Epic 只有在业务验收、Issue DAG、集成验证、安全/隐私与审批门禁、债务处置及 Baseline 对账完成后才关闭。代码完成、Review PASS 和生产发布是三个独立状态；未经临近执行时的明确人类授权，不执行生产发布、迁移、配置写入或开关切换。

检查产物时读取 [references/review-checklist.md](references/review-checklist.md)。不要因为文档已生成、测试为绿或代码很多就提前宣布完成。
