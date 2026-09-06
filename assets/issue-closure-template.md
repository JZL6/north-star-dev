# Issue Closure — [Issue 名称]

## 0. 身份

- Issue：`ISSUE-[ID]`
- Final source revision：[commit/快照]
- Verification：[路径 + revision]
- Review 状态：[PASS/BLOCKED + 轮次]
- Closure 状态：`draft / accepted / blocked`
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

## 4. 技术债与重构

| Debt ID | 证据与影响 | 处置 | 触发条件/责任方 | 目标 Issue |
|---|---|---|---|---|
| DEBT-001 | [内容] | `已修复 / 阻塞前置 / 后续 Issue / 接受` | [条件/角色] | [ID 或无] |

## 5. 回写候选

| WB ID | 类别 | 目标文件与条目 | 变化及理由 | 证据/修订 | 状态 | 应用位置/原因 |
|---|---|---|---|---|---|---|
| WB-001 | `状态同步 / 规格更新 / Project / Baseline` | [路径 + ID] | [旧 → 新] | [来源] | `pending / applied / no_change / needs_decision / conflict` | [位置/原因] |

无候选时说明为什么无需更新。使用稳定 WB ID；重复执行不得追加同义条目。

## 6. 后续影响

- Baseline drift：[变化或无]
- 已刷新/暂停的开放 Issue：[ID + 原因]
- 新建后续 Issue：[ID + blocking edge]
- 下一 frontier Issue：[ID 或 Epic 验证]
- 需要用户决定的问题：[具体缺口或无]

只有 Verification 与独立 review 通过、阻塞偏差已解决、必要债务和回写已有处置时，Closure 才能标为 accepted。
