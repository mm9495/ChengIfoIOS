#import "ChengIOSBackupController.h"
#import "ChengIOSBackup.h"
#import "ChengIOSProfiles.h"

#import <UIKit/UIKit.h>

@interface ChengIOSBackupController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSDictionary *> *backups;
@end

@implementation ChengIOSBackupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"备份 / 数据";
    self.backups = @[];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = (id)self;
    self.tableView.delegate = (id)self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadBackups];
}

- (void)reloadBackups {
    self.backups = ChengIOSListBackups();
    [self.tableView reloadData];
}

- (void)openURLString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    if (!url) {
        return;
    }
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)alertTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    (void)tableView;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) {
        return 4;
    }
    return (NSInteger)MAX(self.backups.count, 1);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    (void)tableView;
    return section == 0 ? @"操作选项" : @"备份列表";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView;
    if (section == 0) {
        return @"在设置中可立即备份环境配置。备份/清除应用数据需打开 ChengIOS 应用（无沙盒限制）。Safari 和系统数据不会被清除。";
    }
    return ChengIOSBackupRoot();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"c"];
        cell.detailTextLabel.numberOfLines = 3;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if (indexPath.section == 0) {
        NSArray *titles = @[
            @"备份当前环境配置",
            @"备份环境 + 应用数据（打开应用）",
            @"清除已选应用数据（打开应用）",
            @"打开备份管理器（应用）"
        ];
        NSArray *details = @[
            @"保存环境配置到 Media/ChengIOS/Backups",
            @"chengios://backup-apps",
            @"chengios://erase-apps",
            @"chengios://backup"
        ];
        cell.textLabel.text = titles[indexPath.row];
        cell.detailTextLabel.text = details[indexPath.row];
        return cell;
    }
    if (self.backups.count == 0) {
        cell.textLabel.text = @"暂无备份";
        cell.detailTextLabel.text = @"请在上方创建环境配置备份。";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NSDictionary *item = self.backups[indexPath.row];
    cell.textLabel.text = item[@"name"] ?: item[@"id"];
    NSArray *bundles = item[@"bundles"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  ·  %@", item[@"created"] ?: @"", [item[@"includeAppData"] boolValue] ? [NSString stringWithFormat:@"%lu 个应用", (unsigned long)[bundles count]] : @"环境配置"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self backupProfile];
        } else if (indexPath.row == 1) {
            [self openURLString:@"chengios://backup-apps"];
        } else if (indexPath.row == 2) {
            [self openURLString:@"chengios://erase-apps"];
        } else {
            [self openURLString:@"chengios://backup"];
        }
        return;
    }
    if (self.backups.count == 0) {
        return;
    }
    NSDictionary *item = self.backups[indexPath.row];
    NSString *backupID = item[@"id"];
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:item[@"name"] ?: backupID
                                                                   message:item[@"created"]
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复环境配置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        if (ChengIOSRestoreBackup(backupID, YES, NO, &error)) {
            [self alertTitle:@"恢复成功" message:@"请强制关闭目标应用后重新打开。"];
        } else {
            [self alertTitle:@"恢复失败" message:ChengIOSBackupErrorMessage(error)];
        }
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"恢复环境 + 数据（打开应用）" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        [self openURLString:[NSString stringWithFormat:@"chengios://restore?id=%@&data=1", backupID]];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"删除此备份" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        (void)action;
        ChengIOSDeleteBackup(backupID, nil);
        [self reloadBackups];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *pop = sheet.popoverPresentationController;
    if (pop) {
        pop.sourceView = tableView;
        pop.sourceRect = [tableView rectForRowAtIndexPath:indexPath];
    }
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)backupProfile {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"备份环境配置"
                                                                   message:@"保存当前 ChengIOS 环境配置。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = ChengIOSSuggestedBackupName();
        field.placeholder = @"备份名称";
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"备份" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        (void)action;
        NSError *error = nil;
        NSDictionary *meta = ChengIOSCreateBackup(alert.textFields.firstObject.text, @[], NO, &error);
        if (meta && !error) {
            [self reloadBackups];
            [self alertTitle:@"备份成功" message:[NSString stringWithFormat:@"%@\nID: %@", meta[@"name"], meta[@"id"]]];
        } else {
            [self alertTitle:@"备份失败" message:ChengIOSBackupErrorMessage(error)];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
