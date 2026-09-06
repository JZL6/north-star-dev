# Security & Privacy Review — [Issue 名称]

## 0. 身份与范围

- Issue：`ISSUE-[ID]`
- Reviewer：[未参与实现的 Agent/人员]
- Fixed point / Current revision：[标识]
- Review Manifest：[路径]
- Applicability：`not_applicable / applicable / unknown`
- 状态：`draft / pass / security_blocked`

## 1. 数据与信任边界

| 资产/数据 | 分类 | 来源与去向 | 信任边界 | 最小化/保留 | 证据或缺口 |
|---|---|---|---|---|---|
| [内容] | [分类] | [流向] | [边界] | [策略] | [路径/未知] |

## 2. 威胁与隐私风险

| Finding ID | Severity | 场景/攻击或误用路径 | 影响 | 现有控制 | 证据 | 处置 |
|---|---|---|---|---|---|---|
| SEC-001 | `blocker / major / minor / note` | [内容] | [影响] | [控制] | [路径/测试] | [修复/Approval ID] |

## 3. 控制与验证

| 检查项 | 结论 | 测试/扫描/审查证据 | 缺口或不适用理由 |
|---|---|---|---|
| Authn/Authz/最小权限 | [结论] | [证据] | [内容] |
| 输入/解析/资源边界 | [结论] | [证据] | [内容] |
| 凭据/加密/敏感日志 | [结论] | [证据] | [内容] |
| 数据最小化/保留/删除/egress | [结论] | [证据] | [内容] |
| 依赖/生成内容/Prompt Injection | [结论] | [证据] | [内容] |
| 故障安全/审计/恢复 | [结论] | [证据] | [内容] |

## 4. 残余风险与审批

- 未解决风险：[Finding ID 或无]
- 风险接受 Approval ID：[ID 或无；Agent 不得自批]
- 审批范围与源码修订：[内容]
- 结论：`PASS / SECURITY_BLOCKED`
- 阻止 Closure 的原因：[内容或无]
