#import "BackupListViewController.h"
#import "../ChengIOSPrefs/ChengIOSBackup.h"
#import "../ChengIOSPrefs/ChengIOSProfiles.h"

@interface BackupListViewController ()
@property (nonatomic, copy) NSArray<NSDictionary *> *backups;
@property (nonatomic, strong) UIAlertController *busyAlert;
@end

static void CIPresent(UIViewController *host, NSString *title, NSString *message);

@interface ChengIOSAppPickController : UITableViewController
@property (nonatomic, copy) NSArray<NSString *> *bundles;
@property (nonatomic, strong) NSMutableIndexSet *picked;
@property (nonatomic, copy) NSString *doneTitle;
@property (nonatomic, copy) void (^onDone)(NSArray<NSString *> *bundles);
- (instancetype)initWithBundles:(NSArray<NSString *> *)bundles title:(NSString *)title doneTitle:(NSString *)doneTitle;
@end

@implementation ChengIOSAppPickController

- (instancetype)initWithBundles:(NSArray<NSString *> *)bundles title:(NSString *)title doneTitle:(NSString *)doneTitle {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _bundles = [bundles copy] ?: @[];
        _picked = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _bundles.count)];
        _doneTitle = doneTitle.length ? [doneTitle copy] : @"确定";
        self.title = title.length ? title : @"选择应用";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelPick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.doneTitle
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(confirmPick)];
}

- (void)cancelPick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray<NSString *> *)pickedBundles {
    NSMutableArray *out = [NSMutableArray array];
    [self.picked enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        (void)stop;
        if (idx < self.bundles.count) {
            [out addObject:self.bundles[idx]];
        }
    }];
    return out;
}

- (void)confirmPick {
    NSArray *picked = [self pickedBundles];
    if (picked.count == 0) {
        CIPresent(self, @"未选择应用", @"请勾选1个、2个、3个应用或全部。列表来自\"选择应用\"。");
        return;
    }
    void (^cb)(NSArray *) = self.onDone;
    [self dismissViewControllerAnimated:YES completion:^{
        if (cb) {
            cb(picked);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    return section == 0 ? 2 : (NSInteger)self.bundles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    return section == 0 ? @"选择" : @"已勾选的应用";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) {
        return nil;
    }
    return @"勾选1个、2个、3个或全部。备份名称将包含应用名称。";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"p"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"p"];
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全选";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu个应用", (unsigned long)self.bundles.count];
            cell.accessoryType = (self.picked.count == self.bundles.count && self.bundles.count > 0) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else {
            cell.textLabel.text = @"取消全选";
            cell.detailTextLabel.text = @"需要重新勾选要备份的应用";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    NSString *bid = self.bundles[indexPath.row];
    cell.textLabel.text = ChengIOSBundleDisplayName(bid);
    cell.detailTextLabel.text = bid;
    cell.accessoryType = [self.picked containsIndex:(NSUInteger)indexPath.row] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.picked = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.bundles.count)];
        } else {
            self.picked = [NSMutableIndexSet indexSet];
        }
        [tableView reloadData];
        return;
    }
    NSUInteger idx = (NSUInteger)indexPath.row;
    if ([self.picked containsIndex:idx]) {
        [self.picked removeIndex:idx];
    } else {
        [self.picked addIndex:idx];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath, [NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end

@implementation BackupListViewController

static NSString *CIQuery(NSURL *url, NSString *name) {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        if ([item.name caseInsensitiveCompare:name] == NSOrderedSame) {
            return item.value;
        }
    }
    return nil;
}

static BOOL CIFlag(NSURL *url, NSArray<NSString *> *names) {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        for (NSString *name in names) {
            if ([item.name caseInsensitiveCompare:name] != NSOrderedSame) {
                continue;
            }
            if (item.value.length == 0 || [item.value isEqualToString:@"1"] ||
                [item.value caseInsensitiveCompare:@"true"] == NSOrderedSame ||
                [item.value caseInsensitiveCompare:@"yes"] == NSOrderedSame) {
                return YES;
            }
        }
    }
    return NO;
}

static NSString *CIToken(NSURL *url) {
    if (!url) {
        return @"";
    }
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (url.host.length > 0) {
        [parts addObject:url.host.lowercaseString];
    }
    for (NSString *piece in [url.path componentsSeparatedByString:@"/"]) {
        if (piece.length == 0 || [piece isEqualToString:@"x-callback-url"] || [piece isEqualToString:@"x-callback"]) {
            continue;
        }
        [parts addObject:piece.lowercaseString];
    }
    return [[parts componentsJoinedByString:@"-"] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
}

static NSArray<NSString *> *CIBundlesFromQuery(NSURL *url) {
    NSString *raw = CIQuery(url, @"bundle") ?: CIQuery(url, @"app") ?: CIQuery(url, @"apps") ?: @"";
    if (raw.length == 0) {
        return @[];
    }
    NSArray *parts = [raw componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",+ "]];
    NSMutableArray *out = [NSMutableArray array];
    for (NSString *part in parts) {
        if (part.length > 0) {
            [out addObject:part];
        }
    }
    return out;
}

static NSString *CIJoinTitles(NSArray *bundles) {
    NSMutableArray *parts = [NSMutableArray array];
    for (id item in bundles) {
        if (![item isKindOfClass:[NSString class]] || [item length] == 0) {
            continue;
        }
        [parts addObject:ChengIOSBundleDisplayTitle(item)];
    }
    return [parts componentsJoinedByString:@", "];
}

static void CIPresent(UIViewController *host, NSString *title, NSString *message) {
    if (!host) {
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [host presentViewController:alert animated:YES completion:nil];
}

static NSString *CIBytesString(unsigned long long bytes) {
    if (bytes < 1024) {
        return [NSString stringWithFormat:@"%llu B", bytes];
    }
    if (bytes < 1024ull * 1024ull) {
        return [NSString stringWithFormat:@"%.1f KB", bytes / 1024.0];
    }
    return [NSString stringWithFormat:@"%.1f MB", bytes / (1024.0 * 1024.0)];
}

static NSString *CIResultText(NSDictionary *meta, NSError *error, NSString *fallbackOK) {
    if (error) {
        return ChengIOSBackupErrorMessage(error);
    }
    NSMutableString *text = [NSMutableString string];
    [text appendString:fallbackOK];
    if ([meta[@"name"] length]) {
        [text appendFormat:@"\n名称: %@", meta[@"name"]];
    }
    if ([meta[@"id"] length]) {
        [text appendFormat:@"\nID: %@", meta[@"id"]];
    }
    if (meta[@"bytes"]) {
        [text appendFormat:@"\n数据: %@", CIBytesString([meta[@"bytes"] unsignedLongLongValue])];
    }
    if (meta[@"copyFiles"] || meta[@"copyFailed"]) {
        [text appendFormat:@"\n文件: %@  失败 %@", meta[@"copyFiles"] ?: @0, meta[@"copyFailed"] ?: @0];
        if ([meta[@"copyFailed"] unsignedIntegerValue] > 0) {
            [text appendString:@"\n警告: 部分文件复制失败。恢复可能缺少数据。"];
        }
        if ([meta[@"includeAppData"] boolValue] && [meta[@"bytes"] unsignedLongLongValue] == 0) {
            [text appendString:@"\n警告: 数据为0字节。备份沙盒失败，恢复后将没有登录状态。"];
        }
    }
    NSArray *bundles = meta[@"bundles"];
    if ([bundles isKindOfClass:[NSArray class]] && bundles.count > 0) {
        [text appendFormat:@"\n应用: %@", [bundles componentsJoinedByString:@", "]];
    }
    NSArray *failed = meta[@"failedBundles"];
    if ([failed isKindOfClass:[NSArray class]] && failed.count > 0) {
        [text appendFormat:@"\n跳过: %@", [failed componentsJoinedByString:@", "]];
    }
    if (meta[@"keychainItems"]) {
        [text appendFormat:@"\n钥匙串: %@ 项", meta[@"keychainItems"]];
        if (meta[@"keychainWithData"]) {
            [text appendFormat:@"  含数据 %@", meta[@"keychainWithData"]];
        }
        if (meta[@"signedCount"]) {
            [text appendFormat:@"  已签名 %@", meta[@"signedCount"]];
        }
        if (meta[@"agrpCount"]) {
            [text appendFormat:@"  访问组 %@", meta[@"agrpCount"]];
        }
        if ([meta[@"ldid"] isKindOfClass:[NSString class]] && [meta[@"ldid"] length] > 0) {
            [text appendFormat:@"\nldid: %@", meta[@"ldid"]];
        }
        if ([meta[@"signedError"] isKindOfClass:[NSString class]] && [meta[@"signedError"] length] > 0) {
            [text appendFormat:@"\nKC错误: %@", meta[@"signedError"]];
        }
        if ([meta[@"includeAppData"] boolValue] && [meta[@"keychainItems"] unsignedIntegerValue] == 0) {
            [text appendString:@"\n警告: 钥匙串为0。请安装ldid（Apps Manager ldid / Procursus）。需要钥匙串 N>0、withData N>0、kcUid 501。安装1.2.54，安装ldid，Respring，然后在应用登录状态下创建新备份。旧备份如果没有Caches/tmp/companion可能无法保持登录状态。"];
        } else if ([meta[@"includeAppData"] boolValue] && [meta[@"keychainWithData"] unsignedIntegerValue] == 0) {
            [text appendString:@"\n警告: 钥匙串没有数据。恢复后将丢失登录状态。请安装ldid，Respring并在登录状态下使用1.2.54重新备份。"];
        }
    }
    if (meta[@"asRoot"]) {
        [text appendFormat:@"\nRoot助手: %@", [meta[@"asRoot"] boolValue] ? @"有" : @"无"];
        if (meta[@"uid"]) {
            [text appendFormat:@"\n uid %@", meta[@"uid"]];
        }
        if (meta[@"kcUid"]) {
            [text appendFormat:@"  kcUid %@", meta[@"kcUid"]];
            if ([meta[@"kcUid"] integerValue] != 501 && [meta[@"includeAppData"] boolValue]) {
                [text appendString:@"\n警告: kcUid != 501，SecItem无法进入mobile钥匙串。恢复后将丢失登录状态。"];
            }
        }
        if (meta[@"daemon"]) {
            [text appendFormat:@"  守护进程: %@", [meta[@"daemon"] boolValue] ? @"有" : @"无"];
        }
        if (meta[@"sqlCount"]) {
            id secCount = meta[@"secCount"];
            if (!secCount) {
                secCount = @0;
            }
            [text appendFormat:@"\nSQL: %@  SecItem: %@", meta[@"sqlCount"], secCount];
        }
        if (![meta[@"asRoot"] boolValue]) {
            [text appendString:@"\n警告: 未以root运行。请安装1.2.20，Respring，然后从ChengIOS应用重新备份（守护进程有，kcUid 501）。需要ldid。"];
        }
    } else if ([meta[@"includeAppData"] boolValue]) {
        [text appendString:@"\nRoot助手: 无（旧版备份）。恢复可能丢失登录状态。"];
    }
    [text appendFormat:@"\n目录: %@", ChengIOSBackupRoot()];
    return text;
}

static void CIPresentMaybeRespring(UIViewController *host, NSString *title, NSString *message, BOOL respring);
static void CIRunBusyEx(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message, BOOL respring)));

