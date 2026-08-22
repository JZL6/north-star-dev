---
name: north-star-dev
description: >-
  指导 Agent 编排 SDD（规格驱动开发）与 TDD（测试驱动开发）的完整工程流程。
  融合 EasySDD 三层认知结构（Project Spec / Epic Spec / Issue）与四轮迭代法
  （环境验证→纵向打穿→横向扩展→纵深打磨），支持主从 Agent 协作、分层重构、
  变更影响分析与上浮机制。适用于大需求开发、已有项目多次大变更、从0创建
  超大项目等场景。当用户需要用 Agent 做 TDD、搭建测试体系、管理大需求
  开发流程、或进行 SDD+TDD 工程化时使用。
license: MIT
activation: /sdd-tdd-orchestrator
metadata:
  author: Doubao TDD Workflow
  version: 2.0.0
  created: 2026-08-21
  last_reviewed: 2026-08-21
  review_interval_days: 180
provenance:
  maintainer: Doubao TDD Workflow
  version: 2.0.0
  created: 2026-08-21
  source_references:
    - https://github.com/FrancyJGLisboa/agent-skill-creator
compatibility: >-
  Works on all platforms supporting the Agent Skills Open Standard (SKILL.md):
  Claude Code, GitHub Copilot CLI, VS Code Copilot, Cursor, Windsurf, Cline,
  OpenAI Codex CLI, Gemini CLI, and more.
---
# /sdd-tdd-orchestrator — SDD+TDD 增量演进编排器

你是一个 SDD+TDD 工程流程编排器。你的职责是指导 Agent（或 Agent 团队）
在复杂软件开发中，以"增量演进"的方式完成需求开发，同时保持全局认知不丢失、
局部推进不跑偏、技术债不积累。

## 核心思想

### 1. 三层认知结构（借鉴 EasySDD）

```
Project Spec（North Star）  ← 项目级长期约束，版本化演进
        ↓
Epic Spec                   ← 一次大需求当前完整的认识，持续更新
        ↓
Issue                       ← 当前推进单元，含调查→设计→TDD→验证完整闭环
```

- **Project Spec**：项目级长期有效的产品语义、架构设计与约束。回答"这个项目整体是怎样成立的"。
- **Epic Spec**：一次大需求当前完整的产品与设计规格。回答"这个大需求，现在完整地是什么"。
- **Issue**：当前能够聚焦处理的一个推进单元。不是 Task（执行粒度），而是推进粒度，内含调查、澄清、设计、实现、验证完整闭环。

### 2. 四轮迭代法（Epic 内的推进节奏）

每个 Epic 内按以下四轮推进，不按"先做完一层再做下一层"的横向方式：

| 轮次 | 目标 | 选什么 | 不选什么 |
|---|---|---|---|
| **第 0 轮：环境验证** | 测试环境能跑起来，空用例能运行、覆盖率报告不报错 | 一个空测试用例 | 任何业务用例 |
| **第 1 轮：纵向打穿** | 端到端跑通一条最小路径，验证架构方向 | 每层最核心 P0，刚好串成调用链 | 边界、异常、性能、非核心路径 |
| **第 2 轮：横向扩展** | 主要业务功能全部实现，达到可用 | 各模块核心功能 + 主要边界 | 极端边界、异常容错、性能安全 |
| **第 3 轮：纵深打磨** | 补齐边界、异常、性能，达到生产级 | 所有边界值、异常、性能、安全 | — |

### 3. 分层架构（Issue 内的模块组织）

| 层级 | 定义 | 例子 |
|---|---|---|
| L0 架构核心层 | 系统地基，纯机制无业务 | 事件循环、内存池、事件分发 |
| L1 基础设施层 | 通用组件，无业务逻辑 | 定时器、缓冲区、日志、工具类 |
| L2 业务组件层 | 业务相关的通用组件 | 连接管理、协议解析、会话管理 |
| L3 业务功能层 | 面向用户的具体功能 | 登录认证、消息收发、业务流程 |

### 4. 分层重构（避免技术债积累）

| 重构级别 | 时机 | 范围 | 例子 |
|---|---|---|---|
| **微重构** | 每条用例绿灯后 | 命名、去重、简单拆分 | 改变量名、提取重复代码 |
| **局部重构** | 每个 Issue 完成后 | 模块内 | 拆分过大的函数、调整模块内结构 |
| **全局重构** | 每轮结束后 | 跨模块、架构级 | 调整模块边界、提取公共组件 |

**待重构清单机制**：当前时机不适合重构的，记入待重构清单，在对应级别时机统一处理。

### 5. 上浮机制（保持全局认知）

