# AGENTS.md — 项目说明书（给 AI 读的）

> 任何人或任何 AI 接手这个项目，先读完本文再动代码。
> 最后更新：2026-11-23

## 1. 这是什么项目

一个**纯前端、零依赖**的 3D 粒子圣诞树页面，作为个人站点 meloveme.top 的首页。

- 技术栈：原生 HTML + CSS + JavaScript（ES6+），**没有框架、没有构建、没有 npm 依赖**
- 渲染：手写 3D 透视投影，画在 Canvas 2D 上，**不使用 Three.js 或任何外部库**
- 交互：自动旋转、拖拽旋转（带惯性）、滚轮缩放、点击迸发星火、鼠标视差
- 自适应：桌面 / 平板 / 手机，支持高像素密度屏
- 性能：内置帧率检测，不足时自动降级泛光层
- 无障碍：尊重系统 `prefers-reduced-motion`

## 2. 文件清单（当前仓库根目录）

| 文件 | 作用 | 能否删除 |
| --- | --- | --- |
| `index.html` | 页面结构、标题、SEO / 分享 meta | 不能（站点入口） |
| `style.css` | 氛围层：暗角、颗粒、金色标题、响应式 | 不能（被 index.html 引用） |
| `main.js` | 粒子场景、三维投影、交互、渲染循环 | 不能（被 index.html 引用） |
| `README.md` | 项目说明（面向人） | 保留 |
| `AGENTS.md` | 本文件（面向 AI） | 保留 |
| `CLAUDE.md` | 指向本文件的引用 | 保留 |

**已知不一致**：`README.md` 提到 `christmas-tree-standalone.html`（单文件内联版），但仓库里没有这个文件。要么补上，要么在 README 里删掉相关段落——**动手前先问我，不要擅自删除 README 内容**。

## 3. 目录与命名约定

- 三份代码文件必须**在同一目录**，互相用**相对路径**引用：`./style.css`、`./main.js`
- 新增图片放 `images/`，新增页面放根目录或 `pages/`
- 文件名一律**小写英文 + 数字 + 连字符**，禁止中文和空格
- 引用路径用正斜杠 `/`，不要用反斜杠

## 4. 代码规范

- 缩进 **2 空格**，不用 Tab
- 字符串统一用单引号；HTML 属性用双引号
- 变量、函数用 `camelCase`；常量全大写
- CSS 类名用连字符式 `kebab-case`，禁止内联样式（除了动态写入的 canvas 尺寸）
- **不引入任何外部依赖**：不加 CDN 脚本、不加字体外链、不加统计代码，除非用户明确要求
- 所有可调参数集中在 `main.js` 顶部的 `CONFIG` 对象里，不要散落在代码中
- 颜色集中在 `GREENS` / `LIGHTS` / `ORNAMENTS` / `SPARK_COLORS` 等数组里，改色只改这些数组

## 5. 常用参数位置

`main.js` 顶部 `CONFIG`：

| 键 | 含义 |
| --- | --- |
| `treeParticles` | 树身光点数量（性能首要开关） |
| `lightCount` | 螺旋灯串数量 |
| `ornamentCount` | 彩球数量 |
| `snowCount` | 飘雪数量 |
| `bgStars` | 背景星星 |
| `autoSpin` | 自动旋转速度，设 0 停止 |
| `bloomPasses` | 泛光层数，弱设备降到 1 或 0 |

## 6. 线上环境

| 项 | 值 |
| --- | --- |
| 线上地址 | https://meloveme.top （备用：https://meloveme.rayrazan810.workers.dev） |
| 托管 | Cloudflare Workers 静态资源，Worker 名 `meloveme` |
| DNS | Cloudflare 托管，域名 NS 已指向 CF |
| 代码仓库 | https://github.com/rayrazan517/mysite |
| 本地目录 | `D:\mysite` |
| 部署方式 | 手动：Cloudflare 后台「新部署」拖文件；或命令行 `npx wrangler deploy`（需 API Token） |

**注意：`git push` 只备份代码，不会更新线上。上线必须单独部署。**

## 7. 硬性禁止

1. 不执行任何 `git` 命令（add / commit / push / checkout / merge / reset 全部禁止），版本操作由用户手工完成
2. 不读取、不修改 `.git` 目录
3. 不删除我没有明确要求删除的文件
4. 不引入外部依赖、CDN、第三方库、埋点脚本
5. 不改动 `AGENTS.md` / `CLAUDE.md` / `README.md` 的内容，除非任务就是改文档
6. 不擅自改文件名和目录结构（会破坏线上相对路径引用）

## 8. 常见任务的标准做法

### 加一个新页面
1. 新建 `xxx.html`，复用 `index.html` 的 `<head>` 结构
2. 在 `index.html` 加入口链接 `<a href="./xxx.html">`
3. 新页面自己引用 `./style.css`，可另加 `./xxx.css`

### 换配色
只改 `main.js` 顶部的颜色数组，不要改渲染逻辑。改完在浏览器里确认：树的绿、灯串、彩球、星火四类颜色都协调。

### 提升性能
按顺序调：`bloomPasses` → `snowCount` → `treeParticles`。每改一项都要在手机尺寸下验证不卡。

### 加交互
在 `main.js` 已有的事件监听（`pointerdown` / `pointermove` / `wheel`）附近追加，不要新建重复的全局监听。

## 9. 完成标准（每次改完必须自检）

- [ ] 本地双击 `index.html` 打开，页面正常、树能显示、能动
- [ ] `F12 → Console` 无红色报错
- [ ] `F12 → Network` 中 `main.js` / `style.css` 都是 200
- [ ] 手机尺寸（F12 设备模式 375×667）下排版不重叠、不溢出
- [ ] 改动没有引入任何新的外部网络请求

## 10. 给 AI 的开场白模板

```text
先读 AGENTS.md，理解项目结构和规范，然后等我提需求。
回复时先说明你打算改哪几个文件、为什么，再动手。
```

提需求时按这个格式写，效果最好：

```text
任务：<一句话目标>
约束：<不能改什么、不能引入什么>
验收：<怎么判断做对了>
```
