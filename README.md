# ChengIOS

iOS越狱插件，可按应用模拟iOS版本、应用版本及可选的设备/位置/网络/Wi-Fi信号。主要帮助旧设备运行要求更高iOS/应用版本的新应用。

需要已越狱的iPhone/iPad。编译需要[Theos](https://theos.dev/)和[AltList](https://github.com/opa334/AltList)。

## Sileo源

添加源：

```
https://raw.githubusercontent.com/vinhnv2507/ChengIfoIOS/gh-pages
```

然后搜索 **ChengIOS** (`com.vinhnv2507.chengios`)。有两个版本：

- Rootful: `iphoneos-arm`
- Rootless (Dopamine / palera1n): `iphoneos-arm64`

## 功能Hook

- `NSProcessInfo` / `UIDevice` iOS版本和版本号
- `sysctlbyname` `kern.osproductversion`, `kern.osversion`
- Safari风格的`NSURLRequest`、`NSURLSessionConfiguration`、WebKit的User-Agent
- `NSBundle`主应用的`CFBundleShortVersionString` / `CFBundleVersion`
- 设备名称、主机名、供应商ID、广告ID
- 型号（`UIDevice`、`uname`、`hw.machine`）如果已填写
- 区域设置、时区、运营商（默认关闭）
- `CLLocationManager`位置（固定坐标或GPX，默认关闭）
- `getifaddrs` IPv4/IPv6/MAC（尽力而为，默认关闭）
- Wi-Fi SSID/BSSID/网关通过`CNCopyCurrentNetworkInfo` / `NEHotspotNetwork`

屏幕尺寸不会被修改。

## 使用说明

打开主屏幕上的**ChengIOS**应用，或**设置 → ChengIOS**。

1. 保持**启用ChengIOS**开启。
2. 在**选择应用**中选择应用（列表1.0.1风格）或**伪装应用**。
3. 点击**随机生成设备信息**或**随机生成全部**，或进入**修改信息**手动填写。
4. 可选：启用伪装应用版本、区域设置、运营商、位置、网络/Wi-Fi。
5. 更改设置后强制关闭目标应用（或Respring）。

**随机生成设备信息**仅更改身份标识：型号、名称、主机名、iOS、版本号。**随机生成全部**额外添加区域设置、运营商、GPS、局域网、Wi-Fi和应用版本，全部匹配同一地区。

如果安装后看不到图标，Respring或运行`uicache -p /var/jb/Applications/ChengIOSApp.app`（rootless）/ `uicache -p /Applications/ChengIOSApp.app`（rootful）。

### 深度链接 / 快捷指令

添加**打开URL**操作：

- `chengios://random-identity` — 随机生成设备信息
- `chengios://random-all` — 随机生成全部
- `chengios://apps` — 打开选择应用
- `chengios://profile` — 查看当前配置
- `chengios://copy` — 复制配置
- `chengios://settings` — 打开设置
- `chengios://random-all?silent=1` — 随机生成全部，无提示
- `chengios://random-all?silent=1&norespring=1` — 随机生成全部，无提示，不Respring

别名：`random-info`、`info-may`、`toan-bo`、`hoso`、`prefs`。查询参数`mode=identity` / `mode=all`。

### 位置

需要**启用位置模拟**加纬度/经度，或可读GPX文件。

GPX点`trkpt`按`<time>`偏移重复，否则每秒一个点。

示例：`/var/mobile/Media/ChengIOS/route.gpx`

### 网络

需要**启用网络身份模拟**和至少IPv4、IPv6、MAC、SSID、BSSID之一。

默认接口`en0`。使用`*`表示除loopback外的所有接口。

当前iOS没有受支持的Wi-Fi MAC API。MAC hook不能保证完全覆盖。

## 编译

```bash
# rootful
make package FINALPACKAGE=1

# rootless
make clean
make package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
