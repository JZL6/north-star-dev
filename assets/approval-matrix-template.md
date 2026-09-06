# Approval Matrix — [Project/Epic]

> 只记录有权人作出的决定。代码 review、测试结果和 Agent 建议不是审批。

## 1. 权限来源

| 决策类型 | 所需角色/责任主体 | 权限来源 | 无法确认时状态 |
|---|---|---|---|
| Scope/Acceptance waiver | [角色] | [仓库/制度/用户说明] | `approval_blocked` |
| Architecture/Public contract | [角色] | [来源] | `approval_blocked` |
| Security/Privacy risk acceptance | [角色] | [来源] | `security_blocked` |
| Production release/rollback | [角色] | [来源] | `release_blocked` |

## 2. Approval 记录

| Approval ID | 类型/触发器 | 决策范围与目标修订 | 状态 | 有权角色/批准人 | 来源与时间 | 条件/到期 | Supersedes |
|---|---|---|---|---|---|---|---|
| APR-001 | [类型] | [范围 + revision] | `pending / approved / rejected / expired / superseded` | [角色/已知姓名] | [权威记录 + 时间] | [条件/期限] | [ID 或无] |

## 3. Release Readiness

| Gate | 状态 | 证据 | 责任人/下一步 |
|---|---|---|---|
| 构建、测试与审查 | [状态] | [修订 + 路径] | [角色] |
| Security/Privacy | [状态/不适用] | [Review/Approval ID] | [角色] |
| 迁移与回滚演练 | [状态/不适用] | [证据] | [角色] |
| 可观测性与停止指标 | [状态] | [证据] | [角色] |
| Production Release Authorization | `pending / approved / rejected / expired` | [APR-ID；覆盖环境、修订和动作] | [有权角色] |

## 4. 当前边界

- Code acceptance：[状态]
- Release readiness：[状态]
- Production mutation authorization：[状态]
- 未授权动作：[部署/迁移/配置/secret/开关/回滚等]
- 下一决策点：[内容]
