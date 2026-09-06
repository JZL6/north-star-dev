# 一句话自动开发工作流

每次使用 North Star Dev 开发时读取。主 Agent 驱动状态迁移，用户只负责代码库无法回答的产品与工程决策。

## 1. 启动与目录选择

收到一句需求后立即定位仓库根目录并读取适用的仓库规则。检查工作区状态，保留既有改动；创建 Issue 时按 [fixed-point.md](fixed-point.md) 捕获 Review Manifest，不能遗漏 staged、unstaged 或 untracked 内容。

优先沿用项目已有的 spec/design/issue 目录。没有约定时使用：

```text
docs/north-star/
├── project-spec.md
├── baseline.md
├── approvals.md
├── epics/
│   └── EPIC-<id>-<slug>/
│       ├── epic-spec.md
│       └── issues/
│           └── ISSUE-<id>-<slug>/
│               ├── issue.md
│               ├── delta-spec.md
│               ├── delta-design.md
│               ├── task.md
│               ├── review-manifest.md
│               ├── security-review.md
│               ├── verification.md
│               └── closure.md
└── changes/
    └── CHANGE-<id>-<slug>.md
```

轻量改动使用 `changes/` 下的一个文件容纳同名逻辑章节。标准/完整档位使用分离文件。路径变化不能改变这些对象的职责。

## 2. 文档档位

所有改动都经过 SDD+TDD 控制链，档位只决定持久化深度。

| 判断 | 轻量 | 标准 | 完整 |
|---|---|---|---|
| 范围 | 单个局部行为或 Bug | 一个清晰能力，通常 1–3 个 Issue | 跨模块、多能力、架构迁移或长上下文 |
| 公共接口/数据/兼容性 | 无变化 | 有限且可在 Epic 内控制 | 跨系统或影响多个开放 Epic |
| 关键未知项 | 无或可快速消除 | 少量调查 | 多轮决策或当前路线不清晰 |
| 文档 | 一个 change.md | Epic + Issue 产物 | Project + Baseline + Epic + Issue DAG 全套 |

出现以下信号时升级档位：变更范围扩大、公共契约变化、新的跨模块职责、多个独立验收结果、当前上下文无法安全覆盖、实现前提与代码冲突。复杂度降低时可合并后续文档，但保留稳定 ID 和已有历史。

## 3. 自动状态机

```text
INTAKE
  ↓
EXPLORE ──事实不足──→ 继续调查/有界调查 subagent
  ↓
GRILL ──需要人的决策──→ 询问用户 → 记录决定 → 继续
  ↓
EPIC READY
  ↓
ISSUE FRONTIER
  ↓
ISSUE → DELTA SPEC → DELTA DESIGN → TASK
  ↓
TDD/CODE → VERIFICATION → INDEPENDENT REVIEW
  ↑                         ↓ finding
  └──── 修复（最多两轮） ──┘
                            ↓ pass
               SECURITY GATE（按适用性）
                            ↓
                 APPROVAL GATE（按触发器）
                            ↓
                     CLOSURE → WRITEBACK
                            ↓
                 NEXT ISSUE / EPIC VERIFY
```

阶段达到完成条件后自动进入下一阶段。只有以下情况暂停等待用户：

- 目标、验收或范围存在多种合理解释，代码与文档无法决定。
- 文档、代码或不同权威来源冲突，选择会改变业务行为。
- 决策难以逆转、会改变 Project 不变量或显著扩大范围。
- 需要用户提供凭据、权限、业务数据或外部团队决定。
- 审查达到重试上限，仍存在 blocker/major finding。
- 安全/隐私适用性不明、存在未批准的残余风险，或缺少独立 Security reviewer。
- 范围豁免、不可逆动作或生产发布缺少有权批准；此时分别标记 `approval_blocked`、`security_blocked` 或 `release_blocked`。

调查、subagent、实现、验证和回写的重试按 [execution-budgets.md](execution-budgets.md) 执行。同一根因连续两次没有新证据时必须重新规划；重新规划仍失败则拆分或阻塞，不能无界尝试。

事实调查、文件查找、测试命令、现有行为和可复用代码由 Agent 自行完成。询问时说明已确认事实、具体缺口、推荐选择及各选择的影响。

## 4. Explore

### Brownfield

完成以下调查后才进入 Grill：

