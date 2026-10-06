#import "DeeplinkListViewController.h"

@interface DeeplinkListViewController ()
@property (nonatomic, copy) NSArray<NSDictionary *> *items;
@end

@implementation DeeplinkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"深度链接";
    self.items = @[
        @{@"title": @"随机生成设备信息", @"url": @"chengios://random-identity"},
        @{@"title": @"随机生成全部", @"url": @"chengios://random-all"},
        @{@"title": @"随机生成越南", @"url": @"chengios://random-all?region=vn"},
        @{@"title": @"随机生成美国", @"url": @"chengios://random-all?region=us"},
        @{@"title": @"随机生成韩国", @"url": @"chengios://random-all?region=kr"},
        @{@"title": @"随机生成日本", @"url": @"chengios://random-all?region=jp"},
        @{@"title": @"随机生成英国", @"url": @"chengios://random-all?region=gb"},
        @{@"title": @"随机生成泰国", @"url": @"chengios://random-all?region=th"},
        @{@"title": @"随机生成新加坡", @"url": @"chengios://random-all?region=sg"},
        @{@"title": @"随机生成澳大利亚", @"url": @"chengios://random-all?region=au"},
        @{@"title": @"随机生成台湾", @"url": @"chengios://random-all?region=tw"},
        @{@"title": @"按地区随机生成", @"url": @"chengios://regions"},
        @{@"title": @"选择应用", @"url": @"chengios://apps"},
        @{@"title": @"查看配置", @"url": @"chengios://profile"},
        @{@"title": @"复制配置", @"url": @"chengios://copy"},
        @{@"title": @"打开设置", @"url": @"chengios://settings"},
        @{@"title": @"备份管理", @"url": @"chengios://backup"},
        @{@"title": @"备份配置", @"url": @"chengios://backup-profile"},
        @{@"title": @"备份配置+应用数据", @"url": @"chengios://backup-apps"},
        @{@"title": @"备份+清除+随机+Respring", @"url": @"chengios://backup-erase-random"},
        @{@"title": @"备份1个应用（Facebook）", @"url": @"chengios://backup-apps?bundle=com.facebook.Facebook"},
        @{@"title": @"恢复最新备份", @"url": @"chengios://restore-latest"},
        @{@"title": @"恢复最新+数据", @"url": @"chengios://restore-latest?data=1"},
        @{@"title": @"清除已选应用数据", @"url": @"chengios://erase-apps"},
        @{@"title": @"清除Facebook数据", @"url": @"chengios://erase?bundle=com.facebook.Facebook"},
        @{@"title": @"清除已选+随机生成全部", @"url": @"chengios://erase-random-all"},
        @{@"title": @"清除Shopee数据", @"url": @"chengios://erase?bundle=com.beeasy.shopee.vn"},
        @{@"title": @"清除全部+随机生成全部", @"url": @"chengios://erase-device-random"},
        @{@"title": @"Respring", @"url": @"chengios://respring"},
        @{@"title": @"随机生成（静默）", @"url": @"chengios://random-all?silent=1"},
        @{@"title": @"随机生成（静默不Respring）", @"url": @"chengios://random-all?silent=1&norespring=1"}
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    (void)tableView; (void)section;
    return (NSInteger)self.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    (void)tableView; (void)section;
    return @"点击条目复制URL。快捷指令：使用\"打开URL\"操作。";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"d"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"d"];
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    NSDictionary *item = self.items[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.detailTextLabel.text = item[@"url"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *url = self.items[indexPath.row][@"url"];
    [UIPasteboard generalPasteboard].string = url;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已复制"
                                                                   message:url
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
