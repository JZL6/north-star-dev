# Light SDD+TDD Change — [名称]

> 小改动的合并记录。逻辑阶段全部执行，低价值的独立文件合并在此。

## Identity

- Change/Issue ID：`CHANGE-[ID]`
- Fixed point：[commit/快照]
- 状态：`exploring / specifying / implementing / verifying / reviewing / review_blocked / security_blocked / approval_blocked / release_blocked / accepted_for_code / closed / blocked`
- Review Manifest：[路径；轻量变更也必须覆盖 untracked 和既有脏改动]

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
- Security/Privacy applicability：[not_applicable/applicable/unknown + 理由]

## Delta Design

- 责任模块与公共 seam：[内容]
- 复用/新建理由和 deletion test：[证据]
- Change budget：[模块、interface、依赖]
- Test Charter：[oracle、层级、高风险维度]
- 重构/兼容/回滚：[内容或不适用理由]
- 安全/隐私：[数据分类、信任边界、权限、egress、控制或不适用理由]
- 注释策略：[必要 why；陈旧/翻译器/TODO 处置]
- 审批/发布边界：[触发器、Approval ID 或不适用]

## Task & TDD Evidence

| Slice | Check/Test | Red 原因 | Green 结果 | 验证 |
|---|---|---|---|---|
| S-001 | [ID] | [预期失败] | [最小实现] | [命令/证据] |

## Review Manifest

- 初始 staged/unstaged/untracked：[文件或无]
- Before snapshot：[路径/哈希；干净工作区可使用 fixed commit]
- 当前新增/修改/删除：[完整清单]
- Issue 归属和 diff/内容入口：[逐文件证据]
- 完整性结论：[PASS/uncertain + 原因]

## Verification & Independent Review

- Requirement/Test Depth：[覆盖及缺口]
- 命令与结果：[证据]
- Spec / Project Fit / Test Quality review：[轮次、finding、修复、最终结论]
- Comment Quality：[必要性、准确性、TODO 退出条件与结论]
- Security/Privacy Review：[适用性、独立结论、finding、残余风险和 Approval ID]
- Approval/Release：[代码验收、发布准备、生产授权和实际发布分别记录]
- 技术债处置：[内容或无]

## Closure & Writeback

- 最终结果与偏差：[内容]
- Epic/Project/Baseline 回写：[应用位置或无需更新理由]
- 后续影响：[Issue/风险或无]
- Closure：`accepted_for_code / accepted / blocked / security_blocked / approval_blocked / release_blocked`

轻量档位只合并记录，不降低门禁。没有覆盖当前环境、修订和动作的明确 Release Approval 时，不执行生产 mutation，也不写成已发布。
