# Issue Closure — [Issue 名称]

## 0. 身份

- Issue：`ISSUE-[ID]`
- Final source revision：[commit/快照]
- Verification：[路径 + revision]
- Review 状态：[PASS/BLOCKED + 轮次]
- Security Review：[PASS/SECURITY_BLOCKED/NOT_APPLICABLE + 路径]
- Approval/Release 状态：[not_required / approved / approval_blocked / release_blocked / released]
- Closure 状态：`draft / accepted_for_code / accepted / blocked / security_blocked / approval_blocked / release_blocked`
- Epic 对账状态：`pending / completed / blocked / not_applicable`

## 1. 最终结果

- 达成的可观察结果：[摘要]
- 未达成项及原因：[内容或无]
- Requirement/Check 证据：[ID + 路径]
- 实际变更范围：[模块/interface/数据]

## 2. 预期、偏差与新认识

| ID | 原规格/假设 | 最终事实 | 判定 | 决策与证据 | 影响 |
|---|---|---|---|---|---|
| CHG-001 | [内容] | [事实] | `符合 / 缺陷 / 已批准变更 / 待决策 / 冲突` | [来源 + revision] | [影响] |

## 3. 独立 Review

| 轴 | 最终结论 | 已修 finding | 未解决 finding/处置 |
|---|---|---|---|
| Spec | [PASS/BLOCKED] | [ID] | [内容或无] |
| Project Fit | [结论] | [ID] | [内容或无] |
| Test Quality | [结论] | [ID] | [内容或无] |
| Security/Privacy | [PASS/BLOCKED/不适用] | [SEC-ID] | [内容、残余风险与 Approval ID] |

## 4. 注释质量

- 关键 why 注释：[路径/内容或无]
- 已移除/修正的翻译器或陈旧注释：[路径或无]
- 临时 TODO/workaround：[Issue、责任归属、删除条件或无]
- Gate 结论：`PASS / BLOCKED`

## 5. 技术债与重构

| Debt ID | 证据与影响 | 处置 | 触发条件/责任方 | 目标 Issue |
|---|---|---|---|---|
| DEBT-001 | [内容] | `已修复 / 阻塞前置 / 后续 Issue / 接受` | [条件/角色] | [ID 或无] |

## 6. 审批与发布边界

| Approval ID | 类型 | 决策范围与目标修订 | 状态/条件 | 权威来源 |
|---|---|---|---|---|
| APR-001 | [范围/风险/发布] | [内容] | [状态] | [记录] |

- 代码验收：[状态]
- 发布准备：[状态与证据]
- 生产授权：[状态；覆盖环境/修订/动作]
- 实际发布：[未发布/已发布 + 权威证据]
- 未经授权而未执行的动作：[内容或无]

## 7. 回写候选

| WB ID | 类别 | 目标文件与条目 | 变化及理由 | 证据/修订 | 状态 | 应用位置/原因 |
|---|---|---|---|---|---|---|
| WB-001 | `状态同步 / 规格更新 / Project / Baseline` | [路径 + ID] | [旧 → 新] | [来源] | `pending / applied / no_change / needs_decision / conflict` | [位置/原因] |

无候选时说明为什么无需更新。使用稳定 WB ID；重复执行不得追加同义条目。

## 8. 后续影响

- Baseline drift：[变化或无]
- 已刷新/暂停的开放 Issue：[ID + 原因]
- 新建后续 Issue：[ID + blocking edge]
- 下一 frontier Issue：[ID 或 Epic 验证]
- 需要用户决定的问题：[具体缺口或无]

只有 Verification 与独立 review 通过、Security/Privacy applicability 与所需审批已处置、阻塞偏差已解决、必要债务和回写已有处置时，Closure 才能标为 accepted。代码可交付但生产发布仍待授权时使用 `accepted_for_code`；若真实发布是退出条件，则保持 `release_blocked`。Agent 不得自行批准风险、豁免或发布。
