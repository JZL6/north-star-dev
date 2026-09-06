# Epic Writeback Prompt

```text
根据已通过独立审查的 Issue Closure，对 Epic、Project 和 Baseline 执行可重复的对账回写。

输入：
- Epic/Project/Baseline 当前路径与修订
- Issue、Delta-Spec、Delta-Design、Task、Verification、Closure 路径
- review 结果及当前源码修订

读取 references/epic-writeback.md 后：
1. 先核对 Closure、review 和实际证据，区分状态同步与规格更新。
2. 用稳定 ID 更新已有 Requirement、Decision、Question、Issue DAG 和证据，不追加同义条目。
3. 实现偏差分类为缺陷、已批准变更、待决策或冲突；未批准变化不能写入正式范围/验收。
4. 跨 Epic 长期结论写 Project/ADR；当前修订事实写 Baseline；Epic 保留本次需求完整认识。
5. 刷新受影响开放 Issue 的依赖、假设和 Context Pack。
6. 在 Closure 记录候选的 applied/no_change/needs_decision/conflict 及目标位置。

返回：变更文件、状态同步、规格更新或无需更新理由、未决候选、受影响 Issue 和下一 frontier Issue。
```
