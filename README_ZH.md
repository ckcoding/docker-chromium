# Docker Chromium 中文版

基于 `jlesage/docker-chromium` 构建的**全功能汉化版** Chromium 浏览器 Docker 镜像。

## ✨ 特性
- 🇨🇳 **完全汉化**：界面、设置、右键菜单、VNC 控制面板均为中文。
- 🚀 **性能优化**：启用 GPU 加速渲染、零拷贝、多线程光栅化，流畅度大幅提升。
- 🔒 **安全访问**：支持 HTTPS、Web 认证（账号密码登录）。
- 📱 **多架构支持**：同时支持 **x86_64 (amd64)** 和 **ARM64** (Apple M1/M2, 树莓派等)。
- 🎨 **界面美化**：精简侧边栏，优化布局，移除冗余选项。
- 🖥️ **自动适配**：默认启用“远程调整”模式，浏览器窗口自动跟随网页大小。

## 📥 拉取镜像

```bash
docker pull ckcode/chromium:zh
```

## 🚀 快速启动

### Docker CLI

```bash
docker run -d \
    --name chromium-zh \
    -p 5800:5800 \
    -v $(pwd)/config:/config \
    --shm-size=256m \
    -e SECURE_CONNECTION=1 \
    -e WEB_AUTHENTICATION=1 \
    -e WEB_AUTHENTICATION_USERNAME=myuser \
    -e WEB_AUTHENTICATION_PASSWORD=mypassword \
    -e WEB_RESIZE=remote \
    ckcode/chromium:zh
```

> **注意**：请将 `myuser` 和 `mypassword` 替换为你自己的账号密码。

访问地址：`https://localhost:5800`

### Docker Compose

创建 `docker-compose.yml`：

```yaml
version: '3'
services:
  chromium:
    image: ckcode/chromium:zh
    container_name: chromium-zh
    ports:
      - "5800:5800"
    volumes:
      - ./config:/config
    environment:
      - SECURE_CONNECTION=1                  # 启用 HTTPS
      - WEB_AUTHENTICATION=1                 # 启用登录认证
      - WEB_AUTHENTICATION_USERNAME=myuser   # 用户名
      - WEB_AUTHENTICATION_PASSWORD=mypassword # 密码
      - WEB_RESIZE=remote                    # 窗口自动调整
      - LANG=zh_CN.UTF-8                     # 强制中文环境
    shm_size: 256m
    restart: unless-stopped
```

运行：
```bash
docker-compose up -d
```

## ⚙️ 环境变量说明

| 变量名 | 默认值 | 说明 |
|---|---|---|
| `SECURE_CONNECTION` | `0` | 设为 `1` 启用 HTTPS（推荐） |
| `WEB_AUTHENTICATION` | `0` | 设为 `1` 启用网页登录认证 |
| `WEB_AUTHENTICATION_USERNAME` | - | 网页登录用户名 |
| `WEB_AUTHENTICATION_PASSWORD` | - | 网页登录密码 |
| `WEB_RESIZE` | `remote` | 缩放模式：`remote`(远程调整), `scale`(本地缩放), `off`(无) |
| `CUSTOM_RES_W` | `1280` | 如果 `WEB_RESIZE` 为 `off`，设置默认宽度 |
| `CUSTOM_RES_H` | `720` | 如果 `WEB_RESIZE` 为 `off`，设置默认高度 |
| `ENABLE_CJK_FONT` | `1` | 启用中日韩字体支持（默认已开启） |

## 📁 挂载目录

| 路径 | 说明 |
|---|---|
| `/config` | 用户数据目录（包括浏览器配置、下载文件、日志等） |

## 🛠️ 常见问题

**1. 浏览器崩溃或页面显示 `Aw, Snap!`**
请确保添加了 `--shm-size=256m` 参数。Chromium 需要较大的共享内存，Docker 默认的 64m (Mac上可能是2G，但Linux上较小) 建议显式设置。

**2. 字体显示方框？**
镜像已内置 `font-noto-cjk` 中文字体。如果仍有问题，请检查 `LANG` 环境变量是否为 `zh_CN.UTF-8`。

**3. 如何下载文件？**
在浏览器内下载文件，默认会保存到容器内的 `/config/Downloads`。你可以在侧边栏（左侧箭头展开）的文件管理器中下载到本地。
