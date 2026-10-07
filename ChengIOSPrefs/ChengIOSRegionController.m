#import "ChengIOSRegionController.h"
#import "ChengIOSProfiles.h"

#import <UIKit/UIKit.h>

@implementation ChengIOSRegionController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Regions" target:self];
    }
    return _specifiers;
}

- (void)randomizeISO:(NSString *)iso title:(NSString *)title {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *profile = iso.length ? ChengIOSRandomFullProfileInRegion(iso) : ChengIOSRandomFullProfile();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self chengApplyAndRespring:profile title:title];
        });
    });
}

- (void)randomizeRegionAuto { [self randomizeISO:nil title:@"根据 IP 随机生成"]; }
- (void)randomizeRegionVN { [self randomizeISO:@"vn" title:@"随机生成越南环境"]; }
- (void)randomizeRegionUS { [self randomizeISO:@"us" title:@"随机生成美国环境"]; }
- (void)randomizeRegionKR { [self randomizeISO:@"kr" title:@"随机生成韩国环境"]; }
- (void)randomizeRegionJP { [self randomizeISO:@"jp" title:@"随机生成日本环境"]; }
- (void)randomizeRegionGB { [self randomizeISO:@"gb" title:@"随机生成英国环境"]; }
- (void)randomizeRegionTH { [self randomizeISO:@"th" title:@"随机生成泰国环境"]; }
- (void)randomizeRegionSG { [self randomizeISO:@"sg" title:@"随机生成新加坡环境"]; }
- (void)randomizeRegionAU { [self randomizeISO:@"au" title:@"随机生成澳大利亚环境"]; }
- (void)randomizeRegionTW { [self randomizeISO:@"tw" title:@"随机生成台湾环境"]; }
- (void)randomizeRegionFR { [self randomizeISO:@"fr" title:@"随机生成法国环境"]; }
- (void)randomizeRegionES { [self randomizeISO:@"es" title:@"随机生成西班牙环境"]; }
- (void)randomizeRegionPL { [self randomizeISO:@"pl" title:@"随机生成波兰环境"]; }
@end