static void CIRespringSoon(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ChengIOSRequestRespring();
    });
}

static void CIPresentMaybeRespring(UIViewController *host, NSString *title, NSString *message, BOOL respring) {
    if (!respring) {
        CIPresent(host, title, message);
        return;
    }
    NSString *text = message.length ? [message stringByAppendingString:@"\n\n正在Respring..."] : @"正在Respring...";
    if (!host) {
        CIRespringSoon();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [host presentViewController:alert animated:YES completion:^{
        CIRespringSoon();
    }];
}

static void CIRunBusyEx(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message, BOOL respring))) {
    UIAlertController *busy = [UIAlertController alertControllerWithTitle:title
                                                                  message:@"请保持ChengIOS应用打开。Facebook可能需要几分钟。"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    [host presentViewController:busy animated:YES completion:^{
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            work(^(NSString *resultTitle, NSString *message, BOOL respring) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [busy dismissViewControllerAnimated:YES completion:^{
                        CIPresentMaybeRespring(host, resultTitle, message, respring);
                    }];
                });
            });
        });
    }];
}

static void CIRunBusy(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message))) {
    CIRunBusyEx(host, title, ^(void (^done)(NSString *resultTitle, NSString *message, BOOL respring)) {
        work(^(NSString *resultTitle, NSString *message) {
            done(resultTitle, message, NO);
        });
    });
}


static void CIPresentAppPicker(UIViewController *host, NSString *title, NSString *doneTitle, NSArray<NSString *> *bundles, void (^onDone)(NSArray<NSString *> *picked)) {
    if (!host) {
        return;
    }
    if (bundles.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试。");
        return;
    }
    ChengIOSAppPickController *pick = [[ChengIOSAppPickController alloc] initWithBundles:bundles title:title doneTitle:doneTitle];
    pick.onDone = onDone;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pick];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [host presentViewController:nav animated:YES completion:nil];
}