1. 读取仓库指令、当前分支与工作区状态、相关历史和构建配置。
2. 定位相关入口、调用链、数据流、公共 interface、测试 seam 和外部依赖。
3. 搜索同类能力、名称、错误处理、配置和测试，识别可能复用或重复的实现。
4. 读取存在的 Project、Epic、spec、design、ADR、issue 和 closure；这些文档是可选输入，不是启动前提。
5. 运行成本合理的基线构建或测试，记录既有失败和环境限制。
6. 将事实标记为 `verified`、`inferred` 或 `unknown`，附路径、命令或历史证据。
7. 文档与代码冲突时保留双方陈述和影响，留给 Grill 决策。
8. 初步识别敏感数据、身份/权限、凭据、网络入口、外部 egress、日志/遥测和生产环境边界；未知项不默认安全。

如果仓库没有 Project Spec 或 Baseline，按当前档位创建最小版本。没有既有记录格式时，可使用 [../assets/exploration-template.md](../assets/exploration-template.md)。不要为了补历史文档阻塞局部改动；只记录本次需求安全推进所需的事实。

### Greenfield

1. 探索运行环境、交付形态、技术约束、可复用资产和团队维护能力。
2. 创建最小 Project Spec：目标、边界、领域语言、质量属性和不变量。
3. 把未决架构问题列为假设，先决策会影响首条可运行路径的部分。
4. 建立构建、测试和最小可观测入口，形成初始 Baseline。
5. 以 walking skeleton 作为第一个 Issue，验证最高风险的端到端假设。

当目标过于庞大、连 Epic 的验收边界都不可见时，先创建决策 frontier：一次只解决当前可明确表述的决策，其余保留为未指定区域。路线足够清晰后再进入 Epic，不把决策调查和交付 Issue 混在一起。

## 5. Grill with docs

读取 [grilling.md](grilling.md)。基于 Explore 结果构建问题依赖树；事实问题继续调查，产品取舍和难以逆转的工程决定询问用户。

完成条件：目标结果、范围/非目标、主要验收、关键业务分支、需要测试的 seam、项目约束冲突和首个 Issue 所需决策已经明确。非阻塞未知项进入 Epic Open Questions，并绑定调查 Issue 或触发条件。

决定形成时立即写入正确文档：领域词汇写 Project/项目术语表，难以逆转且令人意外的取舍写 ADR，当前需求决定写 Epic，局部决定写 Delta-Design。每项只保留一个权威位置。

## 6. Epic 与 Issue DAG

Epic 必须包含可观察的 Outcome、Requirement ID、业务流程、范围、影响分析、已确认设计、开放问题、安全/隐私适用性、审批/发布边界和关闭条件。Brownfield Epic 绑定开始时的 Baseline；Greenfield 初始 Epic 绑定首个可运行基线。

Issue 使用 tracer bullet：一条窄而完整、可演示或可验证的行为路径。优先让 slice 穿过所需层级并保持系统可运行。以下情况可以使用非纵向 Issue：

- 调查或原型用于消除阻塞决策。
- 宽范围机械迁移无法单独保持绿色时，使用 expand → 分批 migrate → contract，并设置依赖。
- 为后续能力建立必要 seam 的 prefactor，且它自身有明确行为保护和退出条件。

每个 Issue 适配一个新上下文，声明 blocking edges。主 Agent 每次从所有依赖已完成的 frontier 中选择业务风险最高或最能减少未知量的 Issue。

## 7. Issue 文档链

### Issue.md

定义目标、非目标、依赖、Context Pack、写入范围、退出条件和子文档索引。创建时记录审查 fixed point。

### Delta-Spec.md

描述相对 Epic 和当前系统改变的行为、业务规则、异常与非功能要求。每项链接 Epic Requirement，给出独立于实现的验收例子。涉及安全/隐私时写可观察的拒绝、隔离、最小化、保留/删除和故障行为。规格不写文件列表和内部函数方案。

### Delta-Design.md

记录当前实现事实、复用扫描、方案取舍、interface/seam、数据和状态变化、依赖、迁移/回滚、change budget、测试策略和重构处置。先判定 Security/Privacy applicability；适用时记录数据分类、信任边界、权限、egress、滥用场景和控制。设计只覆盖当前 Issue，不复制 Epic。

### Task.md

