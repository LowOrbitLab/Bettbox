<h4 align="right">
  <strong>简体中文</strong> | <a href="README_en.md">English</a> | <a href="README_ru.md">Русский</a> | <a href="README_fa.md">فارسی</a> | <a href="README_ja.md">日本語</a> | <a href="README_ko.md">한국어</a>
</h4>

# Bettbox

A multi-platform proxy client powered by the Mihomo / Clash Meta core.

This repository provides maintained build workflows, Android APK artifacts, desktop build support, and upstream synchronization for Bettbox-based clients.

**Bettbox 是一款使用Mihomo(Clash Meta)内核、基于FlClash早期版本进行重构的多平台网络调试及分流客户端**

## Features

- Mihomo / Clash Meta based proxy core
- Android and desktop platform support
- Reproducible build workflows through GitHub Actions
- Multi-ABI Android APK artifacts
- Android TV and legacy-device compatibility work
- Release signing and verification notes
- Selected upstream synchronization and compatibility adjustments

## Platforms

### Android

The Android build flow focuses on APK artifact generation, signing verification, and compatibility across common device targets.

Supported build targets include:

- `arm64-v8a`
- `armeabi-v7a`
- `x86_64`
- `universal`

For signing policy notes, see [`SIGNING-POLICY.md`](SIGNING-POLICY.md).

### Desktop

**简评** : ❚ 相对性价比不错，21元/1000GB/不限时套餐 值得推荐，群友反馈口碑尚可; 需要注意: 机场服务与Bettbox软件无直接关联，最终效果请自行判定

---

## 🛠️ 安装与下载