static NSString *CIFormatEraseRandomText(NSDictionary *result, NSError *error) {
    NSMutableString *msg = [NSMutableString string];
    NSArray *ok = result[@"ok"];
    NSArray *failed = result[@"failed"];
    NSArray *skipped = result[@"skipped"];
    if (ok.count) {
        [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
    }
    if (failed.count) {
        [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
    }
    if (skipped.count) {
        [msg appendFormat:@"跳过: %@\n", CIJoinTitles(skipped)];
    }
    if ([result[@"profileSummary"] length]) {
        [msg appendFormat:@"\n%@\n", result[@"profileSummary"]];
    }
    if (error && (msg.length == 0 || ok.count == 0)) {
        if (msg.length) {
            [msg appendString:@"\n"];
        }
        [msg appendString:ChengIOSBackupErrorMessage(error)];
    }
    if (msg.length == 0 && [result[@"error"] isKindOfClass:[NSString class]]) {
        [msg appendString:result[@"error"]];
    }
    if (msg.length == 0) {
        [msg appendString:@"请强制关闭应用后重新打开。"];
    }
    if (ok.count) {
        [msg appendString:@"\n请强制关闭Shopee/TikTok/Facebook后重新打开。"];
    }
    return msg;
}

void ChengIOSRunCreateBackup(UIViewController *host, NSString *name, BOOL includeAppData, NSArray<NSString *> *bundleIDs, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, includeAppData ? @"正在备份配置+数据" : @"正在备份配置", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSArray *bundles = includeAppData ? (bundleIDs.count ? bundleIDs : ChengIOSUserSelectedBundleIDs()) : @[];
            NSDictionary *meta = ChengIOSCreateBackup(name, bundles, includeAppData, &error);
            NSString *title = error ? @"备份错误" : @"已备份";
            done(title, CIResultText(meta, error, includeAppData ? @"已保存配置+数据+钥匙串。需要钥匙串 > 0、Root有/uid 0（守护进程有）才能恢复登录状态。" : @"已保存ChengIOS配置。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    NSArray *nameBundles = includeAppData ? (bundleIDs.count ? bundleIDs : ChengIOSUserSelectedBundleIDs()) : @[];
    NSString *message = includeAppData
        ? [NSString stringWithFormat:@"保存%lu个应用的配置+数据+钥匙串。应用将被终止。需要已登录状态。备份名称将包含应用名称。", (unsigned long)nameBundles.count]
        : @"保存当前ChengIOS模拟配置（型号/iOS/GPS/Wi-Fi...）。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:includeAppData ? @"备份配置+数据" : @"备份配置"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = name.length ? name : ChengIOSSuggestedBackupNameForBundles(nameBundles);
        field.placeholder = @"备份名称";
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"备份" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSString *typed = alert.textFields.firstObject.text;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ChengIOSRunCreateBackup(host, typed, includeAppData, bundleIDs, YES);
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

static void ChengIOSRunPickBackup(UIViewController *host, NSString *name, BOOL silent) {
    NSArray *all = ChengIOSUserSelectedBundleIDs();
    if (all.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试备份。");
        return;
    }
    if (silent) {
        ChengIOSRunCreateBackup(host, name, YES, all, YES);
        return;
    }
    CIPresentAppPicker(host, @"备份配置+数据", @"备份", all, ^(NSArray<NSString *> *picked) {
        ChengIOSRunCreateBackup(host, name, YES, picked, NO);
    });
}

static void ChengIOSRunBackupEraseRandom(UIViewController *host, NSString *name, NSArray<NSString *> *bundleIDs, BOOL silent, BOOL respring) {
    NSArray *fallback = ChengIOSUserSelectedBundleIDs();
    void (^go)(NSString *, NSArray *) = ^(NSString *useName, NSArray *list) {
        CIRunBusyEx(host, @"备份+清除+随机", ^(void (^done)(NSString *, NSString *, BOOL)) {
            NSError *error = nil;
            NSDictionary *meta = ChengIOSCreateBackup(useName, list, YES, &error);
            if (!meta || error) {
                done(@"备份错误", ChengIOSBackupErrorMessage(error), NO);
                return;
            }
            NSError *eraseError = nil;
            NSDictionary *result = ChengIOSEraseThenRandom(list, NO, YES, nil, &eraseError);
            NSMutableString *msg = [NSMutableString string];
            [msg appendString:CIResultText(meta, nil, @"已备份配置+数据。")];
            [msg appendString:@"\n\n"];
            [msg appendString:CIFormatEraseRandomText(result, eraseError)];
            BOOL didChange = [result[@"profileSummary"] length] > 0;
            done(@"已备份+清除+随机", msg, respring && didChange);
        });
    };
    void (^afterPick)(NSArray *) = ^(NSArray *list) {
        if (list.count == 0) {
            CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试。");
            return;
        }
        if (silent) {
            go(name.length ? name : ChengIOSSuggestedBackupNameForBundles(list), list);
            return;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"备份+清除+随机+Respring"
                                                                       message:[NSString stringWithFormat:@"备份%lu个应用的配置+数据，清除这些应用的数据，根据IP随机生成全部，然后Respring。无法撤销。", (unsigned long)list.count]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
            field.text = name.length ? name : ChengIOSSuggestedBackupNameForBundles(list);
            field.placeholder = @"备份名称";
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"执行" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            (void)action;
            NSString *typed = alert.textFields.firstObject.text;
            NSArray *captured = list;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                go(typed, captured);
            });
        }]];
        [host presentViewController:alert animated:YES completion:nil];
    };
    if (silent) {
        NSArray *list = bundleIDs.count ? bundleIDs : fallback;
        afterPick(list);
        return;
    }
    if (bundleIDs.count > 0) {
        afterPick(bundleIDs);
        return;
    }
    CIPresentAppPicker(host, @"备份+清除+随机", @"继续", fallback, afterPick);
}

void ChengIOSRunRestore(UIViewController *host, NSString *backupID, BOOL restoreProfile, BOOL restoreAppData, BOOL silent) {
    if (backupID.length == 0) {
        CIPresent(host, @"恢复错误", @"缺少备份ID。");
        return;
    }
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在恢复", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            BOOL ok = ChengIOSRestoreBackup(backupID, restoreProfile, restoreAppData, &error);
            NSDictionary *meta = ChengIOSBackupInfo(backupID);
            NSString *msg = error ? ChengIOSBackupErrorMessage(error) : (ok ? @"已恢复沙盒+钥匙串。请强制关闭Facebook/Shopee/TikTok后重新打开。Facebook/TikTok需要使用1.2.54在登录状态下创建的新备份；旧备份没有Caches/tmp/companion。需要数据>0、钥匙串withData>0、kcUid 501。" : @"恢复失败。");
            NSDictionary *stats = ChengIOSLastRestoreStats();
            if (stats.count > 0) {
                msg = [NSString stringWithFormat:@"%@\n文件 %@  失败 %@  字节 %@\n钥匙串已恢复 %@  已签名 %@  SQL %@  失败 %@  跳过 %@  kcUid %@",
                       msg,
                       stats[@"copiedFiles"] ?: @0,
                       stats[@"copyFailed"] ?: @0,
                       stats[@"copiedBytes"] ?: @0,
                       stats[@"keychainRestored"] ?: @0,
                       stats[@"keychainSignedRestored"] ?: @0,
                       stats[@"keychainSQLRestored"] ?: @0,
                       stats[@"keychainFailed"] ?: @0,
                       stats[@"keychainSkipped"] ?: @0,
                       stats[@"kcUid"] ?: @"?"];
            }
            if (!error && [meta[@"name"] length]) {
                msg = [NSString stringWithFormat:@"%@\n%@", meta[@"name"], msg];
            }
            done(ok ? @"已恢复" : @"恢复错误", msg);
        });
    };
    if (silent) {
        go();
        return;
    }
    NSDictionary *meta = ChengIOSBackupInfo(backupID);
    NSString *message = [NSString stringWithFormat:@"%@\n配置: %@\n应用数据: %@",
                         meta[@"name"] ?: backupID,
                         restoreProfile ? @"有" : @"无",
                         restoreAppData ? @"有（覆盖沙盒）" : @"无"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恢复备份"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunErase(UIViewController *host, NSArray<NSString *> *bundleIDs, BOOL silent) {
    NSArray *fallback = ChengIOSUserSelectedBundleIDs();
    void (^go)(NSArray *) = ^(NSArray *list) {
        CIRunBusy(host, @"正在清除应用数据", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseBundles(list, &error);
            NSMutableString *msg = [NSMutableString string];
            NSArray *ok = result[@"ok"];
            NSArray *failed = result[@"failed"];
            NSArray *skipped = result[@"skipped"];
            if (ok.count) {
                [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
            }
            if (failed.count) {
                [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
            }
            if (skipped.count) {
                [msg appendFormat:@"跳过（系统）: %@\n", CIJoinTitles(skipped)];
            }
            if (error && (msg.length == 0 || ok.count == 0)) {
                if (msg.length) {
                    [msg appendString:@"\n"];
                }
                [msg appendString:ChengIOSBackupErrorMessage(error)];
            }
            if (msg.length == 0 && [result[@"error"] isKindOfClass:[NSString class]]) {
                [msg appendString:result[@"error"]];
            }
            if (ok.count) {
                [msg appendString:@"\n已清除沙盒+分组+插件+钥匙串SQL。请强制关闭应用，等待，不要立即打开。"];
            } else if (msg.length == 0) {
                if (list.count == 0) {
                    [msg appendString:@"未在\"选择应用\"中勾选应用。打开\"选择应用\"，勾选TikTok/Facebook/Shopee/Safari后重试。"];
                } else {
                    [msg appendFormat:@"无法清除。已选应用: %@。Respring，重新打开ChengIOS，如果勾选丢失请重新勾选。", CIJoinTitles(list)];
                }
            }
            done(ok.count ? @"已清除数据" : @"清除数据", msg);
        });
    };
    NSArray *targets = bundleIDs.count ? bundleIDs : fallback;
    if (targets.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试清除。\n如果刚执行随机生成导致勾选丢失，请重新勾选一次。");
        return;
    }
    if (silent) {
        go(targets);
        return;
    }
    if (bundleIDs.count == 0 && fallback.count > 1) {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"清除应用数据"
                                                                       message:@"选择1个应用或清除所有已选的用户应用。如果未备份则无法撤销。"
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        [sheet addAction:[UIAlertAction actionWithTitle:@"清除所有已选应用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            (void)action;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                go(fallback);
            });
        }]];
        for (NSString *bundle in fallback) {
            NSString *captured = [bundle copy];
            [sheet addAction:[UIAlertAction actionWithTitle:ChengIOSBundleDisplayTitle(captured) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                (void)action;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    go(@[captured]);
                });
            }]];
        }
        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        UIPopoverPresentationController *pop = sheet.popoverPresentationController;
        if (pop) {
            pop.sourceView = host.view;
            pop.sourceRect = CGRectMake(CGRectGetMidX(host.view.bounds), CGRectGetMidY(host.view.bounds), 1, 1);
            pop.permittedArrowDirections = 0;
        }
        [host presentViewController:sheet animated:YES completion:nil];
        return;
    }
    NSMutableArray *titleLines = [NSMutableArray array];
    for (NSString *bid in targets) {
        [titleLines addObject:ChengIOSBundleDisplayTitle(bid)];
    }
    NSString *list = titleLines.count ? [titleLines componentsJoinedByString:@"\n"] : @"(未选择用户应用)";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除应用数据"
                                                                   message:[NSString stringWithFormat:@"终止应用并清除沙盒:\n%@\n\n如果未备份则无法撤销。", list]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go(targets);
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}


