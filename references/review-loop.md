# 独立代码审查闭环

每个 Issue 完成实现和初步 Verification 后读取。作者不能批准自己的实现；审查 subagent 只读检查并返回 findings，主 Agent 核实、安排修复并决定是否通过。

## 1. 固定审查范围

Issue 开始时记录 fixed point：可解析的 commit、分支 merge-base 或工作区内容快照。审查前确认：

- fixed point 可定位，当前 diff 非空且只覆盖当前 Issue 或能明确区分其他改动。
- Issue、Delta-Spec、Delta-Design、Task、Verification 和相关 Project/Epic 约束可读取。
- 仓库编码标准、构建/测试入口及既有工作区改动已识别。

审查使用 fixed point 到当前工作树/提交的实际 diff。实现者的报告只用于定位，不能替代 diff 和测试证据。

## 2. 独立视角

有两个 subagent 槽位时并行派发：

- **Spec reviewer**：遗漏/部分实现、错误行为、范围蔓延、未授权偏差、验收证据缺口。
- **Quality reviewer**：项目适配、现有能力重复、职责/seam/interface、代码标准、技术债和 Test Charter 深度。

只有一个 reviewer 槽位时，使用综合审查模板，让同一 subagent 分别输出 `Spec`、`Project Fit`、`Test Quality` 三节，不能把一个轴的通过抵消另一个轴的问题。审查者不得参与该 Issue 的实现或直接修改代码。

两个 reviewer 使用 [prompts/review-spec.md](prompts/review-spec.md) 和 [prompts/review-quality.md](prompts/review-quality.md)；一个 reviewer 使用 [prompts/review-issue.md](prompts/review-issue.md)。

## 3. Finding 标准

每条 finding 必须包含：严重度、文件/位置、观察、违反的规格/标准/风险、可复现场景或证据、建议方向。缺少具体证据的偏好不作为 blocker。

| 严重度 | 含义 | 处置 |
|---|---|---|
| blocker | 数据损坏、安全、构建不可用、核心目标错误或无法验收 | 必须修复或由用户/权威决策解除 |
| major | 规格遗漏/范围蔓延、关键测试风险未覆盖、重复能力、公共 interface/架构明显失配 | 当前 Issue 修复；超范围则拆阻塞 Issue |
| minor | 局部维护性、命名、非关键测试或小债务 | 修复或记录有触发条件的债务处置 |
| note | 非阻塞建议或后续机会 | 可记录，不影响通过 |

Project Fit 检查至少包括 duplicated capability、speculative generality、shotgun surgery、divergent change、shallow module、middleman、数据模型重复和与开放 Issue 冲突。仓库明确标准优先于通用启发式。

## 4. 修复与复审

1. 主 Agent 逐条核实 finding，去除误报并将有效项链接到 Requirement、Check 或债务 ID。
2. 实现者修复当前 Issue 范围内的 blocker/major，运行受影响测试和 Gate，更新 Delta/Task/Verification。
3. 同一个独立 reviewer 或新的 reviewer 只审查未解决 finding、修复 diff 和可能的回归范围。
4. 初次审查后最多两轮修复与复审，总计最多三次审查。

通过条件：

- 没有未解决 blocker 或 major。
- 所需测试和 Verification Gate 通过。
- minor 已修复或有证据、影响、触发条件和责任归属。
- 修复没有带入未授权范围、重复能力或新的高风险缺口。

达到复审上限仍不通过、同一 blocker/major 重复出现、修复需要改变 Epic/Project 决策或明显超出 change budget 时停止循环。Issue 标为 blocked，Closure 记录已尝试修复、最新证据和需要用户决定的具体问题。不得通过降低审查严重度、删测试或扩大 Issue 来伪造通过。

## 5. 时间和上下文控制

- reviewer 输入只包含 fixed point、相关规格/设计/标准路径、验证摘要和精确 diff 命令，不加载整个 Epic 历史。
- 每轮只处理当前有效 finding；已关闭项不重复辩论。
- 新发现但不影响当前验收的问题进入独立 Issue/债务处置。
- 大 diff 先按模块或行为分区；若无法在一个 review 上下文内可靠审查，说明 Issue 过大，应拆分或增加集成 review，而不是延长无界循环。
