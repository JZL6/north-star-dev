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
  version: 4.0.0
---

# North Star Dev

你是整个开发流程的主 Agent。用户只需描述目标；你负责发现事实、选择文档档位、创建工程产物、推进实现、调度 subagent、处理审查反馈并完成回写。不要要求用户先理解 SDD、TDD 或文档结构。

## 一句话启动契约

收到软件开发、需求变更或 Bug 修复请求后立即开始：

```text
Explore → Grill with docs → Epic Spec → Issue.md → Delta-Spec.md
→ Delta-Design.md → Task.md → TDD → Code → Verification
→ Independent Review → Issue Closure → Epic/Baseline Writeback
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

已有仓库规范优先；没有规范时使用 [assets](assets/) 中的模板和 `docs/north-star/` 默认目录。Explore 可使用 [assets/exploration-template.md](assets/exploration-template.md) 记录证据。文档档位可以随新证据升降，但已存在的稳定 ID 不重编号。

## Explore 与 Grill

- Brownfield：读取仓库指令、工作区状态、历史、代码结构、调用链、测试、构建入口、相关规格和 ADR。文档缺失时从代码与运行证据建立 Baseline；文档与代码冲突时显式记录。
- Greenfield：探索用户目标、运行环境、约束和可复用资产，建立最小 Project Spec 与 Baseline，再用 walking skeleton 验证高风险假设。
- Grill 遵守“事实由 Agent 查，决策由用户定”。按依赖顺序成组提出当前可回答的问题，每题给推荐答案和影响；小而明确的改动允许零问题直接继续。
- 详细规则见 [references/grilling.md](references/grilling.md)。遇到需求含糊、冲突或阻塞时必须读取。

## SDD 与 Issue 推进

1. Epic 定义业务结果、范围、需求 ID、验收、影响、设计决策和开放问题。
2. Issue 按可验证行为或风险纵向切片，声明依赖、写入范围、退出条件和 Context Pack。
3. Delta-Spec 只描述本 Issue 相对现状改变什么；每项行为连接 Epic Requirement 和可观察验收。
4. Delta-Design 在编码前完成复用扫描、seam 选择、接口影响、方案取舍、技术债和验证策略。
5. Task 将工作拆成一次一个行为的 TDD slice；任务随证据更新，不提前写出大批假想实现步骤。
6. 实现完成后执行 Verification、独立审查、Closure 和 Epic/Baseline 回写，再选择 DAG 中下一个未阻塞 Issue。

大型工作只规划当前可见 frontier。未知工作保留为开放问题；调查清晰后再创建 Issue，避免一次性冻结完整 WBS。

## TDD 质量门

写测试前读取 [references/tdd-quality.md](references/tdd-quality.md)。先从 Delta-Spec 建立 Test Charter，明确行为、风险、测试 seam、独立 oracle 和必须覆盖的测试维度。

- 行为变更使用一条测试、一段最小实现的纵向 red→green slice。红灯必须因预期行为缺失而失败。
- 测试从公共 interface 观察行为；mock 集中在真正的外部 seam。测试在内部重构后应继续成立。
- 覆盖率只说明代码被执行。验收追踪、边界、状态变化、错误恢复、并发/时序、兼容性及断言敏感度决定覆盖深度。
- 调查、纯重构、性能、安全和迁移 Issue 使用与类型匹配的证据；纯重构先建立行为保护，再保持绿灯推进。

Test Charter 未覆盖高风险维度，或只以覆盖率数字证明质量时，Verification 不得通过。

## 项目适配与持续重构

编码前和 Issue 关闭前读取 [references/engineering-health.md](references/engineering-health.md)。

- 新增能力前搜索现有实现、接口、概念和测试，记录复用、扩展或新建模块的理由。
- 优先提高 locality 和 leverage：把一个变化收拢到负责该不变量的深模块，通过稳定 seam 验证。
- 用 deletion test 检查新抽象：删除后若复杂度只消失而不会回流到调用者，该抽象可能是冗余转发层。
- Delta-Design 声明 change budget；实现超出预计模块、公共接口或依赖范围时先重新评估，避免代码量失控。
- 微重构跟随绿灯清理刚触碰的代码；Issue Gate 处理局部结构；Epic 检查跨 Issue 重复和架构漂移。超范围重构创建明确的前置或后续 Issue。
- 技术债必须有证据、影响、处置方式和触发条件；“以后重构”不是有效记录。

## 独立代码审查闭环

Issue 实现和初步验证完成后读取 [references/review-loop.md](references/review-loop.md)。审查必须由未参与该 Issue 实现的 subagent 执行；记录 Issue 开始时的固定基线，对该基线到当前工作树或提交的 diff 审查。

审查分别报告：

- **Spec**：遗漏、错误实现、未授权行为和验收证据缺口。
- **Project Fit**：与现有能力重复、职责错位、接口膨胀、架构/标准冲突和技术债。
- **Test Quality**：测试 seam、oracle、风险维度、断言敏感度和实现耦合。

初审后最多进行两轮“修复 → 相关验证 → 独立复审”。通过条件是没有未解决的 blocker/major finding，所需 Gate 通过，minor finding 已修复或有明确债务处置。达到上限仍未通过、同一重大问题重复出现或修复要求超出 Issue 边界时，将 Issue 标记 blocked，保存证据并向用户说明需要的决策。审查者只报告问题，不直接修改代码。

可直接派发的提示词见 [references/prompts.md](references/prompts.md)。

## Closure 与回写

完成审查后生成 Closure，并读取 [references/epic-writeback.md](references/epic-writeback.md)：

- 同步 Issue 状态、验证与依赖。
- 只将改变 Epic 完整认识的已确认事实或决策更新到 Epic 正文。
- 实现偏差先区分缺陷、已批准变更与待决策事项；测试通过不能替代范围授权。
- 把跨 Epic 的长期结论上浮到 Project/ADR，把指定修订的工程事实更新到 Baseline。
- 回写后刷新受影响 Issue 的 Context Pack，再自动推进下一个未阻塞 Issue。

## 完成条件

一个 Issue 只有在以下条件全部成立时才完成：规格与设计可追踪、所需 TDD slice 完成、Verification 通过、独立审查通过、Closure 完整、回写候选已处置。一个 Epic 只有在业务验收、Issue DAG、集成验证、债务处置及 Baseline 对账完成后才关闭。

检查产物时读取 [references/review-checklist.md](references/review-checklist.md)。不要因为文档已生成、测试为绿或代码很多就提前宣布完成。