static NSString *CIEraseResultText(NSDictionary *result, NSError *error, NSString *okTitle) {
    NSMutableString *msg = [NSMutableString string];
    NSArray *ok = result[@"ok"];
    NSArray *failed = result[@"failed"];
    NSArray *skipped = result[@"skipped"];
    if (ok.count) {
        [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
    }
    if (failed.count) {
        [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
    }
    if (skipped.count) {
        [msg appendFormat:@"跳过: %@\n", CIJoinTitles(skipped)];
    }
    if ([result[@"profileSummary"] length]) {
        [msg appendFormat:@"\n%@\n", result[@"profileSummary"]];
    }
    if (error && msg.length == 0) {
        [msg appendString:ChengIOSBackupErrorMessage(error)];
    }
    if (msg.length == 0) {
        [msg appendString:okTitle ?: @"完成。"];
    }
    return msg;
}

void ChengIOSRunEraseSafari(UIViewController *host, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在清除Safari", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseSafari(&error);
            done(result[@"ok"] ? @"已清除Safari" : @"清除Safari", CIEraseResultText(result, error, @"已清除历史记录/cookies/网站数据。iCloud钥匙串密码不会被清除。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除Safari"
                                                                   message:@"清除历史记录、cookies、网站数据、标签页。如同新安装的Safari。不会清除iCloud钥匙串密码。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除Safari" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunEraseDevice(UIViewController *host, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在清除所有应用数据", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseDeviceApps(YES, &error);
            done(@"已清除设备数据", CIEraseResultText(result, error, @"已清除用户应用+Safari的数据。不是恢复iOS。越狱/照片/短信/Apple ID仍然保留。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除所有应用数据"
                                                                   message:@"清除所有用户应用+Safari的数据（如同重新安装应用）。不是iOS恢复出厂设置。保留越狱、照片、短信、Apple ID。无法撤销。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除所有应用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunEraseThenRandom(UIViewController *host, NSArray<NSString *> *bundleIDs, BOOL allDevice, BOOL randomAll, NSString *region, BOOL silent, BOOL respring) {
    NSArray *list = bundleIDs.count ? bundleIDs : (allDevice ? @[] : ChengIOSUserSelectedBundleIDs());
    if (!allDevice && list.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试清除+随机。");
        return;
    }
    void (^go)(void) = ^{
        CIRunBusyEx(host, allDevice ? @"清除全部+随机" : @"清除应用+随机", ^(void (^done)(NSString *, NSString *, BOOL)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseThenRandom(list, allDevice, randomAll, region, &error);
            NSArray *ok = result[@"ok"];
            NSString *msg = CIFormatEraseRandomText(result, error);
            BOOL didChange = [result[@"profileSummary"] length] > 0;
            done(ok.count ? @"已清除+更改信息" : @"清除+随机", msg, respring && didChange);
        });
    };
    if (silent) {
        go();
        return;
    }
    NSString *title = allDevice ? @"清除全部+随机" : @"清除已选应用+随机";
    NSString *msg = allDevice
        ? @"清除所有用户应用+Safari的数据，然后随机生成全部，然后Respring。Shopee/TikTok在随机后会再清除一次。不是iOS恢复出厂设置。无法撤销。"
        : [NSString stringWithFormat:@"清除%lu个已选应用的沙盒/钥匙串，然后随机生成信息，然后Respring。Shopee/TikTok在随机后会再清除一次。无法撤销。", (unsigned long)list.count];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:randomAll ? @"清除+随机生成全部" : @"清除+随机生成设备信息" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

BOOL ChengIOSHandleBackupURL(NSURL *url, UIViewController *host) {
    if (!url || !host) {
        return NO;
    }
    NSString *token = CIToken(url);
    BOOL silent = CIFlag(url, @[@"silent", @"quiet", @"x-silent"]);
    BOOL respring = !CIFlag(url, @[@"norespring", @"skip-respring"]);
    NSString *name = CIQuery(url, @"name") ?: CIQuery(url, @"title") ?: CIQuery(url, @"label");
    BOOL wantData = CIFlag(url, @[@"data", @"appdata", @"apps", @"full"]);
    NSString *backupID = CIQuery(url, @"id") ?: CIQuery(url, @"backup") ?: CIQuery(url, @"backup-id");

    NSString *region = CIQuery(url, @"region") ?: CIQuery(url, @"iso");
    if ([token containsString:@"backup-erase-random"] || [token containsString:@"backup-wipe-random"] || [token containsString:@"backup-random-erase"] || [token containsString:@"backup-xoa-random"]) {
        ChengIOSRunBackupEraseRandom(host, name, CIBundlesFromQuery(url), silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-device-random"] || [token containsString:@"wipe-device-random"] || [token containsString:@"factory-random"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), YES, YES, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-random-all"] || [token containsString:@"wipe-random-all"] || [token containsString:@"reset-all"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), NO, YES, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-random"] || [token containsString:@"wipe-random"] || [token containsString:@"reset-identity"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), NO, NO, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-device"] || [token containsString:@"wipe-device"] || [token containsString:@"erase-all-apps"]) {
        ChengIOSRunEraseDevice(host, silent);
        return YES;
    }
    if ([token containsString:@"erase-safari"] || [token containsString:@"wipe-safari"]) {
        ChengIOSRunEraseSafari(host, silent);
        return YES;
    }
    if ([token containsString:@"backup-apps"] || [token containsString:@"backup-data"] || [token containsString:@"backup-all"] || [token containsString:@"backup-now"]) {
        NSArray *queryBundles = CIBundlesFromQuery(url);
        if (queryBundles.count > 0 || silent) {
            ChengIOSRunCreateBackup(host, name, YES, queryBundles, silent);
        } else {
            ChengIOSRunPickBackup(host, name, silent);
        }
        return YES;
    }
    if ([token containsString:@"backup-profile"] || [token containsString:@"backup-info"] || [token containsString:@"backup-hoso"]) {
        ChengIOSRunCreateBackup(host, name, NO, @[], silent);
        return YES;
    }
    if ([token isEqualToString:@"backup"] || [token isEqualToString:@"backups"] || [token containsString:@"backup-manager"] || [token containsString:@"quan-ly-backup"]) {
        if (![host isKindOfClass:[BackupListViewController class]]) {
            BackupListViewController *list = [[BackupListViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [host.navigationController pushViewController:list animated:YES];
        }
        return YES;
    }
    if ([token containsString:@"restore-latest"] || [token isEqualToString:@"restorelatest"]) {
        NSString *latest = ChengIOSLatestBackupID();
        if (latest.length == 0) {
            CIPresent(host, @"恢复", @"没有备份。");
            return YES;
        }
        ChengIOSRunRestore(host, latest, YES, wantData, silent);
        return YES;
    }
    if ([token isEqualToString:@"restore"] || [token hasPrefix:@"restore-"]) {
        if (backupID.length == 0) {
            backupID = ChengIOSLatestBackupID();
        }
        BOOL noProfile = CIFlag(url, @[@"noprofile", @"profile-off"]);
        NSString *profileValue = CIQuery(url, @"profile");
        BOOL restoreProfile = !noProfile;
        if (profileValue.length && ([profileValue isEqualToString:@"0"] || [profileValue caseInsensitiveCompare:@"no"] == NSOrderedSame)) {
            restoreProfile = NO;
        }
        ChengIOSRunRestore(host, backupID, restoreProfile, wantData, silent);
        return YES;
    }
    if ([token containsString:@"erase-apps"] || [token containsString:@"wipe-apps"] || [token isEqualToString:@"wipe"] || [token isEqualToString:@"erase-all"] || [token isEqualToString:@"eraseall"]) {
        ChengIOSRunErase(host, CIBundlesFromQuery(url), silent);
        return YES;
    }
    if ([token isEqualToString:@"erase"] || [token isEqualToString:@"wipe-app"] || [token hasPrefix:@"erase-"]) {
        NSArray *bundles = CIBundlesFromQuery(url);
        ChengIOSRunErase(host, bundles, silent);
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"备份列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(reloadBackups)];
    [self reloadBackups];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadBackups];
}

- (void)reloadBackups {
    self.backups = ChengIOSListBackups();
    [self.tableView reloadData];
}

- (void)promptBackupIncludingAppData:(BOOL)includeAppData suggestedName:(NSString *)name silent:(BOOL)silent {
    if (includeAppData) {
        ChengIOSRunPickBackup(self, name, silent);
        return;
    }
    ChengIOSRunCreateBackup(self, name, includeAppData, nil, silent);
}

- (void)promptEraseBundles:(NSArray<NSString *> *)bundleIDs silent:(BOOL)silent {
    ChengIOSRunErase(self, bundleIDs, silent);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return (NSInteger)MAX(self.backups.count, 1);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return @"备份列表";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return [NSString stringWithFormat:@"目录: %@\n备份/清除/随机操作在主屏幕。点击条目可恢复、重命名或删除。备份后需要钥匙串withData>0、kcUid 501、Root有、ldid有。", ChengIOSBackupRoot()];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"b"];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (self.backups.count == 0) {
        cell.textLabel.text = @"没有备份";
        cell.detailTextLabel.text = @"在主屏幕使用备份功能，当应用处于登录状态时。";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NSDictionary *item = self.backups[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = item[@"name"] ?: item[@"id"];
    NSMutableString *detail = [NSMutableString string];
    if ([item[@"created"] length]) {
        [detail appendString:item[@"created"]];
    }
    NSArray *bundles = item[@"bundles"];
    if ([item[@"includeAppData"] boolValue] && [bundles isKindOfClass:[NSArray class]]) {
        [detail appendFormat:@"  ·  %lu个应用  ·  %@", (unsigned long)bundles.count, CIBytesString([item[@"bytes"] unsignedLongLongValue])];
        if (item[@"keychainItems"]) {
            [detail appendFormat:@"  ·  KC %@", item[@"keychainItems"]];
        }
        if (item[@"kcUid"]) {
            [detail appendFormat:@"  ·  kcUid %@", item[@"kcUid"]];
        }
        if (item[@"asRoot"]) {
            [detail appendFormat:@"  ·  root %@", [item[@"asRoot"] boolValue] ? @"有" : @"无"];
        }
    } else {
        [detail appendString:@"  ·  配置"];
    }
    NSString *summary = item[@"profileSummary"];
    if ([summary isKindOfClass:[NSString class]] && summary.length > 0) {
        NSArray *lines = [summary componentsSeparatedByString:@"\n"];
        [detail appendFormat:@"\n%@", lines.firstObject];
    }
    cell.detailTextLabel.text = detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.backups.count == 0) {
        return;
    }
    NSDictionary *item = self.backups[indexPath.row];
    NSString *backupID = item[@"id"];
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:item[@"name"] ?: backupID
                                                                   message:item[@"created"]
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复配置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, YES, NO, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复配置+应用数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, YES, YES, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"仅恢复应用数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, NO, YES, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        [self renameBackup:item];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"复制ID/路径" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSString *text = [NSString stringWithFormat:@"%@\nchengios://restore?id=%@\n%@", item[@"name"], backupID, item[@"path"]];
        [UIPasteboard generalPasteboard].string = text;
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"删除此备份" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        if (ChengIOSDeleteBackup(backupID, &error)) {
            [self reloadBackups];
        } else {
            CIPresent(self, @"删除备份错误", ChengIOSBackupErrorMessage(error));
        }
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *pop = sheet.popoverPresentationController;
    if (pop) {
        pop.sourceView = tableView;
        pop.sourceRect = [tableView rectForRowAtIndexPath:indexPath];
    }
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)renameBackup:(NSDictionary *)item {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重命名备份"
                                                                   message:item[@"id"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = item[@"name"];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        if (ChengIOSRenameBackup(item[@"id"], alert.textFields.firstObject.text, &error)) {
            [self reloadBackups];
        } else {
            CIPresent(self, @"重命名错误", ChengIOSBackupErrorMessage(error));
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    return self.backups.count > 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    if (editingStyle != UITableViewCellEditingStyleDelete || self.backups.count == 0) {
        return;
    }
    NSString *backupID = self.backups[indexPath.row][@"id"];
    ChengIOSDeleteBackup(backupID, nil);
    [self reloadBackups];
}
#import "BackupListViewController.h"
#import "../ChengIOSPrefs/ChengIOSBackup.h"
#import "../ChengIOSPrefs/ChengIOSProfiles.h"

@interface BackupListViewController ()
@property (nonatomic, copy) NSArray<NSDictionary *> *backups;
@property (nonatomic, strong) UIAlertController *busyAlert;
@end

static void CIPresent(UIViewController *host, NSString *title, NSString *message);

@interface ChengIOSAppPickController : UITableViewController
@property (nonatomic, copy) NSArray<NSString *> *bundles;
@property (nonatomic, strong) NSMutableIndexSet *picked;
@property (nonatomic, copy) NSString *doneTitle;
@property (nonatomic, copy) void (^onDone)(NSArray<NSString *> *bundles);
- (instancetype)initWithBundles:(NSArray<NSString *> *)bundles title:(NSString *)title doneTitle:(NSString *)doneTitle;
@end

@implementation ChengIOSAppPickController

- (instancetype)initWithBundles:(NSArray<NSString *> *)bundles title:(NSString *)title doneTitle:(NSString *)doneTitle {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _bundles = [bundles copy] ?: @[];
        _picked = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _bundles.count)];
        _doneTitle = doneTitle.length ? [doneTitle copy] : @"确定";
        self.title = title.length ? title : @"选择应用";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelPick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.doneTitle
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(confirmPick)];
}

- (void)cancelPick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray<NSString *> *)pickedBundles {
    NSMutableArray *out = [NSMutableArray array];
    [self.picked enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        (void)stop;
        if (idx < self.bundles.count) {
            [out addObject:self.bundles[idx]];
        }
    }];
    return out;
}

- (void)confirmPick {
    NSArray *picked = [self pickedBundles];
    if (picked.count == 0) {
        CIPresent(self, @"未选择应用", @"请勾选1个、2个、3个应用或全部。列表来自\"选择应用\"。");
        return;
    }
    void (^cb)(NSArray *) = self.onDone;
    [self dismissViewControllerAnimated:YES completion:^{
        if (cb) {
            cb(picked);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    return section == 0 ? 2 : (NSInteger)self.bundles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    return section == 0 ? @"选择" : @"已勾选的应用";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) {
        return nil;
    }
    return @"勾选1个、2个、3个或全部。备份名称将包含应用名称。";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"p"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"p"];
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全选";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu个应用", (unsigned long)self.bundles.count];
            cell.accessoryType = (self.picked.count == self.bundles.count && self.bundles.count > 0) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else {
            cell.textLabel.text = @"取消全选";
            cell.detailTextLabel.text = @"需要重新勾选要备份的应用";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    NSString *bid = self.bundles[indexPath.row];
    cell.textLabel.text = ChengIOSBundleDisplayName(bid);
    cell.detailTextLabel.text = bid;
    cell.accessoryType = [self.picked containsIndex:(NSUInteger)indexPath.row] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.picked = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.bundles.count)];
        } else {
            self.picked = [NSMutableIndexSet indexSet];
        }
        [tableView reloadData];
        return;
    }
    NSUInteger idx = (NSUInteger)indexPath.row;
    if ([self.picked containsIndex:idx]) {
        [self.picked removeIndex:idx];
    } else {
        [self.picked addIndex:idx];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath, [NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end

@implementation BackupListViewController

static NSString *CIQuery(NSURL *url, NSString *name) {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        if ([item.name caseInsensitiveCompare:name] == NSOrderedSame) {
            return item.value;
        }
    }
    return nil;
}

static BOOL CIFlag(NSURL *url, NSArray<NSString *> *names) {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    for (NSURLQueryItem *item in components.queryItems) {
        for (NSString *name in names) {
            if ([item.name caseInsensitiveCompare:name] != NSOrderedSame) {
                continue;
            }
            if (item.value.length == 0 || [item.value isEqualToString:@"1"] ||
                [item.value caseInsensitiveCompare:@"true"] == NSOrderedSame ||
                [item.value caseInsensitiveCompare:@"yes"] == NSOrderedSame) {
                return YES;
            }
        }
    }
    return NO;
}

static NSString *CIToken(NSURL *url) {
    if (!url) {
        return @"";
    }
    NSMutableArray<NSString *> *parts = [NSMutableArray array];
    if (url.host.length > 0) {
        [parts addObject:url.host.lowercaseString];
    }
    for (NSString *piece in [url.path componentsSeparatedByString:@"/"]) {
        if (piece.length == 0 || [piece isEqualToString:@"x-callback-url"] || [piece isEqualToString:@"x-callback"]) {
            continue;
        }
        [parts addObject:piece.lowercaseString];
    }
    return [[parts componentsJoinedByString:@"-"] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
}

static NSArray<NSString *> *CIBundlesFromQuery(NSURL *url) {
    NSString *raw = CIQuery(url, @"bundle") ?: CIQuery(url, @"app") ?: CIQuery(url, @"apps") ?: @"";
    if (raw.length == 0) {
        return @[];
    }
    NSArray *parts = [raw componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",+ "]];
    NSMutableArray *out = [NSMutableArray array];
    for (NSString *part in parts) {
        if (part.length > 0) {
            [out addObject:part];
        }
    }
    return out;
}

static NSString *CIJoinTitles(NSArray *bundles) {
    NSMutableArray *parts = [NSMutableArray array];
    for (id item in bundles) {
        if (![item isKindOfClass:[NSString class]] || [item length] == 0) {
            continue;
        }
        [parts addObject:ChengIOSBundleDisplayTitle(item)];
    }
    return [parts componentsJoinedByString:@", "];
}

static void CIPresent(UIViewController *host, NSString *title, NSString *message) {
    if (!host) {
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [host presentViewController:alert animated:YES completion:nil];
}

static NSString *CIBytesString(unsigned long long bytes) {
    if (bytes < 1024) {
        return [NSString stringWithFormat:@"%llu B", bytes];
    }
    if (bytes < 1024ull * 1024ull) {
        return [NSString stringWithFormat:@"%.1f KB", bytes / 1024.0];
    }
    return [NSString stringWithFormat:@"%.1f MB", bytes / (1024.0 * 1024.0)];
}

static NSString *CIResultText(NSDictionary *meta, NSError *error, NSString *fallbackOK) {
    if (error) {
        return ChengIOSBackupErrorMessage(error);
    }
    NSMutableString *text = [NSMutableString string];
    [text appendString:fallbackOK];
    if ([meta[@"name"] length]) {
        [text appendFormat:@"\n名称: %@", meta[@"name"]];
    }
    if ([meta[@"id"] length]) {
        [text appendFormat:@"\nID: %@", meta[@"id"]];
    }
    if (meta[@"bytes"]) {
        [text appendFormat:@"\n数据: %@", CIBytesString([meta[@"bytes"] unsignedLongLongValue])];
    }
    if (meta[@"copyFiles"] || meta[@"copyFailed"]) {
        [text appendFormat:@"\n文件: %@  失败 %@", meta[@"copyFiles"] ?: @0, meta[@"copyFailed"] ?: @0];
        if ([meta[@"copyFailed"] unsignedIntegerValue] > 0) {
            [text appendString:@"\n警告: 部分文件复制失败。恢复可能缺少数据。"];
        }
        if ([meta[@"includeAppData"] boolValue] && [meta[@"bytes"] unsignedLongLongValue] == 0) {
            [text appendString:@"\n警告: 数据为0字节。备份沙盒失败，恢复后将没有登录状态。"];
        }
    }
    NSArray *bundles = meta[@"bundles"];
    if ([bundles isKindOfClass:[NSArray class]] && bundles.count > 0) {
        [text appendFormat:@"\n应用: %@", [bundles componentsJoinedByString:@", "]];
    }
    NSArray *failed = meta[@"failedBundles"];
    if ([failed isKindOfClass:[NSArray class]] && failed.count > 0) {
        [text appendFormat:@"\n跳过: %@", [failed componentsJoinedByString:@", "]];
    }
    if (meta[@"keychainItems"]) {
        [text appendFormat:@"\n钥匙串: %@ 项", meta[@"keychainItems"]];
        if (meta[@"keychainWithData"]) {
            [text appendFormat:@"  含数据 %@", meta[@"keychainWithData"]];
        }
        if (meta[@"signedCount"]) {
            [text appendFormat:@"  已签名 %@", meta[@"signedCount"]];
        }
        if (meta[@"agrpCount"]) {
            [text appendFormat:@"  访问组 %@", meta[@"agrpCount"]];
        }
        if ([meta[@"ldid"] isKindOfClass:[NSString class]] && [meta[@"ldid"] length] > 0) {
            [text appendFormat:@"\nldid: %@", meta[@"ldid"]];
        }
        if ([meta[@"signedError"] isKindOfClass:[NSString class]] && [meta[@"signedError"] length] > 0) {
            [text appendFormat:@"\nKC错误: %@", meta[@"signedError"]];
        }
        if ([meta[@"includeAppData"] boolValue] && [meta[@"keychainItems"] unsignedIntegerValue] == 0) {
            [text appendString:@"\n警告: 钥匙串为0。请安装ldid（Apps Manager ldid / Procursus）。需要钥匙串 N>0、withData N>0、kcUid 501。安装1.2.54，安装ldid，Respring，然后在应用登录状态下创建新备份。旧备份如果没有Caches/tmp/companion可能无法保持登录状态。"];
        } else if ([meta[@"includeAppData"] boolValue] && [meta[@"keychainWithData"] unsignedIntegerValue] == 0) {
            [text appendString:@"\n警告: 钥匙串没有数据。恢复后将丢失登录状态。请安装ldid，Respring并在登录状态下使用1.2.54重新备份。"];
        }
    }
    if (meta[@"asRoot"]) {
        [text appendFormat:@"\nRoot助手: %@", [meta[@"asRoot"] boolValue] ? @"有" : @"无"];
        if (meta[@"uid"]) {
            [text appendFormat:@"\n uid %@", meta[@"uid"]];
        }
        if (meta[@"kcUid"]) {
            [text appendFormat:@"  kcUid %@", meta[@"kcUid"]];
            if ([meta[@"kcUid"] integerValue] != 501 && [meta[@"includeAppData"] boolValue]) {
                [text appendString:@"\n警告: kcUid != 501，SecItem无法进入mobile钥匙串。恢复后将丢失登录状态。"];
            }
        }
        if (meta[@"daemon"]) {
            [text appendFormat:@"  守护进程: %@", [meta[@"daemon"] boolValue] ? @"有" : @"无"];
        }
        if (meta[@"sqlCount"]) {
            id secCount = meta[@"secCount"];
            if (!secCount) {
                secCount = @0;
            }
            [text appendFormat:@"\nSQL: %@  SecItem: %@", meta[@"sqlCount"], secCount];
        }
        if (![meta[@"asRoot"] boolValue]) {
            [text appendString:@"\n警告: 未以root运行。请安装1.2.20，Respring，然后从ChengIOS应用重新备份（守护进程有，kcUid 501）。需要ldid。"];
        }
    } else if ([meta[@"includeAppData"] boolValue]) {
        [text appendString:@"\nRoot助手: 无（旧版备份）。恢复可能丢失登录状态。"];
    }
    [text appendFormat:@"\n目录: %@", ChengIOSBackupRoot()];
    return text;
}

static void CIPresentMaybeRespring(UIViewController *host, NSString *title, NSString *message, BOOL respring);
static void CIRunBusyEx(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message, BOOL respring)));

static void CIRespringSoon(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ChengIOSRequestRespring();
    });
}

static void CIPresentMaybeRespring(UIViewController *host, NSString *title, NSString *message, BOOL respring) {
    if (!respring) {
        CIPresent(host, title, message);
        return;
    }
    NSString *text = message.length ? [message stringByAppendingString:@"\n\n正在Respring..."] : @"正在Respring...";
    if (!host) {
        CIRespringSoon();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [host presentViewController:alert animated:YES completion:^{
        CIRespringSoon();
    }];
}

static void CIRunBusyEx(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message, BOOL respring))) {
    UIAlertController *busy = [UIAlertController alertControllerWithTitle:title
                                                                  message:@"请保持ChengIOS应用打开。Facebook可能需要几分钟。"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    [host presentViewController:busy animated:YES completion:^{
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            work(^(NSString *resultTitle, NSString *message, BOOL respring) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [busy dismissViewControllerAnimated:YES completion:^{
                        CIPresentMaybeRespring(host, resultTitle, message, respring);
                    }];
                });
            });
        });
    }];
}

