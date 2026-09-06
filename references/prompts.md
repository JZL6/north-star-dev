# 可派发 Prompt 索引

主 Agent 按阶段读取对应模板，替换方括号字段后派发。每次必须填写仓库根目录、Review Manifest（适用时）和执行预算；文件路径和稳定 ID 优先于粘贴长文。subagent 可以沿路径读取必要上下文，但只能在声明的写入范围内行动。

| 阶段 | Prompt | 建议执行者 |
|---|---|---|
| Brownfield/Greenfield 调查 | [prompts/explore.md](prompts/explore.md) | 只读调查 subagent；主 Agent 汇总 |
| Issue 实现 | [prompts/implement-issue.md](prompts/implement-issue.md) | 一个实现 subagent 或主 Agent |
| 独立 Spec 审查 | [prompts/review-spec.md](prompts/review-spec.md) | 未参与实现的审查 subagent |
| 独立工程与测试审查 | [prompts/review-quality.md](prompts/review-quality.md) | 未参与实现的审查 subagent |
| 单 reviewer 综合审查 | [prompts/review-issue.md](prompts/review-issue.md) | 只有一个审查槽位时使用 |
| 条件性安全与隐私审查 | [prompts/review-security.md](prompts/review-security.md) | 未参与实现的安全审查 subagent |
| 修复审查问题 | [prompts/fix-findings.md](prompts/fix-findings.md) | 原实现者或有明确 Context Pack 的修复者 |
| Verification | [prompts/verify-issue.md](prompts/verify-issue.md) | 独立验证 subagent 或主 Agent |
| Epic 回写 | [prompts/writeback-epic.md](prompts/writeback-epic.md) | 主 Agent；可派只读候选提取 |

Grill、风险接受、范围豁免和生产发布授权是主 Agent 与有权人员之间的决策过程，不能让 subagent 代替人类回答或批准。事实问题可以先用 Explore prompt 调查。

所有 subagent 返回：状态、读取与修改的文件、实际证据、未完成项、越界风险、预算使用和建议下一步。报告不是事实；主 Agent 必须核对工作区和验证结果。预算规则见 [execution-budgets.md](execution-budgets.md)。
