#import "RootViewController.h"
#import "AppListViewController.h"
#import "DeeplinkListViewController.h"
#import "RegionListViewController.h"
#import "BackupListViewController.h"
#import "../ChengIOSPrefs/ChengIOSProfiles.h"

#import <spawn.h>
#import <unistd.h>
#import <string.h>

extern char **environ;

@interface RootViewController () <UITextFieldDelegate>
@property (nonatomic, copy) NSArray<NSArray<NSDictionary *> *> *schema;
@property (nonatomic, copy) NSString *summary;
@end

@implementation RootViewController

- (NSArray<NSString *> *)schemeExamples {
    return @[
        @"chengios://random-identity",
        @"chengios://random-all",
        @"chengios://apps",
        @"chengios://profile",
        @"chengios://copy",
        @"chengios://settings",
        @"chengios://random-all?silent=1",
        @"chengios://erase-random-all",
        @"chengios://erase-device-random",
        @"chengios://backup-erase-random"
    ];
}

- (NSArray<NSArray<NSDictionary *> *> *)buildSchema {
    return @[
        @[
            @{@"kind": @"button", @"title": @"随机生成设备信息", @"action": @"identity"},
            @{@"kind": @"button", @"title": @"随机生成全部", @"action": @"full"},
            @{@"kind": @"button", @"title": @"查看配置", @"action": @"profile"},
            @{@"kind": @"button", @"title": @"复制配置", @"action": @"copy"},
            @{@"kind": @"nav", @"title": @"按地区随机生成", @"page": @"region", @"detail": @"越南 / 美国 / 韩国 / 日本"},
            @{@"kind": @"nav", @"title": @"深度链接 / 快捷指令", @"page": @"deeplink", @"detail": @"chengios://"}
        ],
        @[
            @{@"kind": @"nav", @"title": @"备份管理", @"page": @"backup", @"detail": @"备份 / 恢复 / 清除数据"},
            @{@"kind": @"button", @"title": @"备份配置", @"action": @"backupProfile"},
            @{@"kind": @"button", @"title": @"备份配置+应用数据", @"action": @"backupApps"},
            @{@"kind": @"button", @"title": @"备份+清除+随机+Respring", @"action": @"backupEraseRandom"},
            @{@"kind": @"button", @"title": @"清除已选应用数据", @"action": @"eraseApps"},
            @{@"kind": @"button", @"title": @"清除已选+随机生成全部", @"action": @"eraseRandomAll"},
            @{@"kind": @"button", @"title": @"清除全部+随机生成全部", @"action": @"eraseDeviceRandom"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"启用ChengIOS", @"key": @"masterEnabled", @"defaultOn": @YES},
            @{@"kind": @"switch", @"title": @"深度伪装", @"key": @"gestaltEnabled", @"defaultOn": @NO, @"detail": @"Facebook/Shopee跳过Gestalt"},
            @{@"kind": @"switch", @"title": @"隐藏越狱", @"key": @"hideJailbreakEnabled", @"defaultOn": @NO, @"detail": @"隐藏Cydia/Sileo/ElleKit"}
        ],
        @[
            @{@"kind": @"nav", @"title": @"选择应用", @"detail": @"Shopee仅清除数据"}
        ],
        @[
            @{@"kind": @"text", @"title": @"型号", @"keys": @[@"spoofedModel", @"customDeviceModel"], @"placeholder": @"iPhone16,2"},
            @{@"kind": @"text", @"title": @"名称", @"keys": @[@"spoofedName", @"customDeviceName"], @"placeholder": @"iPhone"},
            @{@"kind": @"text", @"title": @"iOS", @"keys": @[@"spoofedSystemVersion", @"customOSVersion"], @"placeholder": @"18.6.1"},
            @{@"kind": @"text", @"title": @"版本号", @"keys": @[@"spoofedBuild", @"customBuildNumber"], @"placeholder": @"22G100"},
            @{@"kind": @"text", @"title": @"主机名", @"keys": @[@"spoofedHostname", @"customHostName"], @"placeholder": @"iPhone.local"},
            @{@"kind": @"info", @"title": @"User-Agent", @"keys": @[@"spoofedUserAgent"]}
        ],
        @[
            @{@"kind": @"switch", @"title": @"使用自定义iOS版本", @"key": @"useCustomOSVersion", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"自定义版本", @"keys": @[@"customOSVersion", @"spoofedSystemVersion"], @"placeholder": @"18.6.1"},
            @{@"kind": @"text", @"title": @"自定义版本号", @"keys": @[@"customBuildNumber", @"spoofedBuild"], @"placeholder": @"22G100"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装应用版本", @"key": @"appVersionEnabled", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"应用版本", @"keys": @[@"customAppVersion"], @"placeholder": @"3.2.1"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装名称/主机名/ID", @"key": @"deviceIdentityEnabled", @"defaultOn": @NO}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装区域设置", @"key": @"localeEnabled", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"区域", @"keys": @[@"localeIdentifier"], @"placeholder": @"vi_VN"},
            @{@"kind": @"text", @"title": @"时区", @"keys": @[@"timeZoneName"], @"placeholder": @"Asia/Ho_Chi_Minh"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装运营商", @"key": @"carrierEnabled", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"运营商", @"keys": @[@"carrierName"], @"placeholder": @"Viettel"},
            @{@"kind": @"text", @"title": @"MCC", @"keys": @[@"mobileCountryCode"], @"placeholder": @"452"},
            @{@"kind": @"text", @"title": @"MNC", @"keys": @[@"mobileNetworkCode"], @"placeholder": @"04"},
            @{@"kind": @"text", @"title": @"ISO", @"keys": @[@"isoCountryCode"], @"placeholder": @"vn"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装位置", @"key": @"locationEnabled", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"纬度", @"keys": @[@"latitude"], @"placeholder": @"10.762"},
            @{@"kind": @"text", @"title": @"经度", @"keys": @[@"longitude"], @"placeholder": @"106.660"},
            @{@"kind": @"text", @"title": @"海拔", @"keys": @[@"altitude"], @"placeholder": @"10"},
            @{@"kind": @"text", @"title": @"精度", @"keys": @[@"accuracy"], @"placeholder": @"12"},
            @{@"kind": @"text", @"title": @"GPX路径", @"keys": @[@"gpxPath"], @"placeholder": @"/var/mobile/Media/ChengIOS/route.gpx"}
        ],
        @[
            @{@"kind": @"switch", @"title": @"伪装网络/Wi-Fi", @"key": @"networkEnabled", @"defaultOn": @NO},
            @{@"kind": @"text", @"title": @"接口", @"keys": @[@"interfaceName"], @"placeholder": @"en0"},
            @{@"kind": @"text", @"title": @"IPv4", @"keys": @[@"ipv4Address"], @"placeholder": @"192.168.1.20"},
            @{@"kind": @"text", @"title": @"IPv6", @"keys": @[@"ipv6Address"], @"placeholder": @"2001:db8::1"},
            @{@"kind": @"text", @"title": @"MAC", @"keys": @[@"macAddress", @"wifiAddress"], @"placeholder": @"02:00:00:00:00:01"},
            @{@"kind": @"text", @"title": @"SSID", @"keys": @[@"wifiSSID"], @"placeholder": @"Viettel-5G"},
            @{@"kind": @"text", @"title": @"BSSID", @"keys": @[@"wifiBSSID"], @"placeholder": @"50:c7:bf:12:34:56"},
            @{@"kind": @"text", @"title": @"网关", @"keys": @[@"wifiGateway"], @"placeholder": @"192.168.1.1"},
            @{@"kind": @"text", @"title": @"RSSI", @"keys": @[@"wifiRSSI"], @"placeholder": @"-52"}
        ],
        @[
            @{@"kind": @"text", @"title": @"主板", @"keys": @[@"hwModelStr"], @"placeholder": @"D84AP"},
            @{@"kind": @"text", @"title": @"芯片", @"keys": @[@"hardwarePlatform"], @"placeholder": @"t8130"},
            @{@"kind": @"text", @"title": @"序列号", @"keys": @[@"spoofedSerialNumber"], @"placeholder": @"C02XXXXXX"},
            @{@"kind": @"text", @"title": @"UDID", @"keys": @[@"spoofedUniqueDeviceID"], @"placeholder": @"40-hex"},
            @{@"kind": @"text", @"title": @"IDFV", @"keys": @[@"spoofedVendorUUID"], @"placeholder": @"UUID"},
            @{@"kind": @"text", @"title": @"IMEI", @"keys": @[@"spoofedIMEI"], @"placeholder": @"15位数字"},
            @{@"kind": @"text", @"title": @"Wi-Fi MAC", @"keys": @[@"wifiAddress"], @"placeholder": @"02:00:00:00:00:01"},
            @{@"kind": @"text", @"title": @"蓝牙 MAC", @"keys": @[@"bluetoothAddress"], @"placeholder": @"02:00:00:00:00:02"}
        ],
        @[
            @{@"kind": @"button", @"title": @"打开ChengIOS设置", @"action": @"settings"}
        ]
    ];
}

- (void)viewDidLoad {
    self.schema = [self buildSchema];
    [super viewDidLoad];
    self.title = @"ChengIOS";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(respring)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadProfile)];
    [self reloadProfile];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadProfile];
}

