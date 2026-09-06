# 编排提示模板

这些模板用于建立明确的输入、产物和停止条件。优先传文件路径与稳定 ID，让执行者读取权威内容；不要粘贴完整 Epic、源码或历史日志。根据实际工具能力调整措辞，不要求必须存在 subagent。

## 1. 工作模式判定

```text
分析当前请求和仓库事实，选择最轻的交付模式：直接交付、Issue、Epic、Project 启动/重建。

输入：
- 用户目标：[原始请求或路径]
- 仓库根目录：[路径]
- 已有 Project/Epic/Baseline：[路径或无]

检查：
1. 影响是否局部且可在单次上下文完成？
2. 是否存在需要独立调查的关键未知项？
3. 是否跨模块、跨团队、跨上下文或包含多个独立验收结果？
4. 是否改变项目级约束、公共接口或数据兼容性？
5. 当前 Engineering Baseline 是否可信且适用于本次变更？

输出：
- 选择的模式及证据
- 需要创建或更新的最小产物
- 当前 blocker 或需要确认的项目级决策

不得仅因模板存在而升级流程层级。
```

## 2. Brownfield Baseline 重建或刷新

```text
在不改变现有行为的前提下，为当前仓库建立或刷新 Engineering Baseline Manifest。

输入：
- 仓库根目录：[路径]
- Project Spec：[路径或无]
- 现有 Baseline：[路径或无]
- 目标变更范围：[描述]

执行：
1. 读取仓库指令、构建配置、测试入口、相关文档和代码。
2. 记录 source revision 与既有工作区改动，不清理用户工作。
3. 运行成本合理的只读诊断、构建和测试。
4. 提取与目标变更相关的模块、接口、依赖、不变量和已知限制。
5. 将结论标记为 verified、inferred 或 unknown，并附证据。
6. 识别文档与实现冲突、既有失败及缺失的安全网。

产物：
- 按 assets/baseline-manifest-template.md 创建或更新 Baseline Manifest
- 必要的调查/characterization test Issue 建议

停止条件：
- 缺少权限、外部环境或关键业务决定时，记录 blocker 和最小下一步；不要猜测或扩大修改范围。
```

## 3. Greenfield 启动

```text
为大型新项目建立最小可验证起点，不生成超前的完整设计。

输入：
- 业务目标与边界：[来源]
- 已确认约束：[来源]
- 仓库根目录：[路径]

执行：
1. 创建极简 Project Spec，区分决策与未知项。
2. 建立最小 Baseline Manifest 和可执行的构建/测试入口。
3. 识别最高风险架构假设，设计一条 walking skeleton。
4. 为验证该路径创建首批 Issue；其余需求只保留到足以排序的深度。

产物：Project Spec、Baseline Manifest、首个 Epic 或 Issue DAG。
```

## 4. Epic 创建或更新

```text
创建或更新一次大需求的 Epic Spec。

输入：
- Project Spec：[路径 + 版本]
- Baseline Manifest：[路径 + revision]
- 用户需求及验收来源：[路径或原始请求]
- 相关开放 Epic：[路径或无]

执行：
1. 定义可观察的业务结果、范围和非目标。
2. 使用稳定 Requirement ID 记录验收条件。
3. 基于证据分析模块、接口、数据、部署和运维影响。
4. 标记假设、未知项、项目约束冲突和与其他 Epic 的重叠。
5. 根据风险选择环境门禁、walking skeleton、能力扩展和 hardening；允许合并或跳过并说明理由。
6. 创建首批可执行 Issue DAG，不假设后续工作已全部可知。

产物：原位更新后的 Epic Spec，以及本次认识变化摘要。
禁止：复制 Project Spec、输出虚假进度百分比、把未验证推断写成事实。
```

## 5. Issue 规划与 Context Pack

```text
为一个可独立推进的结果创建 Issue 和 Context Pack。

输入：
- Epic Spec：[路径]
- Baseline：[路径 + revision]
- 候选结果或风险：[描述]
- 前序交接：[路径或无]

必须明确：
- 目标、非目标、Issue 类型和退出条件
- Requirement/Constraint ID 及来源
- 相关代码、测试、接口和构建入口
- 依赖 Issue、允许修改范围、禁止修改范围和共享接口
- 计划验证命令与期望证据
- 已验证事实、推断和未知项

检查 Issue 是否能在一个执行上下文中调查、实现和验证。过大则按可验证能力或风险拆分，不能按文件数量机械切分。
```

