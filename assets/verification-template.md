# Verification — [Issue 名称]

## 0. 验证身份

- Issue：`ISSUE-[ID]`
- Fixed point：[标识]
- Verified source revision：[当前 commit/工作区快照]
- Review Manifest：[路径 + revision；确认包含 untracked]
- 环境：[工具链、配置、关键依赖]
- 状态：`draft / passed / blocked`

## 1. Requirement 与证据

| Epic Requirement | Delta/Check | Test/Evidence | 当前修订结果 | 结论 |
|---|---|---|---|---|
| REQ-001 | DS-001 / CHK-001 | TEST-001 / [路径] | [结果] | [满足/未满足/待核查] |

## 2. 命令与结果

| Gate | 命令/方法 | 结果 | 失败分类 | 证据 |
|---|---|---|---|---|
| TDD 内环 | [命令] | `pass / fail / not_run` | [分类或无] | [摘要/路径] |
| Issue Gate | [命令] | [结果] | [分类] | [证据] |
| Integration Gate | [命令] | [结果] | [分类] | [证据] |

失败分类：`change_regression / pre_existing / environment / flaky / unknown`。

## 3. Test Depth Matrix

| 风险维度 | 风险 | Test/Evidence | 状态 | 不适用理由/缺口 |
|---|---|---|---|---|
| 主路径/业务分支 | [风险] | [ID] | `covered / partial / not_applicable` | [内容] |
| 边界/等价类 | [风险] | [ID] | [状态] | [内容] |
| 状态/顺序/幂等 | [风险] | [ID] | [状态] | [内容] |
| 错误/超时/恢复 | [风险] | [ID] | [状态] | [内容] |
| 并发/时序/资源 | [风险] | [ID] | [状态] | [内容] |
| 兼容/安全/可观测 | [风险] | [ID] | [状态] | [内容] |

## 4. 测试质量

- 测试 seam：[interface + 适用性]
- Oracle 独立性：[来源]
- Red 证据：[Test ID + 失败原因]
- 断言敏感度/Mutation：[结果或不适用理由]
- Mock/adapter：[外部 seam 及理由]
- 覆盖率：[数值、变化和未覆盖高风险；不能单独作为通过依据]

## 5. Project Fit 与债务

- 复用/重复检查：[证据]
- Change budget：[符合/超出 + 处置]
- Locality/interface/deletion test：[结论]
- 债务项：[ID、影响、处置和触发条件]

## 6. 注释质量

- 审查范围：[新增/修改及语义受影响的邻近注释]
- 必要 why：[业务/协议/并发/生命周期/安全/取舍]
- 代码翻译器/陈旧/错误注释：[无或 finding ID]
- 注释掉的代码与 TODO/workaround：[无或 Issue + 责任归属 + 删除条件]
- 结论：`PASS / BLOCKED`

## 7. Security & Privacy Gate

- Applicability：`not_applicable / applicable / unknown`
- 判定理由与数据分类：[内容]
- 负向测试/扫描/控制证据：[路径/结果/未运行理由]
- 独立 Security Review：[路径 + PASS/SECURITY_BLOCKED/不适用]
- 残余风险与 Approval ID：[内容或无]
- 结论：`PASS / SECURITY_BLOCKED / NOT_APPLICABLE`

## 8. Approval & Release Gate

| 触发器 | Approval ID | 覆盖范围/环境/修订 | 状态 | 结论 |
|---|---|---|---|---|
| [范围豁免/风险接受/迁移/生产发布等] | [APR-ID] | [内容] | [状态] | [有效/阻塞] |

- Code acceptance：[状态]
- Release readiness：[状态]
- Production mutation authorization：[状态；没有明确授权时为 pending/release_blocked]
- 未执行的生产动作：[内容或无]

## 9. Review 迭代

| 轮次 | Reviewer/Prompt | Findings | 修复证据 | 复审结论 |
|---|---|---|---|---|
| 1 | [身份/路径] | [ID] | [diff/测试] | [PASS/需修复] |

最多初审加两次复审。分别保留 Spec、Project Fit、Test Quality，以及适用时的 Security/Privacy 结果。

## 10. 最终结论

- 结论：`PASS / BLOCKED`
- 未满足条件：[内容或无]
- 残余风险：[内容或无]
- 下一步：[Closure/需要的决策/待发布；不得把代码 PASS 写成已发布]
