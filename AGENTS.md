# AGENTS.md — 项目说明书（给 AI 读的）

> 任何人或任何 AI 接手这个项目，先读完本文再动代码。
> 最后更新：2026-11-23

## 1. 这是什么项目

个人站点 **meloveme.top**，两个页面：

| 页面 | 地址 | 内容 |
| --- | --- | --- |
| 首页 | `/` | 落地页：标题 + 进入圣诞树的入口 |
| 圣诞树 | `/tree` | 3D 粒子圣诞树，手写 Canvas 2D 投影，零依赖 |

技术栈：原生 HTML + CSS + JavaScript，**没有框架、没有构建、没有 npm 运行时依赖**。

## 2. 文件清单

| 文件 | 作用 | 能否删除 |
| --- | --- | --- |
| `index.html` | 首页结构，引用 `./home.css`，链接到 `./tree.html` | 不能（站点入口） |
| `home.css` | 首页样式 | 不能（被 index.html 引用） |
| `tree.html` | 圣诞树页面，**样式与脚本全部内联**，单文件自包含 | 不能 |
| `README.md` | 项目说明（面向人） | 保留 |
| `AGENTS.md` | 本文件（面向 AI） | 保留 |
| `CLAUDE.md` | 指向本文件的引用 | 保留 |
| `deploy.cmd` | 双击部署脚本 | 保留 |
| `wrangler.toml` / `package.json` | 部署工具配置 | 保留 |

**已删除的历史文件**：`main.js`、`style.css`（旧版外链结构，新页面已不引用），不要再创建同名文件。

## 3. 目录与命名约定

- 页面之间用**相对路径**：`./home.css`、`./tree.html`
- 新增图片放 `images/`，文件名**小写英文 + 数字 + 连字符**
- 禁止中文文件名和空格；路径一律用正斜杠 `/`

## 4. 代码规范

- 缩进 **2 空格**，不用 Tab
- 变量、函数 `camelCase`；常量全大写
- 类名 `kebab-case`，禁止内联样式（动态计算的值除外）
- **不引入任何外部依赖**：不加 CDN 脚本、字体外链、统计代码，除非用户明确要求
- `tree.html` 里的可调参数集中在脚本顶部的 `CONFIG` 对象，颜色在 `GREENS` / `LIGHTS` / `ORNAMENTS` / `SPARK_COLORS` 数组里，改效果只动这些位置

## 5. 线上环境

| 项 | 值 |
| --- | --- |
| 线上地址 | https://meloveme.top （备用：https://meloveme.rayrazan810.workers.dev） |
| 托管 | Cloudflare Workers 静态资源，Worker 名 `meloveme` |
| 代码仓库 | https://github.com/rayrazan517/mysite |
| 本地目录 | `D:\mysite` |
| 部署 | 双击 `deploy.cmd`，或 `npx wrangler deploy` |

**`git push` 只备份代码，不更新线上。上线必须单独部署。**

## 6. 硬性禁止

1. 不执行任何 `git` 命令（add / commit / push / checkout / merge / reset 全部禁止）
2. 不读取、不修改 `.git` 目录
3. 不删除用户没有明确要求删除的文件
4. 不引入外部依赖、CDN、第三方库、埋点脚本
5. 不擅自改名或移动文件（会破坏线上相对路径）
6. 不改 `AGENTS.md` / `CLAUDE.md` / `README.md`，除非任务就是改文档

## 7. 常见任务

### 改首页
改 `index.html`（结构）或 `home.css`（样式）。

### 改圣诞树
改 `tree.html`。树的效果参数在脚本顶部 `CONFIG`，配色在颜色数组里。**不要把它拆成外链 css/js**，它靠单文件自包含运行。

### 加新页面
新建 `xxx.html`，从别的页面用 `<a href="./xxx.html">` 链接过去；样式可内联或新建 `xxx.css`。

### 提升性能
按顺序调 `bloomPasses` → `snowCount` → `treeParticles`，每改一项在手机尺寸下验证不卡。

## 8. 完成标准（每次改完自检）

- [ ] 本地双击 `index.html`，首页正常，点入口能进 `tree.html`
- [ ] `tree.html` 里圣诞树能显示、能旋转
- [ ] `F12 → Console` 无红色报错
- [ ] 手机尺寸（375×667）下排版不重叠
- [ ] 没有新增任何外部网络请求

## 9. 给 AI 的开场白

```text
先读 AGENTS.md，理解项目结构和规范，然后等我提需求。
回复时先说明你打算改哪几个文件、为什么，再动手。
```
