# north-star-dev

North-Star Dev 是一种将分层规格（SDD）与测试驱动开发（TDD）编排为双层循环的工程方法，让复杂需求在持续推进中既不丢失整体方向，也不淹没在局部细节中。

## 核心特性

- **三层认知结构**：Project Spec（North Star）→ Epic Spec → Issue，保持全局认知同时局部聚焦
- **四轮迭代法**：环境验证 → 纵向打穿 → 横向扩展 → 纵深打磨，避免瀑布式过度设计
- **分层重构**：微重构（每条用例）→ 局部重构（每个 Issue）→ 全局重构（每轮结束）
- **主从 Agent 协作**：主 Agent 维护全局文档，subagent 聚焦单个 Issue 执行
- **上浮机制**：Issue 内发现的全局问题，定期上浮更新 Epic/Project Spec
- **变更管理**：变更影响分析 + 防腐层 + 回归测试网，支持已有项目多次大变更

## 适用场景

- 从 0 创建超大项目，需求不明确，需要逐步演进
- 已有大项目，需要进行多次大需求变更
- SE 下发的中间尺度工作（比 Task 大、比 Project 小）
- 多 Agent 协作完成大规模 TDD 测试体系建设

## 安装

### 自动安装（macOS / Linux）

```bash
curl -fsSL https://raw.githubusercontent.com/your-org/sdd-tdd-orchestrator/main/install.sh | sh
```

### 手动安装

1. 下载或克隆本仓库
2. 将 `sdd-tdd-orchestrator/` 文件夹复制到你的 AI Agent 的 skills 目录
   - Claude Code：`~/.claude/skills/`
   - Cursor：`~/.cursor/skills/`
   - Windsurf：`~/.config/windsurf/skills/`
   - Gemini CLI：`~/.gemini/skills/`

## 使用

在支持的 AI Agent 中输入：

```
/sdd-tdd-orchestrator [你的需求描述]
```

或自然语言触发：

```
帮我用 TDD 方式开发这个功能
我们有一个大需求，怎么用 Agent 协作推进？
这个项目需要补充测试体系，按 TDD 流程来
```

## 目录结构

```
sdd-tdd-orchestrator/
├── SKILL.md              # 核心技能定义（激活后加载）
├── AGENTS.md             # 配套执行指令
├── install.sh            # 跨平台安装脚本
├── README.md             # 本文件
├── references/
│   └── prompts.md        # 各阶段 Prompt 模板
├── assets/
│   ├── project-spec-template.md   # Project Spec 模板
│   ├── epic-spec-template.md      # Epic Spec 模板
│   └── issue-template.md          # Issue 模板
├── evals/
│   └── checklist.md      # 执行检查清单
└── .claude-plugin/
    └── plugin.json       # Claude Code 插件清单
```

## 工作流程概览

```
1. 初始化 Project Spec（North Star）
        ↓
2. 创建 Epic Spec（当前大需求完整认识）
        ↓
3. 按四轮迭代拆分 Issue
   ├─ 第 0 轮：环境验证
   ├─ 第 1 轮：纵向打穿（验证架构）
   ├─ 第 2 轮：横向扩展（填充功能）
   └─ 第 3 轮：纵深打磨（提升质量）
        ↓
4. 逐个派发 Issue 给 subagent
   每个 Issue：调查 → 设计 → TDD 循环 → 验证 → 交接
        ↓
5. 每轮结束：全局回归 + 待上浮项处理 + 待重构清单处理
        ↓
6. 更新 Epic Spec / Project Spec，进入下一轮或下一个 Epic
```

## 设计理念

> 完整需求不必一次做完，但每一次推进，都应该重新回到整体之中。

- **不做瀑布**：不要一开始就生成完整设计文档，按轮次逐步展开
- **不重复文档**：每层只写自己该写的，引用不复制
- **不硬扛全局问题**：Issue 内发现的问题，上浮处理
- **不积累技术债**：分层重构，到点必须处理
- **不跳过验证**：环境验证和架构打穿先行，降低返工成本

## License

MIT
