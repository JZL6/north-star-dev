# Light SDD+TDD Change — [名称]

> 小改动的合并记录。逻辑阶段全部执行，低价值的独立文件合并在此。

## Identity

- Change/Issue ID：`CHANGE-[ID]`
- Fixed point：[commit/快照]
- 状态：`exploring / specifying / implementing / verifying / reviewing / closed / blocked`

## Explore & Grill

- 现有行为与代码证据：[路径/测试]
- 已有同类能力与复用决定：[内容]
- 用户目标与必要决定：[内容；无需提问时说明]

## Epic Summary & Delta Spec

- 业务结果：[结果]
- 范围/非目标：[内容]
- Requirement/Delta：[ID + 行为变化]
- Acceptance Examples：[Given/When/Then 或等价描述]
- 必须保持的行为：[内容]

## Delta Design

- 责任模块与公共 seam：[内容]
- 复用/新建理由和 deletion test：[证据]
- Change budget：[模块、interface、依赖]
- Test Charter：[oracle、层级、高风险维度]
- 重构/兼容/回滚：[内容或不适用理由]

## Task & TDD Evidence

| Slice | Check/Test | Red 原因 | Green 结果 | 验证 |
|---|---|---|---|---|
| S-001 | [ID] | [预期失败] | [最小实现] | [命令/证据] |

## Verification & Independent Review

- Requirement/Test Depth：[覆盖及缺口]
- 命令与结果：[证据]
- Spec / Project Fit / Test Quality review：[轮次、finding、修复、最终结论]
- 技术债处置：[内容或无]

## Closure & Writeback

- 最终结果与偏差：[内容]
- Epic/Project/Baseline 回写：[应用位置或无需更新理由]
- 后续影响：[Issue/风险或无]
- Closure：`accepted / blocked`