static void CIRunBusy(UIViewController *host, NSString *title, void (^work)(void (^done)(NSString *resultTitle, NSString *message))) {
    CIRunBusyEx(host, title, ^(void (^done)(NSString *resultTitle, NSString *message, BOOL respring)) {
        work(^(NSString *resultTitle, NSString *message) {
            done(resultTitle, message, NO);
        });
    });
}


static void CIPresentAppPicker(UIViewController *host, NSString *title, NSString *doneTitle, NSArray<NSString *> *bundles, void (^onDone)(NSArray<NSString *> *picked)) {
    if (!host) {
        return;
    }
    if (bundles.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试。");
        return;
    }
    ChengIOSAppPickController *pick = [[ChengIOSAppPickController alloc] initWithBundles:bundles title:title doneTitle:doneTitle];
    pick.onDone = onDone;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pick];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [host presentViewController:nav animated:YES completion:nil];
}

static NSString *CIFormatEraseRandomText(NSDictionary *result, NSError *error) {
    NSMutableString *msg = [NSMutableString string];
    NSArray *ok = result[@"ok"];
    NSArray *failed = result[@"failed"];
    NSArray *skipped = result[@"skipped"];
    if (ok.count) {
        [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
    }
    if (failed.count) {
        [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
    }
    if (skipped.count) {
        [msg appendFormat:@"跳过: %@\n", CIJoinTitles(skipped)];
    }
    if ([result[@"profileSummary"] length]) {
        [msg appendFormat:@"\n%@\n", result[@"profileSummary"]];
    }
    if (error && (msg.length == 0 || ok.count == 0)) {
        if (msg.length) {
            [msg appendString:@"\n"];
        }
        [msg appendString:ChengIOSBackupErrorMessage(error)];
    }
    if (msg.length == 0 && [result[@"error"] isKindOfClass:[NSString class]]) {
        [msg appendString:result[@"error"]];
    }
    if (msg.length == 0) {
        [msg appendString:@"请强制关闭应用后重新打开。"];
    }
    if (ok.count) {
        [msg appendString:@"\n请强制关闭Shopee/TikTok/Facebook后重新打开。"];
    }
    return msg;
}

void ChengIOSRunCreateBackup(UIViewController *host, NSString *name, BOOL includeAppData, NSArray<NSString *> *bundleIDs, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, includeAppData ? @"正在备份配置+数据" : @"正在备份配置", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSArray *bundles = includeAppData ? (bundleIDs.count ? bundleIDs : ChengIOSUserSelectedBundleIDs()) : @[];
            NSDictionary *meta = ChengIOSCreateBackup(name, bundles, includeAppData, &error);
            NSString *title = error ? @"备份错误" : @"已备份";
            done(title, CIResultText(meta, error, includeAppData ? @"已保存配置+数据+钥匙串。需要钥匙串 > 0、Root有/uid 0（守护进程有）才能恢复登录状态。" : @"已保存ChengIOS配置。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    NSArray *nameBundles = includeAppData ? (bundleIDs.count ? bundleIDs : ChengIOSUserSelectedBundleIDs()) : @[];
    NSString *message = includeAppData
        ? [NSString stringWithFormat:@"保存%lu个应用的配置+数据+钥匙串。应用将被终止。需要已登录状态。备份名称将包含应用名称。", (unsigned long)nameBundles.count]
        : @"保存当前ChengIOS模拟配置（型号/iOS/GPS/Wi-Fi...）。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:includeAppData ? @"备份配置+数据" : @"备份配置"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = name.length ? name : ChengIOSSuggestedBackupNameForBundles(nameBundles);
        field.placeholder = @"备份名称";
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"备份" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSString *typed = alert.textFields.firstObject.text;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ChengIOSRunCreateBackup(host, typed, includeAppData, bundleIDs, YES);
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

static void ChengIOSRunPickBackup(UIViewController *host, NSString *name, BOOL silent) {
    NSArray *all = ChengIOSUserSelectedBundleIDs();
    if (all.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试备份。");
        return;
    }
    if (silent) {
        ChengIOSRunCreateBackup(host, name, YES, all, YES);
        return;
    }
    CIPresentAppPicker(host, @"备份配置+数据", @"备份", all, ^(NSArray<NSString *> *picked) {
        ChengIOSRunCreateBackup(host, name, YES, picked, NO);
    });
}

static void ChengIOSRunBackupEraseRandom(UIViewController *host, NSString *name, NSArray<NSString *> *bundleIDs, BOOL silent, BOOL respring) {
    NSArray *fallback = ChengIOSUserSelectedBundleIDs();
    void (^go)(NSString *, NSArray *) = ^(NSString *useName, NSArray *list) {
        CIRunBusyEx(host, @"备份+清除+随机", ^(void (^done)(NSString *, NSString *, BOOL)) {
            NSError *error = nil;
            NSDictionary *meta = ChengIOSCreateBackup(useName, list, YES, &error);
            if (!meta || error) {
                done(@"备份错误", ChengIOSBackupErrorMessage(error), NO);
                return;
            }
            NSError *eraseError = nil;
            NSDictionary *result = ChengIOSEraseThenRandom(list, NO, YES, nil, &eraseError);
            NSMutableString *msg = [NSMutableString string];
            [msg appendString:CIResultText(meta, nil, @"已备份配置+数据。")];
            [msg appendString:@"\n\n"];
            [msg appendString:CIFormatEraseRandomText(result, eraseError)];
            BOOL didChange = [result[@"profileSummary"] length] > 0;
            done(@"已备份+清除+随机", msg, respring && didChange);
        });
    };
    void (^afterPick)(NSArray *) = ^(NSArray *list) {
        if (list.count == 0) {
            CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试。");
            return;
        }
        if (silent) {
            go(name.length ? name : ChengIOSSuggestedBackupNameForBundles(list), list);
            return;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"备份+清除+随机+Respring"
                                                                       message:[NSString stringWithFormat:@"备份%lu个应用的配置+数据，清除这些应用的数据，根据IP随机生成全部，然后Respring。无法撤销。", (unsigned long)list.count]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
            field.text = name.length ? name : ChengIOSSuggestedBackupNameForBundles(list);
            field.placeholder = @"备份名称";
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"执行" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            (void)action;
            NSString *typed = alert.textFields.firstObject.text;
            NSArray *captured = list;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                go(typed, captured);
            });
        }]];
        [host presentViewController:alert animated:YES completion:nil];
    };
    if (silent) {
        NSArray *list = bundleIDs.count ? bundleIDs : fallback;
        afterPick(list);
        return;
    }
    if (bundleIDs.count > 0) {
        afterPick(bundleIDs);
        return;
    }
    CIPresentAppPicker(host, @"备份+清除+随机", @"继续", fallback, afterPick);
}

void ChengIOSRunRestore(UIViewController *host, NSString *backupID, BOOL restoreProfile, BOOL restoreAppData, BOOL silent) {
    if (backupID.length == 0) {
        CIPresent(host, @"恢复错误", @"缺少备份ID。");
        return;
    }
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在恢复", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            BOOL ok = ChengIOSRestoreBackup(backupID, restoreProfile, restoreAppData, &error);
            NSDictionary *meta = ChengIOSBackupInfo(backupID);
            NSString *msg = error ? ChengIOSBackupErrorMessage(error) : (ok ? @"已恢复沙盒+钥匙串。请强制关闭Facebook/Shopee/TikTok后重新打开。Facebook/TikTok需要使用1.2.54在登录状态下创建的新备份；旧备份没有Caches/tmp/companion。需要数据>0、钥匙串withData>0、kcUid 501。" : @"恢复失败。");
            NSDictionary *stats = ChengIOSLastRestoreStats();
            if (stats.count > 0) {
                msg = [NSString stringWithFormat:@"%@\n文件 %@  失败 %@  字节 %@\n钥匙串已恢复 %@  已签名 %@  SQL %@  失败 %@  跳过 %@  kcUid %@",
                       msg,
                       stats[@"copiedFiles"] ?: @0,
                       stats[@"copyFailed"] ?: @0,
                       stats[@"copiedBytes"] ?: @0,
                       stats[@"keychainRestored"] ?: @0,
                       stats[@"keychainSignedRestored"] ?: @0,
                       stats[@"keychainSQLRestored"] ?: @0,
                       stats[@"keychainFailed"] ?: @0,
                       stats[@"keychainSkipped"] ?: @0,
                       stats[@"kcUid"] ?: @"?"];
            }
            if (!error && [meta[@"name"] length]) {
                msg = [NSString stringWithFormat:@"%@\n%@", meta[@"name"], msg];
            }
            done(ok ? @"已恢复" : @"恢复错误", msg);
        });
    };
    if (silent) {
        go();
        return;
    }
    NSDictionary *meta = ChengIOSBackupInfo(backupID);
    NSString *message = [NSString stringWithFormat:@"%@\n配置: %@\n应用数据: %@",
                         meta[@"name"] ?: backupID,
                         restoreProfile ? @"有" : @"无",
                         restoreAppData ? @"有（覆盖沙盒）" : @"无"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恢复备份"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunErase(UIViewController *host, NSArray<NSString *> *bundleIDs, BOOL silent) {
    NSArray *fallback = ChengIOSUserSelectedBundleIDs();
    void (^go)(NSArray *) = ^(NSArray *list) {
        CIRunBusy(host, @"正在清除应用数据", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseBundles(list, &error);
            NSMutableString *msg = [NSMutableString string];
            NSArray *ok = result[@"ok"];
            NSArray *failed = result[@"failed"];
            NSArray *skipped = result[@"skipped"];
            if (ok.count) {
                [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
            }
            if (failed.count) {
                [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
            }
            if (skipped.count) {
                [msg appendFormat:@"跳过（系统）: %@\n", CIJoinTitles(skipped)];
            }
            if (error && (msg.length == 0 || ok.count == 0)) {
                if (msg.length) {
                    [msg appendString:@"\n"];
                }
                [msg appendString:ChengIOSBackupErrorMessage(error)];
            }
            if (msg.length == 0 && [result[@"error"] isKindOfClass:[NSString class]]) {
                [msg appendString:result[@"error"]];
            }
            if (ok.count) {
                [msg appendString:@"\n已清除沙盒+分组+插件+钥匙串SQL。请强制关闭应用，等待，不要立即打开。"];
            } else if (msg.length == 0) {
                if (list.count == 0) {
                    [msg appendString:@"未在\"选择应用\"中勾选应用。打开\"选择应用\"，勾选TikTok/Facebook/Shopee/Safari后重试。"];
                } else {
                    [msg appendFormat:@"无法清除。已选应用: %@。Respring，重新打开ChengIOS，如果勾选丢失请重新勾选。", CIJoinTitles(list)];
                }
            }
            done(ok.count ? @"已清除数据" : @"清除数据", msg);
        });
    };
    NSArray *targets = bundleIDs.count ? bundleIDs : fallback;
    if (targets.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试清除。\n如果刚执行随机生成导致勾选丢失，请重新勾选一次。");
        return;
    }
    if (silent) {
        go(targets);
        return;
    }
    if (bundleIDs.count == 0 && fallback.count > 1) {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"清除应用数据"
                                                                       message:@"选择1个应用或清除所有已选的用户应用。如果未备份则无法撤销。"
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        [sheet addAction:[UIAlertAction actionWithTitle:@"清除所有已选应用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            (void)action;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                go(fallback);
            });
        }]];
        for (NSString *bundle in fallback) {
            NSString *captured = [bundle copy];
            [sheet addAction:[UIAlertAction actionWithTitle:ChengIOSBundleDisplayTitle(captured) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                (void)action;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    go(@[captured]);
                });
            }]];
        }
        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        UIPopoverPresentationController *pop = sheet.popoverPresentationController;
        if (pop) {
            pop.sourceView = host.view;
            pop.sourceRect = CGRectMake(CGRectGetMidX(host.view.bounds), CGRectGetMidY(host.view.bounds), 1, 1);
            pop.permittedArrowDirections = 0;
        }
        [host presentViewController:sheet animated:YES completion:nil];
        return;
    }
    NSMutableArray *titleLines = [NSMutableArray array];
    for (NSString *bid in targets) {
        [titleLines addObject:ChengIOSBundleDisplayTitle(bid)];
    }
    NSString *list = titleLines.count ? [titleLines componentsJoinedByString:@"\n"] : @"(未选择用户应用)";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除应用数据"
                                                                   message:[NSString stringWithFormat:@"终止应用并清除沙盒:\n%@\n\n如果未备份则无法撤销。", list]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go(targets);
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}