请前往 **[[Releases]](https://github.com/appshubcc/Bettbox/releases)** 页面下载最新适合您平台和系统的安装包


* **全平台桌面端**: **Windows** (x64/arm64), **macOS** (Intel/Apple Silicon), **Linux** (x64/arm64)
* **Android 端**: Android (ARMv8/ ARMv7/ x86_64/ Universal)
* **Android TV**: 已完整适配,可选ARMv7 32位
* **鸿蒙 NEXT**: 请配合 [[卓易通]](https://harmonyos.cool/android-app) 使用

**其他安装方式:**<br>
**ArchLinux:** <code>yay -S bettbox-bin 或 paru -S bettbox-bin</code><br>
**AMD64=v1:** <code>yay -S bettbox-compatible-bin 或 paru -S bettbox-compatible-bin</code>

---

## 🚀 核心特性

* **开箱即用**：稳定的权限处理与舒适的 TUN/VPN 体验，大量预置优化与细节，开箱即达可用状态。
* **精雕细琢**：打磨每处 UI 与功能交互细节，前台高帧率动画流畅，移动端低能耗，桌面端低占用。
* **安全守护**：内核紧跟 Mihomo 主线分支且积极适配最新特性，多平台保持严格的权限控制与校验。
* **稳定容错**：优化多平台极端场景下的稳定性，内置YAML格式验证和提前预解析双重错误检测机制。
* **性能优先**：桌面端原生 ARM64 架构支持，提供硬件分级和 Flutter 整体优化, 充分发挥硬件性能。
* **增强工具**：首个多平台无感智能启停、Android端休眠支持、一键禁用QUIC、托盘菜单增强等等。
* **可视化设置**：提供丰富参数的可视化调节界面，支持改动即时生效，无需繁琐修改配置。
* **首页小组件**：内置多款精致 Widget 小组件，在首页直观掌控实时网速与全局运行状态。
* **个性化定制**：支持丰富色彩主题、自定义图标/标题等，甚至还包含 10 种精美测速动画。
* **设备兼容**：持续维护面向旧版系统及老旧硬件的 Compatible 兼容版本，延长设备使用周期。
* **零隐私风险**：开源、无广告，全透明的 CI/CD 流程且接受全方位审计，杜绝后台隐私收集。
* **社区导向**：我们会认真评估社区反馈，优先对待高质量的 Issue，你的声音不会无故被淹没。

---

##  常见问题

1.  **安装启动及安全问题**：
   - 安卓端设备，请检查**是否授予了充足的后台权限及满足最低系统要求**:Android 8.0+
   - 桌面端旧设备，请检查系统平台架构**是否需要下载特定CPU等级的Compatible版本**
   - **安全问题：Bettbox 项目完全开源透明，当前代码已通过 Signpath 基金会安全审计**

2.  **桌面端常见问题**：
   - Windows管理员权限：Bettbox在安装时已提前处理，**无需手动再次授权**
   - 无法开启TUN虚拟网卡：macOS和Linux**请确保输入正确密码给与权限授权**
   - 其他报错：请提供Debug信息，并**确保没有冲突的代理软件或服务正在运行**
   - 其他问题如持续存在，请提交ISSUE反馈

3.  **macOS安装教程**：
   - 根据所属平台(Intel/Apple Silicon)下载完成后，双击打开 Bettbox-macos-xx.dmg 文件
   - 将 Bettbox 图标拖拽至 Applications（应用程序）文件夹中即可完成安装
   - **首次运行避开系统安全拦截**（由于当前暂未购买 Apple 开发者证书）：
     - **推荐**：进入“应用程序”文件夹，**右键 Bettbox 图标**，选择 **“打开”**，在确认弹窗中再次点击 **“打开”** 即可
     - **备选**：如果直接双击被阻止，请前往 Mac 系统“设置” -> “隐私与安全性”，找到 Bettbox 并点击 **“仍要打开”**
   - 首次开启 TUN 模式时，系统会弹出密码授权窗口，请输入当前用户密码以允许 Bettbox 配置网络
   - **如果提示“已损坏，打不开，移到废纸篓”**：
     - 这是 macOS 针对未签名软件的安全机制误报。请打开终端（Terminal），运行以下命令以解除隔离：
       ```bash
       xattr -d com.apple.quarantine /Applications/Bettbox.app
       ```

4.  **无法导入订阅链接**：
   - **请务必先尝试重置链接**，确保链接正常后再导入
   - **确保导入的是Clash（Mihomo）格式**的订阅链接
   - 其他问题如持续存在，请提交ISSUE反馈

5.  **待持续完善补充..**

---

##  开发构建

以 Windows 为例：

* 你需要一台 Windows 设备（系统 ≥ Windows 10）
* 其他必要环境：Git，Visual Studio，Flutter 3.44.x，Golang，Inno Setup，Rust
* flutter pub get (获取相关依赖)
* dart .\setup.dart windows --arch amd64 --out core (仅构建Core核心)
* dart .\setup.dart windows --arch amd64 --out app --compatible (可选兼容版本)
* 构建完成后，最终产物位于 `dist/` 目录

---

Desktop support follows the upstream Bettbox direction:

- Windows x64 / arm64
- macOS Intel / Apple Silicon
- Linux x64 / arm64

Concrete build commands should follow the active CI workflows and maintenance branches in this repository.

## Technical Base

- [Mihomo](https://github.com/MetaCubeX/mihomo) — Clash Meta core
- [FlClash](https://github.com/chen08209/FlClash) — original GUI foundation
- [Bettbox](https://github.com/appshubcc/Bettbox) — upstream source base

Other referenced projects include CMFA, Sparkle, SFA, HUSI, V2rayN, and related open-source clients.

## License

This project follows the upstream license and is distributed under the GPL-3.0 License.

##  致谢

**[FlClash GUI](https://github.com/chen08209/FlClash)** - **[Mihomo Core](https://github.com/MetaCubeX/mihomo)**

* Bettbox项目的 Windows 数字签名由 **[SignPath](https://signpath.io)** 提供，代码已通过安全审查
* 衷心感谢 **SignPath 基金会 (SignPath Foundation)** 对开源社区的大力支持

其他开源项目参考(以时间排序)：

[CMFA](https://github.com/MetaCubeX/ClashMetaForAndroid), [Sparkle](https://github.com/xishang0128/sparkle), [SFA](https://github.com/SagerNet/sing-box-for-android), [HUSI](https://github.com/xchacha20-poly1305/husi), [V2rayN](https://github.com/2dust/v2rayN)

---

## 📄 开源协议

GPL-3.0 license 开源协议
