# Verification — [Issue 名称]

## 0. 验证身份

- Issue：`ISSUE-[ID]`
- Fixed point：[标识]
- Verified source revision：[当前 commit/工作区快照]
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

## 6. Review 迭代

| 轮次 | Reviewer/Prompt | Findings | 修复证据 | 复审结论 |
|---|---|---|---|---|
| 1 | [身份/路径] | [ID] | [diff/测试] | [PASS/需修复] |

最多初审加两次复审。分别保留 Spec、Project Fit、Test Quality 结果。

## 7. 最终结论

- 结论：`PASS / BLOCKED`
- 未满足条件：[内容或无]
- 残余风险：[内容或无]
- 下一步：[Closure/需要的决策]