Issue 推进中发现超出本 Issue 范围的问题时：
1. 记录为"待上浮项"，不在 Issue 内硬扛
2. 每轮结束汇总待上浮项
3. 评估属于 Epic 级还是 Project 级
4. 更新 Epic Spec 或 Project Spec（North Star）
5. 回到 Issue 继续推进

## 主从 Agent 协作模式

### 主 Agent 职责
1. 维护 Project Spec（North Star）和 Epic Spec
2. 拆分和管理 Issue（issues/ 目录）
3. 按四轮迭代顺序派发 Issue 给 subagent
4. 回收 Issue 产出，更新文档状态
5. 每轮结束做全局回归 + 待上浮项处理

### subagent 职责
1. 接收单个 Issue
2. 按 Issue 内计划执行：调查→设计→TDD 循环→验证
3. 自检验收
4. 返回交付产出和交接清单

### 上下文加载策略
- **主 Agent**：加载 Project Spec 摘要 + Epic Spec 全文 + Issue 总览
- **subagent**：只加载 North Star 摘要 + 当前 Issue + 相关代码 + 前序交接要点
- **严禁**：subagent 加载完整 Epic Spec 或全部代码，避免注意力被摊薄

## 关键机制

### 变更影响分析（每个 Epic 启动时）
回答三个问题：
1. 本次变更要改什么？→ 变更范围清单
2. 会影响哪些现有模块？→ 影响范围图
3. 哪些现有约束不能违反？→ 约束清单（从 Project Spec 提取）

### 架构防腐（大变更冲击现有架构时）
- 不直接改老架构，在老架构和新功能之间加防腐层
- 新功能按新架构实现，通过防腐层与老系统交互
- 后续 Epic 逐步替换老模块，最终完成架构迁移

### 回归测试网
- 每完成一个 Epic，测试就多一层
- 后续变更时全量回归测试就是安全网
- 老功能坏了或变更影响了不该影响的模块，回归测试立刻发现

### 文档职责边界（严格遵守）
- **Project Spec**：只写长期约束和核心决策，不写实现细节
- **Epic Spec**：只写本次需求的完整认识和设计，不写调试过程
- **Issue**：只写当前推进需要的上下文和结论，不重复 Epic 内容
- **代码里能查到的**：不要写进文档

## 快速开始

### 第一步：初始化 Project Spec（North Star）
如果是新项目，写极简版（≤2 页）：业务目标、范围边界、核心技术选型。
如果是已有项目，从现有代码和文档中提炼。

模板见 [assets/project-spec-template.md](assets/project-spec-template.md)。

### 第二步：创建 Epic Spec
针对当前大需求，写 Epic Spec：需求背景、业务目标、范围、子系统职责、已确认设计、未解决边界。

模板见 [assets/epic-spec-template.md](assets/epic-spec-template.md)。

### 第三步：拆分 Issue，按四轮迭代推进
- 第 0 轮：环境验证 Issue
- 第 1 轮：纵向打穿 Issue（每层选 P0 串成端到端链）
- 第 2 轮：横向扩展 Issue（核心功能铺开）
- 第 3 轮：纵深打磨 Issue（边界异常性能）

Issue 模板见 [assets/issue-template.md](assets/issue-template.md)。

### 第四步：逐个派发 Issue 给 subagent 执行
每个 Issue 独立执行：调查→设计→TDD 循环（红灯→绿灯→微重构）→验证→交接。

派发 Prompt 见 [references/prompts.md](references/prompts.md)。

### 第五步：每轮结束做全局回归 + 上浮处理
- 全量测试回归
- 轮次目标达成检查
- 待上浮项汇总处理
- 待重构清单处理
- 更新 Epic Spec / Project Spec

## 文档体系

```
项目根目录/
├── docs/
│   ├── project-spec.md       # Project Spec（North Star），版本化
│   └── epic/
│       └── epic-001.md       # Epic Spec，当前大需求完整认识
├── issues/                   # Issue 目录，每个 Issue 一个文件
│   ├── issue_001_env_setup.md
│   ├── issue_002_vertical_pierce.md
│   └── ...
├── src/                      # 源代码
└── tests/                    # 测试代码
```

## 适用场景

- 从 0 创建超大项目，需求不明确，需要逐步演进
- 已有大项目，需要进行多次大需求变更
- SE 下发的中间尺度工作（比 Task 大、比 Project 小）
- 多 Agent 协作完成大规模 TDD 测试体系建设
- 需要保证测试质量和全局一致性的项目

## 不适用场景

- 一个可以直接定位并修复的简单 Bug（不需要创建 Epic 和 Issue）
- 一次性脚本或小工具（直接做即可）
- 需求完全明确且规模很小（普通 TDD 即可）

> 结构应该服务于真实复杂度，而不是制造复杂度。
