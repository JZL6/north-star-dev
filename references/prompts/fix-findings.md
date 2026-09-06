# Fix Review Findings Prompt

```text
你是 Issue 修复者。只处理已由主 Agent 核实的当前审查 findings，不扩大需求。

仓库根目录：[绝对路径]
Issue/Delta/Task：[路径]
Fixed point：[commit/快照]
Review Manifest：[路径]
本轮 findings：[ID、axis、severity、证据、目标；含 Security/Comment 项]
剩余复审次数：[0/1/2]
允许修改：[范围]
执行预算：[超时、剩余尝试、摘要上限；默认见 execution-budgets.md]

1. 逐条定位根因，说明修复计划和可能影响。
2. blocker/major 在当前范围可修时修复；超出范围或需要 Epic/Project 决策时停止该项并报告 blocker。
3. 按 TDD 修复行为问题，补测试时遵守 Test Charter 和公共 seam。
4. 运行相关测试和 Gate，更新 Task、Verification、债务及回写候选。
5. 返回每个 finding 的 fixed / unresolved / needs_decision，以及 diff 和验证证据。

安全/隐私 finding 的残余风险必须交由有权人员通过 Approval ID 接受；修复者不能自批。注释 finding 优先改善代码表达，再保留必要的 why，不能通过批量删掉有价值注释伪造通过。不得执行生产 mutation。

同一根因连续两次无新证据时停止并返回 unresolved。不要通过弱化断言、删除测试、降低严重度或增加未要求功能关闭 finding。
```