static NSString *CIEraseResultText(NSDictionary *result, NSError *error, NSString *okTitle) {
    NSMutableString *msg = [NSMutableString string];
    NSArray *ok = result[@"ok"];
    NSArray *failed = result[@"failed"];
    NSArray *skipped = result[@"skipped"];
    if (ok.count) {
        [msg appendFormat:@"已清除: %@\n", CIJoinTitles(ok)];
    }
    if (failed.count) {
        [msg appendFormat:@"错误: %@\n", CIJoinTitles(failed)];
    }
    if (skipped.count) {
        [msg appendFormat:@"跳过: %@\n", CIJoinTitles(skipped)];
    }
    if ([result[@"profileSummary"] length]) {
        [msg appendFormat:@"\n%@\n", result[@"profileSummary"]];
    }
    if (error && msg.length == 0) {
        [msg appendString:ChengIOSBackupErrorMessage(error)];
    }
    if (msg.length == 0) {
        [msg appendString:okTitle ?: @"完成。"];
    }
    return msg;
}

void ChengIOSRunEraseSafari(UIViewController *host, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在清除Safari", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseSafari(&error);
            done(result[@"ok"] ? @"已清除Safari" : @"清除Safari", CIEraseResultText(result, error, @"已清除历史记录/cookies/网站数据。iCloud钥匙串密码不会被清除。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除Safari"
                                                                   message:@"清除历史记录、cookies、网站数据、标签页。如同新安装的Safari。不会清除iCloud钥匙串密码。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除Safari" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunEraseDevice(UIViewController *host, BOOL silent) {
    void (^go)(void) = ^{
        CIRunBusy(host, @"正在清除所有应用数据", ^(void (^done)(NSString *, NSString *)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseDeviceApps(YES, &error);
            done(@"已清除设备数据", CIEraseResultText(result, error, @"已清除用户应用+Safari的数据。不是恢复iOS。越狱/照片/短信/Apple ID仍然保留。"));
        });
    };
    if (silent) {
        go();
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除所有应用数据"
                                                                   message:@"清除所有用户应用+Safari的数据（如同重新安装应用）。不是iOS恢复出厂设置。保留越狱、照片、短信、Apple ID。无法撤销。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"清除所有应用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

void ChengIOSRunEraseThenRandom(UIViewController *host, NSArray<NSString *> *bundleIDs, BOOL allDevice, BOOL randomAll, NSString *region, BOOL silent, BOOL respring) {
    NSArray *list = bundleIDs.count ? bundleIDs : (allDevice ? @[] : ChengIOSUserSelectedBundleIDs());
    if (!allDevice && list.count == 0) {
        CIPresent(host, @"未选择应用", @"打开\"选择应用\"，勾选TikTok / Facebook / Shopee / Safari，然后重试清除+随机。");
        return;
    }
    void (^go)(void) = ^{
        CIRunBusyEx(host, allDevice ? @"清除全部+随机" : @"清除应用+随机", ^(void (^done)(NSString *, NSString *, BOOL)) {
            NSError *error = nil;
            NSDictionary *result = ChengIOSEraseThenRandom(list, allDevice, randomAll, region, &error);
            NSArray *ok = result[@"ok"];
            NSString *msg = CIFormatEraseRandomText(result, error);
            BOOL didChange = [result[@"profileSummary"] length] > 0;
            done(ok.count ? @"已清除+更改信息" : @"清除+随机", msg, respring && didChange);
        });
    };
    if (silent) {
        go();
        return;
    }
    NSString *title = allDevice ? @"清除全部+随机" : @"清除已选应用+随机";
    NSString *msg = allDevice
        ? @"清除所有用户应用+Safari的数据，然后随机生成全部，然后Respring。Shopee/TikTok在随机后会再清除一次。不是iOS恢复出厂设置。无法撤销。"
        : [NSString stringWithFormat:@"清除%lu个已选应用的沙盒/钥匙串，然后随机生成信息，然后Respring。Shopee/TikTok在随机后会再清除一次。无法撤销。", (unsigned long)list.count];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:randomAll ? @"清除+随机生成全部" : @"清除+随机生成设备信息" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            go();
        });
    }]];
    [host presentViewController:alert animated:YES completion:nil];
}

