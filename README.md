# 立体粒子圣诞树 · Christmas Tree

一个纯前端、零依赖的「3D 粒子圣诞树」页面。树体由数千颗光点构成，带螺旋灯串、彩球、顶部星光、三维飘雪、流星、点击星火与两级泛光，并配有金色节日标题。

- 手写 3D 透视投影（Canvas 2D），没有 Three.js 等任何外部依赖
- 自适应桌面 / 平板 / 手机，支持高像素密度屏幕
- 自动缓慢旋转；可拖动旋转（带惯性）、滚轮缩放
- 自动性能降级：帧率不足时减少泛光层数，效果仍然完整
- 尊重系统 `prefers-reduced-motion` 设置

## 文件结构

```
index.html    页面结构、标题、SEO / 分享信息
style.css     页面氛围层（暗角、颗粒、金色标题、响应式）
main.js       粒子场景、三维投影、交互与渲染
README.md     本说明
```

三个文件放在同一目录即可，互相使用相对路径引用。

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

## 兼容性

- Chrome / Edge / Firefox / Safari 的现代版本
- 依赖 Canvas 2D、Pointer Events、`requestAnimationFrame`
- 泛光使用 `CanvasRenderingContext2D.filter`；不支持该特性的旧浏览器会自动跳过泛光，主体场景不受影响
- 移动端已适配安全区与窄屏，横屏过矮时会隐藏标题以免遮挡

## 许可

可自由用于个人或商业网站，无需署名。