按照依赖和 TDD slice 排列动作。每个行为 slice 包含 Test ID、red 预期、最小 green 目标和验证命令。新证据可以调整后续任务；已完成证据不改写。

### Review Manifest

按 [fixed-point.md](fixed-point.md) 保存 Issue 开始时的工作区、必要 before-content 及审查前的完整文件清单。未跟踪文件和开始前已脏又被修改的文件必须有独立 diff/内容入口。

### TDD、Code 与 Verification

读取 [tdd-quality.md](tdd-quality.md) 和 [engineering-health.md](engineering-health.md)。逐 slice 执行测试先行和最小实现，更新 Task 实际状态。完成后生成 Verification，记录需求追踪、命令、结果、测试深度、项目适配、注释质量和遗留风险。命中安全/隐私触发器时还要读取 [security-privacy.md](security-privacy.md)，执行风险匹配的负向测试与项目已有扫描。

### Independent Review

读取 [review-loop.md](review-loop.md)，使用 [prompts](prompts/) 下的模板派发独立审查。Security/Privacy applicability 为 `applicable` 时另派未参与实现的安全 reviewer；普通 Spec/Quality PASS 不能替代。审查通过后才能生成最终 Closure。

### Approval 与 Release

读取 [approvals-release.md](approvals-release.md)。主 Agent 根据触发器核对 Approval ID、批准范围、源码修订、条件和有效期。Agent 不得自批范围豁免、残余风险或生产发布。没有生产授权时可以完成代码交付和发布准备，但不能执行生产 mutation，也不能声称已发布。

### Closure 与 Writeback

Closure 汇总最终结果、规格/设计偏差、验证、review 迭代、债务处置、Baseline drift 和回写候选。读取 [epic-writeback.md](epic-writeback.md) 完成状态同步与规格更新。

## 8. Context 和 subagent

主 Agent 始终持有低分辨率全局图：Project 摘要、Baseline revision、Epic 当前状态和 Issue DAG。执行者只接收当前 Issue 的 Context Pack：

- Issue/Delta/Task 路径和目标 ID。
- 相关 Project/Epic 约束、安全/隐私适用性、Approval 边界及来源。
- 相关代码、测试、interface 和前序 Closure。
- fixed point、允许写入范围、验证命令和停止条件。

subagent 适合独立事实调查、一个 Issue 的实现、有固定输入的验证和独立审查。用户决策型 Grill 留在主 Agent 与用户之间。subagent 缺少信息时返回具体缺口，不自行扩大范围；主 Agent 补充后决定继续、拆 Issue 或询问用户。

如果应用没有 subagent，主 Agent 可以串行完成 Explore、SDD、TDD、Code 和 Verification，但自审只能标记为 advisory，不能满足 Independent Review Gate。Issue 保持 `review_blocked`，保存 Verification 与 Review Manifest，并明确告知用户需要一个独立 reviewer。只要有 subagent 能力，Issue 审查必须交给未参与实现的 subagent。

## 9. 自动连续推进

Issue 完成后：

1. 更新 Epic 的 Issue 状态、Requirement 证据和必要规格。
2. 更新 Baseline 中与当前源码修订相关的已验证事实。
3. 检查其他开放 Issue 的依赖、假设和 Context Pack 是否漂移。
4. 从 frontier 选择下一个未阻塞 Issue 并立即进入其 Issue 文档链。
5. frontier 为空时执行 Epic 集成验证和关闭核查。

发现新工作时按作用范围处理：当前 Issue 必需且未扩大目标的工作纳入 Task；独立可验收工作创建新 Issue；改变 Epic 目标或 Project 不变量的工作先完成相应决策。不要把所有偶然发现塞进当前 Issue。

## 10. 整体完成条件

Issue 完成：退出条件满足，Delta 与实际一致，Verification 通过，独立审查通过，Security/Privacy Gate 和 Approval Gate 按适用性通过，Closure 和回写完成，债务已有明确处置。若退出条件包含生产发布，还必须有本次环境、修订和动作的明确 Release Approval；否则保持 `release_blocked`。

Epic 完成：所有 Requirement 满足或有有效 Approval ID 支持的豁免，Issue DAG 无隐藏遗留项，集成、安全/隐私和发布门禁通过，跨 Issue 重复与架构漂移已检查，Project/Baseline 对账完成。能力验收、代码可发布、发布获批和实际已发布必须分别记录。
