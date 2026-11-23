# CLAUDE.md

本项目的完整说明在 [AGENTS.md](./AGENTS.md)，请先读它再动手。

要点速览：

- 纯静态站：`index.html` + `style.css` + `main.js`，无框架、无构建、无依赖
- 渲染是 Canvas 2D 手写 3D 投影，不要引入 Three.js 或任何外部库
- 可调参数集中在 `main.js` 顶部 `CONFIG`，颜色在 `GREENS` / `LIGHTS` / `ORNAMENTS` / `SPARK_COLORS`
- 禁止执行 git 命令、禁止改文件名、禁止删除现有文件
- 线上：https://meloveme.top （Cloudflare Workers 静态托管）

@AGENTS.md