- (void)reloadProfile {
    self.summary = ChengIOSProfileSummary(ChengIOSLoadSavedProfile());
    if (self.summary.length == 0) {
        self.summary = @"暂无配置。请先点击随机生成。";
    }
    [self.tableView reloadData];
}

- (NSDictionary *)rowAt:(NSIndexPath *)indexPath {
    return self.schema[indexPath.section][indexPath.row];
}

- (NSString *)firstText:(NSArray *)keys {
    for (NSString *key in keys) {
        id value = ChengIOSPrefValue(key);
        if ([value isKindOfClass:[NSString class]] && [value length] > 0) {
            return value;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value stringValue];
        }
    }
    return @"";
}

- (BOOL)boolKey:(NSString *)key defaultOn:(BOOL)defaultOn {
    id value = ChengIOSPrefValue(key);
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return defaultOn;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return (NSInteger)self.schema.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    return (NSInteger)self.schema[section].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    NSArray *titles = @[
        @"随机生成", @"备份/数据", @"通用", @"应用", @"修改信息", @"iOS版本", @"应用版本",
        @"身份标识", @"区域设置", @"运营商", @"位置", @"网络/Wi-Fi",
        @"Gestalt/ID", @"其他"
    ];
    return titles[section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) {
        return @"默认根据公网IP：国家、运营商、GPS、区域设置、Wi-Fi。网页仍显示真实IP（如需美国/韩国请使用VPN）。按地区随机生成可手动指定。";
    }
    if (section == 1) {
        return @"Shopee：不注入插件（避免验证码），仅清除数据。Facebook/TikTok仍进行伪装。";
    }
    if (section == 2) {
        return @"Safari：勾选Safari，完全关闭后重新打开标签页。Facebook/Shopee仍保持安全模式。隐藏越狱：需强制关闭已选应用。";
    }
    if (section == 10) {
        return @"GPS默认根据公网IP获取。网页/deviceinfo.me仍显示运营商真实IP。";
    }
    if (section == 12) {
        return self.summary;
    }
    if (section == 13) {
        return @"随机生成后请强制关闭目标应用。Respring在左上角，刷新在右上角。";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *row = [self rowAt:indexPath];
    NSString *kind = row[@"kind"];
    if ([kind isEqualToString:@"switch"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sw"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sw"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.numberOfLines = 2;
        }
        cell.textLabel.text = row[@"title"];
        cell.detailTextLabel.text = row[@"detail"];
        UISwitch *toggle = [[UISwitch alloc] init];
        toggle.on = [self boolKey:row[@"key"] defaultOn:[row[@"defaultOn"] boolValue]];
        toggle.tag = indexPath.section * 100 + indexPath.row;
        [toggle addTarget:self action:@selector(toggleChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = toggle;
        return cell;
    }
    if ([kind isEqualToString:@"text"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tx"];
        UITextField *field = nil;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tx"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            field = [[UITextField alloc] initWithFrame:CGRectZero];
            field.tag = 50;
            field.textAlignment = NSTextAlignmentRight;
            field.autocorrectionType = UITextAutocorrectionTypeNo;
            field.autocapitalizationType = UITextAutocapitalizationTypeNone;
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            field.delegate = self;
            [field addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingDidEnd];
            [cell.contentView addSubview:field];
        } else {
            field = [cell.contentView viewWithTag:50];
        }
        cell.textLabel.text = row[@"title"];
        field.placeholder = row[@"placeholder"];
        field.text = [self firstText:row[@"keys"]];
        field.accessibilityIdentifier = [row[@"keys"] componentsJoinedByString:@","];
        field.frame = CGRectMake(140, 8, cell.contentView.bounds.size.width - 156, 28);
        field.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        cell.accessoryView = nil;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bt"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bt"];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 2;
    }
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = row[@"title"];
    cell.detailTextLabel.text = row[@"detail"] ?: row[@"url"];
    if ([kind isEqualToString:@"info"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = [self firstText:row[@"keys"]] ?: @"—";
    } else if ([kind isEqualToString:@"copy"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (void)toggleChanged:(UISwitch *)toggle {
    NSInteger section = toggle.tag / 100;
    NSInteger row = toggle.tag % 100;
    NSDictionary *item = self.schema[section][row];
    ChengIOSSetPrefValue(item[@"key"], @(toggle.on));
}

- (void)textChanged:(UITextField *)field {
    NSArray *keys = [field.accessibilityIdentifier componentsSeparatedByString:@","];
    NSString *text = field.text ?: @"";
    NSMutableDictionary *payload = [NSMutableDictionary dictionary];
    for (NSString *key in keys) {
        if (key.length > 0) {
            payload[key] = text;
        }
    }
    if (payload.count > 0) {
        ChengIOSApplyProfile(payload);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *row = [self rowAt:indexPath];
    NSString *kind = row[@"kind"];
    if ([kind isEqualToString:@"nav"]) {
        NSString *page = row[@"page"];
        UIViewController *next = nil;
        if ([page isEqualToString:@"deeplink"]) {
            next = [[DeeplinkListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        } else if ([page isEqualToString:@"region"]) {
            next = [[RegionListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        } else if ([page isEqualToString:@"backup"]) {
            next = [[BackupListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        } else {
            next = [[AppListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }
        [self.navigationController pushViewController:next animated:YES];
        return;
    }
    if ([kind isEqualToString:@"copy"]) {
        [UIPasteboard generalPasteboard].string = row[@"url"];
        [self toast:@"已复制URL"];
        return;
    }
    if ([kind isEqualToString:@"info"]) {
        NSString *text = [self firstText:row[@"keys"]];
        if (text.length > 0) {
            [UIPasteboard generalPasteboard].string = text;
            [self toast:@"已复制"];
        }
        return;
    }
    if (![kind isEqualToString:@"button"]) {
        return;
    }
    NSString *action = row[@"action"];
    if ([action isEqualToString:@"identity"]) {
        [self runRandom:NO silent:NO];
    } else if ([action isEqualToString:@"full"]) {
        [self runRandom:YES silent:NO];
    } else if ([action isEqualToString:@"profile"]) {
        [self showSummaryTitle:@"当前配置" profile:ChengIOSLoadSavedProfile()];
    } else if ([action isEqualToString:@"copy"]) {
        [self copySummary];
    } else if ([action isEqualToString:@"settings"]) {
        [self openSettings];
    } else if ([action isEqualToString:@"respring"]) {
        [self respring];
    } else if ([action isEqualToString:@"backupProfile"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://backup-profile"], self);
    } else if ([action isEqualToString:@"backupApps"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://backup-apps"], self);
    } else if ([action isEqualToString:@"backupEraseRandom"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://backup-erase-random"], self);
    } else if ([action isEqualToString:@"eraseApps"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://erase-apps"], self);
    } else if ([action isEqualToString:@"eraseRandomAll"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://erase-random-all"], self);
    } else if ([action isEqualToString:@"eraseDeviceRandom"]) {
        ChengIOSHandleBackupURL([NSURL URLWithString:@"chengios://erase-device-random"], self);
    }
}

- (void)finishChangeInfo:(NSDictionary *)profile title:(NSString *)title silent:(BOOL)silent respring:(BOOL)respring {
    ChengIOSApplyProfile(profile);
    [self reloadProfile];
    NSString *text = ChengIOSProfileSummary(profile);
    if (text.length > 0) {
        [UIPasteboard generalPasteboard].string = text;
    }
    if (respring) {
        if (!silent) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                           message:@"已复制配置。正在Respring..."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self respring];
                });
            }];
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self respring];
            });
        }
        return;
    }
    if (!silent) {
        [self showSummaryTitle:title profile:profile];
    }
}

- (void)runRandom:(BOOL)full silent:(BOOL)silent {
    [self runRandom:full silent:silent respring:YES];
}

- (void)runRandom:(BOOL)full silent:(BOOL)silent respring:(BOOL)respring {
    NSString *title = full ? @"随机生成全部" : @"随机生成设备信息";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *profile = full ? ChengIOSRandomFullProfile() : ChengIOSRandomIdentity();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self finishChangeInfo:profile title:title silent:silent respring:respring];
        });
    });
}

- (void)showSummaryTitle:(NSString *)title profile:(NSDictionary *)profile {
    NSString *text = ChengIOSProfileSummary(profile);
    if (text.length == 0) {
        text = @"暂无配置。";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        [UIPasteboard generalPasteboard].string = text;
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)copySummary {
    NSString *text = ChengIOSProfileSummary(ChengIOSLoadSavedProfile());
    if (text.length == 0) {
        [self toast:@"暂无配置"];
        return;
    }
    [UIPasteboard generalPasteboard].string = text;
    [self toast:@"已复制配置"];
}

- (void)toast:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (void)openSettings {
    NSArray<NSString *> *candidates = @[@"prefs:root=ChengIOS", @"App-prefs:root=ChengIOS", @"App-prefs:ChengIOS"];
    for (NSString *raw in candidates) {
        NSURL *url = [NSURL URLWithString:raw];
        if (!url) continue;
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            return;
        }
    }
}

- (void)respring {
    pid_t pid = 0;
    const char *candidates[] = {
        "/var/jb/usr/bin/sbreload", "/usr/bin/sbreload",
        "/var/jb/usr/bin/killall", "/usr/bin/killall", NULL
    };
    for (int i = 0; candidates[i] != NULL; i++) {
        if (access(candidates[i], X_OK) != 0) continue;
        if (strstr(candidates[i], "sbreload") != NULL) {
            const char *args[] = {candidates[i], NULL};
            if (posix_spawn(&pid, candidates[i], NULL, NULL, (char *const *)args, environ) == 0) return;
        } else {
            const char *args[] = {candidates[i], "-9", "SpringBoard", NULL};
            if (posix_spawn(&pid, candidates[i], NULL, NULL, (char *const *)args, environ) == 0) return;
        }
    }
}

- (NSString *)tokenFromURL:(NSURL *)url {
    if (!url) return @"";
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (url.host.length > 0) [parts addObject:url.host.lowercaseString];
    for (NSString *piece in [url.path componentsSeparatedByString:@"/"]) {
        if (piece.length == 0) continue;
        [parts addObject:piece.lowercaseString];
    }
    NSMutableArray<NSString *> *filtered = [NSMutableArray array];
    for (NSString *part in parts) {
        if ([part isEqualToString:@"x-callback-url"] || [part isEqualToString:@"x-callback"]) continue;
        [filtered addObject:part];
    }
    return [[filtered componentsJoinedByString:@"-"] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
}

- (BOOL)queryFlag:(NSURL *)url names:(NSArray<NSString *> *)names {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        for (NSString *name in names) {
            if ([item.name caseInsensitiveCompare:name] != NSOrderedSame) continue;
            if (item.value.length == 0 || [item.value isEqualToString:@"1"] ||
                [item.value caseInsensitiveCompare:@"true"] == NSOrderedSame ||
                [item.value caseInsensitiveCompare:@"yes"] == NSOrderedSame) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)queryValue:(NSURL *)url name:(NSString *)name {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        if ([item.name caseInsensitiveCompare:name] == NSOrderedSame) return item.value;
    }
    return nil;
}

- (void)openCallback:(NSString *)raw {
    if (raw.length == 0) return;
    NSURL *url = [NSURL URLWithString:raw];
    if (!url) return;
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (BOOL)token:(NSString *)token hasAny:(NSArray<NSString *> *)names {
    for (NSString *name in names) {
        if ([token isEqualToString:name] || [token containsString:name]) return YES;
    }
    return NO;
}

- (void)handleURL:(NSURL *)url {
    if (!url) return;
    NSString *token = [self tokenFromURL:url];
    NSString *mode = [self queryValue:url name:@"mode"];
    BOOL silent = [self queryFlag:url names:@[@"silent", @"quiet", @"x-silent"]];
    BOOL noRespring = [self queryFlag:url names:@[@"norespring", @"skip-respring"]];
    BOOL did = NO;
    if (ChengIOSHandleBackupURL(url, self.navigationController.topViewController ?: self)) {
        did = YES;
    } else {
    BOOL modeAll = [mode caseInsensitiveCompare:@"all"] == NSOrderedSame || [mode caseInsensitiveCompare:@"full"] == NSOrderedSame;
    BOOL modeIdentity = [mode caseInsensitiveCompare:@"identity"] == NSOrderedSame || [mode caseInsensitiveCompare:@"machine"] == NSOrderedSame || [mode caseInsensitiveCompare:@"info"] == NSOrderedSame;
    if (modeAll || [self token:token hasAny:@[@"random-all", @"randomall", @"toan-bo", @"toanbo", @"full"]]) {
        NSString *region = [self queryValue:url name:@"region"] ?: [self queryValue:url name:@"iso"];
        if (region.length > 0) {
            NSDictionary *profile = ChengIOSRandomFullProfileInRegion(region);
            [self finishChangeInfo:profile title:[NSString stringWithFormat:@"随机生成 %@", region.uppercaseString] silent:silent respring:!noRespring];
        } else {
            [self runRandom:YES silent:silent respring:!noRespring];
        }
        did = YES;
    } else if ([token isEqualToString:@"random"] && !modeIdentity) {
        [self runRandom:YES silent:silent respring:!noRespring]; did = YES;
    } else if (modeIdentity || [self token:token hasAny:@[@"random-identity", @"random-info", @"identity", @"info-may", @"infomay", @"machine"]]) {
        [self runRandom:NO silent:silent respring:!noRespring]; did = YES;
    } else if ([self token:token hasAny:@[@"copy"]]) {
        [self copySummary]; did = YES;
    } else if ([self token:token hasAny:@[@"profile", @"current", @"hoso", @"ho-so", @"info"]]) {
        [self showSummaryTitle:@"当前配置" profile:ChengIOSLoadSavedProfile()]; did = YES;
    } else if ([self token:token hasAny:@[@"apps", @"change-apps", @"applist", @"safari"]]) {
        AppListViewController *list = [[AppListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:list animated:YES];
        did = YES;
    } else if ([self token:token hasAny:@[@"regions", @"region", @"vung", @"vung-mien"]]) {
        RegionListViewController *list = [[RegionListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:list animated:YES];
        did = YES;
    } else if ([self token:token hasAny:@[@"deeplink", @"deeplinks", @"urls", @"shortcuts"]]) {
        DeeplinkListViewController *list = [[DeeplinkListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:list animated:YES];
        did = YES;
    } else if ([self token:token hasAny:@[@"setting", @"prefs"]]) {
        [self openSettings]; did = YES;
    } else if ([self token:token hasAny:@[@"respring", @"sbreload", @"ldrestart"]]) {
        [self respring]; did = YES;
    }
    }
    NSString *success = [self queryValue:url name:@"x-success"];
    if (did && success.length > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self openCallback:success];
        });
    }
}

@end
