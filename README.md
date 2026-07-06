# Bettbox

A multi-platform proxy client powered by the Mihomo / Clash Meta core.

This repository provides maintained build workflows, Android APK artifacts, desktop build support, and upstream synchronization for Bettbox-based clients.

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