## 6. Issue 执行

```text
完成指定 Issue，并只在授权范围内修改工作区。

输入：
- Issue：[路径]
- Epic Spec：[路径，只在需要上钻时读取相关部分]
- Baseline Manifest：[路径 + revision]

执行：
1. 核对当前 revision、依赖和写入范围；发现漂移先报告影响。
2. 调查现有实现，验证 Context Pack 中的重要前提。
3. 形成完成该 Issue 所需的最小局部设计。
4. 行为变更采用 TDD：测试因预期原因失败，再做最小实现并重构。
5. 调查、纯重构、性能、安全等 Issue 使用与类型匹配的证据，不伪造红绿循环。
6. 运行 Issue Gate，分类记录失败，不通过删测试或放宽断言制造绿灯。
7. 将超出范围的问题按 Issue/Epic/Project 分级；阻塞性冲突立即停止受影响部分。
8. 更新 Issue 的执行证据和 Closure Record：最终结果、原预期与实际偏差、新认识、回写候选及证据修订。无规格影响时说明理由。执行者提交候选，由主 Agent 核验合并。

返回：
- 完成状态及未满足的退出条件
- 变更文件与 diff 摘要
- 实际运行的验证命令、结果和证据位置
- 新事实、上浮项、blocker 和 baseline drift

不要在交付消息中粘贴完整源码或长日志。
```

## 7. Issue 回收与集成

使用前读取 [epic-writeback.md](epic-writeback.md)。该模板也适用于基于已有 Issue 文档的独立 Epic 回写任务。

```text
作为主 Agent 验收一个 Issue。执行报告是线索，不是已确认事实。

输入：
- Project、Baseline、Epic、Issue 路径
- 实际工作区或提交
- Closure 与证据修订；若已拆分，提供 Delta-Spec、Delta-Design、Task 等实际路径

执行：
1. 读取 Epic 相关条目与当前修订、Issue Closure；按需核查需求增量、最终设计、Task 总结及代码和测试。Closure 缺失时基于证据整理，保留未核实项。
2. 检查实际 diff 是否落在写入范围并对应 Requirement/Check ID；运行成本与风险匹配的门禁。已有适用证据足够时无需重复运行测试。
3. 分类失败与实施偏差，区分缺陷、已批准变更、待决策和证据冲突。不得通过扩大目标或放宽验收掩盖偏差。
4. 分别形成状态同步和规格更新候选，标明目标 ID、原内容与新内容、理由、证据/修订和决策来源。无规格变化时说明理由。
5. 核对当前目标仍适用后逐项合并；先核对已有应用结果，避免重复追加。保留 Epic 的完整需求和业务流程，分别维护设计采纳与验证状态。
6. 同步 Issue 状态；Requirement 必须核对全部验收条件后才标为满足。解决问题时更新原 ID，项目级结论进入对应权威资料并引用。
7. 刷新受影响开放 Issue、依赖和 Context Pack，更新必要的 Baseline drift 信息。
8. 在 Closure 记录每项候选的 applied、no_change、needs_decision 或 conflict 结果，以及目标位置和遗留动作。无法完成的保持明确状态。

输出：验收结论、状态同步与规格更新摘要（或无需更新的理由）、证据链接、对账状态、未决项和下一可推进 Issue。
不要将 Issue 实现验收等同于回写完成。没有新证据或状态变化时，重复执行不得追加记录或仅刷新日期。
```

## 8. Epic 验收与 Baseline 对账

```text
验收 Epic 的业务结果并完成工程事实对账。

输入：Project Spec、原 Baseline、Epic Spec、所有 Issue 与证据路径。

检查：
1. 每个 Requirement 是否有可追溯证据或明确批准的豁免。
2. 所需 Integration/Epic Gate 是否通过。
3. 兼容、迁移、发布、回滚和可观测性是否满足或明确不适用。
4. 哪些结论只属于本 Epic，哪些是新的长期项目事实。
5. 是否需要更新 Project Spec、ADR、契约或 Baseline Manifest。
6. 新 Baseline 是否使其他开放 Epic 的假设失效。
7. Issue Closure 的回写候选是否已处置，必要更新是否实际落入目标条目，是否仍有阻塞候选。

产物：Epic 验收结论、更新后的权威文件、新 Baseline revision、其他开放 Epic 的 drift 清单。
```
