# 立体粒子圣诞树 · Christmas Tree

一个纯前端、零依赖的「3D 粒子圣诞树」页面。树体由数千颗光点构成，带螺旋灯串、彩球、顶部星光、三维飘雪、流星、点击星火与两级泛光，并配有金色节日标题。

- 手写 3D 透视投影（Canvas 2D），没有 Three.js 等任何外部依赖
- 自适应桌面 / 平板 / 手机，支持高像素密度屏幕
- 自动缓慢旋转；可拖动旋转（带惯性）、滚轮缩放
- 自动性能降级：帧率不足时减少泛光层数，效果仍然完整
- 尊重系统 `prefers-reduced-motion` 设置

## 文件结构

```
index.html                     页面结构、标题、SEO / 分享信息
style.css                      页面氛围层（暗角、颗粒、金色标题、响应式）
main.js                        粒子场景、三维投影、交互与渲染
christmas-tree-standalone.html 单文件版：CSS / JS 全部内联，不依赖任何路径
README.md                      本说明
```

三个文件放在同一目录即可，互相使用相对路径引用。若站点平台处理 `.js` / `.css` 资源不可靠，可直接部署 `christmas-tree-standalone.html`，它不需要任何配套文件。

## 部署

最简单：把整个目录上传到你的静态站点（任意子目录都可以），访问 `index.html`。

本地预览：

- 直接双击 `index.html` 也能运行；
- 或在目录内启动一个静态服务器，例如：

```bash
# Python
python -m http.server 8080

# Node
npx serve .
```

然后打开 <http://localhost:8080>。

Nginx / 静态托管（GitHub Pages、Vercel、Netlify、对象存储等）不需要任何额外配置。

## 交互

| 操作 | 效果 |
| --- | --- |
| 自动播放 | 圣诞树缓慢旋转 |
| 鼠标 / 手指拖动 | 旋转，松手后带惯性 |
| 滚轮 | 缩放（0.72× – 1.65×） |
| 点击 / 轻触空白处 | 迸发一簇金色星火 |
| 移动鼠标 / 手指 | 视角产生轻微俯仰与背景视差 |

## 自定义

所有常用参数集中在 `main.js` 顶部的 `CONFIG`：

```js
const CONFIG = {
  treeParticles: 3000,   // 树身光点数量
  lightCount: 340,       // 螺旋灯串数量
  ornamentCount: 72,     // 彩球数量
  snowCount: 520,        // 飘雪数量
  groundSparkles: 180,   // 地面积雪微光
  bgStars: 240,          // 背景星星
  turns: 5.2,            // 树身螺旋圈数
  arms: 8,               // 树身螺旋臂数量
  autoSpin: 0.16,        // 自动旋转速度（弧度/秒），设为 0 即停止
  bloomPasses: 2,        // 泛光层数
};
```

**换配色**：修改 `GREENS` / `LIGHTS` / `ORNAMENTS` / `SPARK_COLORS` 等颜色数组（RGB）。例如想做成「冰蓝圣诞树」，把 `GREENS` 换成蓝青色系即可。

**改标题**：编辑 `index.html` 里的 `.hero` 区块；年份会由脚本自动填入当年。不需要标题时，删除整个 `<main class="hero">…</main>` 即可。

**去掉某些元素**：在 `main.js` 中删除对应的生成循环，或把数量设为 0（`bgStars`、`snowCount`、`ornamentCount` 等）。

**性能**：若目标设备较弱，优先降低 `treeParticles`、`snowCount` 与 `bloomPasses`。页面自带帧率检测，低于约 48 FPS 时会自动减一层泛光，低于约 30 FPS 时关闭泛光（光点本身仍带辉光）。

## 部署排查：文字正常，但圣诞树不显示

页面里的标题是静态 HTML，圣诞树则完全由 `main.js` 创建 `<canvas>` 并逐帧绘制。所以「文字在、树不在」几乎一定是下面几类问题：

1. **`main.js` 没有加载成功**（最常见）
   - 部署时只上传了 `index.html`，或 `main.js` / `style.css` 不在同一目录；
   - 服务器区分大小写（Windows 本地不区分），实际文件名成了 `Main.js`；
   - 页面地址没有结尾斜杠，`./main.js` 被解析到了错误层级；
   - 域名下的安全策略（CSP）、错误的 MIME 类型（如 `text/plain`）、对象存储的 SPA 回退，都会让经典 `<script>` 被拒绝执行。
   - 排查：F12 → Network 里确认 `main.js` 是 200 且类型为 JavaScript；直接在浏览器打开 `你的域名/路径/main.js`，应显示 JS 源码而不是 404 页面或 HTML。

2. **站点平台过滤了 `<script>` 或 `<canvas>`**
   - 不少博客 / 建站平台的「HTML 组件」会自动删掉脚本、canvas 标签，只有文字留下。
   - 解决：把 `christmas-tree-standalone.html` 作为文件上传到站点，再用 iframe 嵌入：

   ```html
   <iframe src="/christmas/christmas-tree-standalone.html"
           style="width:100%;height:100vh;border:0;display:block"
           title="圣诞树"></iframe>
   ```

3. **画布被站点样式遮住**
   - 例如站点外层容器有不透明背景且层级更高。
   - 解决：使用独立页面或 iframe 嵌入，避免与站点全局 CSS / 层级冲突。

4. **浏览器缓存了旧的失败版本**
   - 先 Ctrl + Shift + R（手机端清除缓存 / 无痕窗口）再试。

另外，`main.js` 现在会在 DOM 就绪后启动；如果 `<canvas>` 被平台过滤掉，它会自己创建画布并补上全屏兜底样式。控制台出现 `[Christmas Tree] scene initialized` 表示脚本执行正常。

## 兼容性

- Chrome / Edge / Firefox / Safari 的现代版本
- 依赖 Canvas 2D、Pointer Events、`requestAnimationFrame`
- 泛光使用 `CanvasRenderingContext2D.filter`；不支持该特性的旧浏览器会自动跳过泛光，主体场景不受影响
- 移动端已适配安全区与窄屏，横屏过矮时会隐藏标题以免遮挡

## 许可

可自由用于个人或商业网站，无需署名。