BOOL ChengIOSHandleBackupURL(NSURL *url, UIViewController *host) {
    if (!url || !host) {
        return NO;
    }
    NSString *token = CIToken(url);
    BOOL silent = CIFlag(url, @[@"silent", @"quiet", @"x-silent"]);
    BOOL respring = !CIFlag(url, @[@"norespring", @"skip-respring"]);
    NSString *name = CIQuery(url, @"name") ?: CIQuery(url, @"title") ?: CIQuery(url, @"label");
    BOOL wantData = CIFlag(url, @[@"data", @"appdata", @"apps", @"full"]);
    NSString *backupID = CIQuery(url, @"id") ?: CIQuery(url, @"backup") ?: CIQuery(url, @"backup-id");

    NSString *region = CIQuery(url, @"region") ?: CIQuery(url, @"iso");
    if ([token containsString:@"backup-erase-random"] || [token containsString:@"backup-wipe-random"] || [token containsString:@"backup-random-erase"] || [token containsString:@"backup-xoa-random"]) {
        ChengIOSRunBackupEraseRandom(host, name, CIBundlesFromQuery(url), silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-device-random"] || [token containsString:@"wipe-device-random"] || [token containsString:@"factory-random"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), YES, YES, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-random-all"] || [token containsString:@"wipe-random-all"] || [token containsString:@"reset-all"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), NO, YES, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-random"] || [token containsString:@"wipe-random"] || [token containsString:@"reset-identity"]) {
        ChengIOSRunEraseThenRandom(host, CIBundlesFromQuery(url), NO, NO, region, silent, respring);
        return YES;
    }
    if ([token containsString:@"erase-device"] || [token containsString:@"wipe-device"] || [token containsString:@"erase-all-apps"]) {
        ChengIOSRunEraseDevice(host, silent);
        return YES;
    }
    if ([token containsString:@"erase-safari"] || [token containsString:@"wipe-safari"]) {
        ChengIOSRunEraseSafari(host, silent);
        return YES;
    }
    if ([token containsString:@"backup-apps"] || [token containsString:@"backup-data"] || [token containsString:@"backup-all"] || [token containsString:@"backup-now"]) {
        NSArray *queryBundles = CIBundlesFromQuery(url);
        if (queryBundles.count > 0 || silent) {
            ChengIOSRunCreateBackup(host, name, YES, queryBundles, silent);
        } else {
            ChengIOSRunPickBackup(host, name, silent);
        }
        return YES;
    }
    if ([token containsString:@"backup-profile"] || [token containsString:@"backup-info"] || [token containsString:@"backup-hoso"]) {
        ChengIOSRunCreateBackup(host, name, NO, @[], silent);
        return YES;
    }
    if ([token isEqualToString:@"backup"] || [token isEqualToString:@"backups"] || [token containsString:@"backup-manager"] || [token containsString:@"quan-ly-backup"]) {
        if (![host isKindOfClass:[BackupListViewController class]]) {
            BackupListViewController *list = [[BackupListViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [host.navigationController pushViewController:list animated:YES];
        }
        return YES;
    }
    if ([token containsString:@"restore-latest"] || [token isEqualToString:@"restorelatest"]) {
        NSString *latest = ChengIOSLatestBackupID();
        if (latest.length == 0) {
            CIPresent(host, @"恢复", @"没有备份。");
            return YES;
        }
        ChengIOSRunRestore(host, latest, YES, wantData, silent);
        return YES;
    }
    if ([token isEqualToString:@"restore"] || [token hasPrefix:@"restore-"]) {
        if (backupID.length == 0) {
            backupID = ChengIOSLatestBackupID();
        }
        BOOL noProfile = CIFlag(url, @[@"noprofile", @"profile-off"]);
        NSString *profileValue = CIQuery(url, @"profile");
        BOOL restoreProfile = !noProfile;
        if (profileValue.length && ([profileValue isEqualToString:@"0"] || [profileValue caseInsensitiveCompare:@"no"] == NSOrderedSame)) {
            restoreProfile = NO;
        }
        ChengIOSRunRestore(host, backupID, restoreProfile, wantData, silent);
        return YES;
    }
    if ([token containsString:@"erase-apps"] || [token containsString:@"wipe-apps"] || [token isEqualToString:@"wipe"] || [token isEqualToString:@"erase-all"] || [token isEqualToString:@"eraseall"]) {
        ChengIOSRunErase(host, CIBundlesFromQuery(url), silent);
        return YES;
    }
    if ([token isEqualToString:@"erase"] || [token isEqualToString:@"wipe-app"] || [token hasPrefix:@"erase-"]) {
        NSArray *bundles = CIBundlesFromQuery(url);
        ChengIOSRunErase(host, bundles, silent);
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"备份列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(reloadBackups)];
    [self reloadBackups];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadBackups];
}

- (void)reloadBackups {
    self.backups = ChengIOSListBackups();
    [self.tableView reloadData];
}

- (void)promptBackupIncludingAppData:(BOOL)includeAppData suggestedName:(NSString *)name silent:(BOOL)silent {
    if (includeAppData) {
        ChengIOSRunPickBackup(self, name, silent);
        return;
    }
    ChengIOSRunCreateBackup(self, name, includeAppData, nil, silent);
}

- (void)promptEraseBundles:(NSArray<NSString *> *)bundleIDs silent:(BOOL)silent {
    ChengIOSRunErase(self, bundleIDs, silent);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return (NSInteger)MAX(self.backups.count, 1);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return @"备份列表";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    (void)section;
    return [NSString stringWithFormat:@"目录: %@\n备份/清除/随机操作在主屏幕。点击条目可恢复、重命名或删除。备份后需要钥匙串withData>0、kcUid 501、Root有、ldid有。", ChengIOSBackupRoot()];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"b"];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (self.backups.count == 0) {
        cell.textLabel.text = @"没有备份";
        cell.detailTextLabel.text = @"在主屏幕使用备份功能，当应用处于登录状态时。";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NSDictionary *item = self.backups[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = item[@"name"] ?: item[@"id"];
    NSMutableString *detail = [NSMutableString string];
    if ([item[@"created"] length]) {
        [detail appendString:item[@"created"]];
    }
    NSArray *bundles = item[@"bundles"];
    if ([item[@"includeAppData"] boolValue] && [bundles isKindOfClass:[NSArray class]]) {
        [detail appendFormat:@"  ·  %lu个应用  ·  %@", (unsigned long)bundles.count, CIBytesString([item[@"bytes"] unsignedLongLongValue])];
        if (item[@"keychainItems"]) {
            [detail appendFormat:@"  ·  KC %@", item[@"keychainItems"]];
        }
        if (item[@"kcUid"]) {
            [detail appendFormat:@"  ·  kcUid %@", item[@"kcUid"]];
        }
        if (item[@"asRoot"]) {
            [detail appendFormat:@"  ·  root %@", [item[@"asRoot"] boolValue] ? @"有" : @"无"];
        }
    } else {
        [detail appendString:@"  ·  配置"];
    }
    NSString *summary = item[@"profileSummary"];
    if ([summary isKindOfClass:[NSString class]] && summary.length > 0) {
        NSArray *lines = [summary componentsSeparatedByString:@"\n"];
        [detail appendFormat:@"\n%@", lines.firstObject];
    }
    cell.detailTextLabel.text = detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.backups.count == 0) {
        return;
    }
    NSDictionary *item = self.backups[indexPath.row];
    NSString *backupID = item[@"id"];
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:item[@"name"] ?: backupID
                                                                   message:item[@"created"]
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复配置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, YES, NO, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复配置+应用数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, YES, YES, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"仅恢复应用数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSRunRestore(self, backupID, NO, YES, NO);
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        [self renameBackup:item];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"复制ID/路径" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSString *text = [NSString stringWithFormat:@"%@\nchengios://restore?id=%@\n%@", item[@"name"], backupID, item[@"path"]];
        [UIPasteboard generalPasteboard].string = text;
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"删除此备份" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        if (ChengIOSDeleteBackup(backupID, &error)) {
            [self reloadBackups];
        } else {
            CIPresent(self, @"删除备份错误", ChengIOSBackupErrorMessage(error));
        }
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *pop = sheet.popoverPresentationController;
    if (pop) {
        pop.sourceView = tableView;
        pop.sourceRect = [tableView rectForRowAtIndexPath:indexPath];
    }
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)renameBackup:(NSDictionary *)item {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重命名备份"
                                                                   message:item[@"id"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = item[@"name"];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        if (ChengIOSRenameBackup(item[@"id"], alert.textFields.firstObject.text, &error)) {
            [self reloadBackups];
        } else {
            CIPresent(self, @"重命名错误", ChengIOSBackupErrorMessage(error));
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    return self.backups.count > 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    (void)tableView;
    if (editingStyle != UITableViewCellEditingStyleDelete || self.backups.count == 0) {
        return;
    }
    NSString *backupID = self.backups[indexPath.row][@"id"];
    ChengIOSDeleteBackup(backupID, nil);
    [self reloadBackups];
}

@end
