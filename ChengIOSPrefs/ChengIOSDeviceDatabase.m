// ChengIOSDeviceDatabase.m
// 真实苹果设备数据库 - iPhone 11 至 16 全系列（2026年10月版）

#import <Foundation/Foundation.h>

@interface ChengIOSDeviceDatabase : NSObject
+ (NSDictionary *)randomRealisticDeviceForRegion:(NSString *)region;
+ (NSArray *)allDevices;
@end

@implementation ChengIOSDeviceDatabase

#pragma mark - iPhone 11 系列 (2019) - iOS 13.0 - 17.5

+ (NSArray *)iPhone11Series {
    return @[
        // iPhone 11 - 64GB
        @{@"model": @"MWLT2ZD/A", @"name": @"iPhone 11", @"color": @"黑色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLX2ZD/A", @"name": @"iPhone 11", @"color": @"绿色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLY2ZD/A", @"name": @"iPhone 11", @"color": @"黄色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLU2ZD/A", @"name": @"iPhone 11", @"color": @"紫色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLV2ZD/A", @"name": @"iPhone 11", @"color": @"红色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLW2ZD/A", @"name": @"iPhone 11", @"color": @"白色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 - 128GB
        @{@"model": @"MWL82ZD/A", @"name": @"iPhone 11", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLA2ZD/A", @"name": @"iPhone 11", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLC2ZD/A", @"name": @"iPhone 11", @"color": @"黄色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLD2ZD/A", @"name": @"iPhone 11", @"color": @"紫色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLE2ZD/A", @"name": @"iPhone 11", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLF2ZD/A", @"name": @"iPhone 11", @"color": @"白色", @"storage": @"128GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 - 256GB
        @{@"model": @"MWLJ2ZD/A", @"name": @"iPhone 11", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLK2ZD/A", @"name": @"iPhone 11", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLL2ZD/A", @"name": @"iPhone 11", @"color": @"黄色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLM2ZD/A", @"name": @"iPhone 11", @"color": @"紫色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLN2ZD/A", @"name": @"iPhone 11", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWLP2ZD/A", @"name": @"iPhone 11", @"color": @"白色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        
        // iPhone 11 Pro - 64GB
        @{@"model": @"MWC22ZD/A", @"name": @"iPhone 11 Pro", @"color": @"深空灰", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWC32ZD/A", @"name": @"iPhone 11 Pro", @"color": @"银色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWC52ZD/A", @"name": @"iPhone 11 Pro", @"color": @"金色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWC62ZD/A", @"name": @"iPhone 11 Pro", @"color": @"暗夜绿", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 Pro - 256GB
        @{@"model": @"MWC92ZD/A", @"name": @"iPhone 11 Pro", @"color": @"深空灰", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCC2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCD2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCE2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"暗夜绿", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 Pro - 512GB
        @{@"model": @"MWCL2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"深空灰", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCN2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCP2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWCQ2ZD/A", @"name": @"iPhone 11 Pro", @"color": @"暗夜绿", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        
        // iPhone 11 Pro Max - 64GB
        @{@"model": @"MWHG2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"深空灰", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHH2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"银色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHJ2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"金色", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHK2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"暗夜绿", @"storage": @"64GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 Pro Max - 256GB
        @{@"model": @"MWHL2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"深空灰", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHM2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHN2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHP2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"暗夜绿", @"storage": @"256GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        // iPhone 11 Pro Max - 512GB
        @{@"model": @"MWHQ2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"深空灰", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHR2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHT2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
        @{@"model": @"MWHU2ZD/A", @"name": @"iPhone 11 Pro Max", @"color": @"暗夜绿", @"storage": @"512GB", @"minIOS": @"13.0", @"maxIOS": @"17.5"},
    ];
}

#pragma mark - iPhone 12 系列 (2020) - iOS 14.1 - 17.5

+ (NSArray *)iPhone12Series {
    return @[
        // iPhone 12 mini - 64GB
        @{@"model": @"MGDY3ZD/A", @"name": @"iPhone 12 mini", @"color": @"黑色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE03ZD/A", @"name": @"iPhone 12 mini", @"color": @"白色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE13ZD/A", @"name": @"iPhone 12 mini", @"color": @"红色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE23ZD/A", @"name": @"iPhone 12 mini", @"color": @"绿色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE33ZD/A", @"name": @"iPhone 12 mini", @"color": @"蓝色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE43ZD/A", @"name": @"iPhone 12 mini", @"color": @"紫色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 mini - 128GB
        @{@"model": @"MGE53ZD/A", @"name": @"iPhone 12 mini", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE63ZD/A", @"name": @"iPhone 12 mini", @"color": @"白色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE73ZD/A", @"name": @"iPhone 12 mini", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE83ZD/A", @"name": @"iPhone 12 mini", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGE93ZD/A", @"name": @"iPhone 12 mini", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEA3ZD/A", @"name": @"iPhone 12 mini", @"color": @"紫色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 mini - 256GB
        @{@"model": @"MGEF3ZD/A", @"name": @"iPhone 12 mini", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEG3ZD/A", @"name": @"iPhone 12 mini", @"color": @"白色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEH3ZD/A", @"name": @"iPhone 12 mini", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEJ3ZD/A", @"name": @"iPhone 12 mini", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEK3ZD/A", @"name": @"iPhone 12 mini", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGEL3ZD/A", @"name": @"iPhone 12 mini", @"color": @"紫色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        
        // iPhone 12 - 64GB
        @{@"model": @"MGJ53ZD/A", @"name": @"iPhone 12", @"color": @"黑色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJ63ZD/A", @"name": @"iPhone 12", @"color": @"白色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJ73ZD/A", @"name": @"iPhone 12", @"color": @"红色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJ83ZD/A", @"name": @"iPhone 12", @"color": @"绿色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJ93ZD/A", @"name": @"iPhone 12", @"color": @"蓝色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJA3ZD/A", @"name": @"iPhone 12", @"color": @"紫色", @"storage": @"64GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 - 128GB
        @{@"model": @"MGJC3ZD/A", @"name": @"iPhone 12", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJD3ZD/A", @"name": @"iPhone 12", @"color": @"白色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJE3ZD/A", @"name": @"iPhone 12", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJF3ZD/A", @"name": @"iPhone 12", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJG3ZD/A", @"name": @"iPhone 12", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGJH3ZD/A", @"name": @"iPhone 12", @"color": @"紫色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 - 256GB
        @{@"model": @"MGJY3ZD/A", @"name": @"iPhone 12", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGK03ZD/A", @"name": @"iPhone 12", @"color": @"白色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGK13ZD/A", @"name": @"iPhone 12", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGK23ZD/A", @"name": @"iPhone 12", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGK33ZD/A", @"name": @"iPhone 12", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGK43ZD/A", @"name": @"iPhone 12", @"color": @"紫色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        
        // iPhone 12 Pro - 128GB
        @{@"model": @"MGM53ZD/A", @"name": @"iPhone 12 Pro", @"color": @"石墨色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGM63ZD/A", @"name": @"iPhone 12 Pro", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGM73ZD/A", @"name": @"iPhone 12 Pro", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGM83ZD/A", @"name": @"iPhone 12 Pro", @"color": @"海蓝色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 Pro - 256GB
        @{@"model": @"MGMA3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"石墨色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGMC3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGMD3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGME3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"海蓝色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 Pro - 512GB
        @{@"model": @"MGMF3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"石墨色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGMG3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGMH3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGMJ3ZD/A", @"name": @"iPhone 12 Pro", @"color": @"海蓝色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        
        // iPhone 12 Pro Max - 128GB
        @{@"model": @"MGD93ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"石墨色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDA3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDC3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDD3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"海蓝色", @"storage": @"128GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 Pro Max - 256GB
        @{@"model": @"MGDE3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"石墨色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDF3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDG3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDH3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"海蓝色", @"storage": @"256GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        // iPhone 12 Pro Max - 512GB
        @{@"model": @"MGDJ3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"石墨色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDK3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDL3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
        @{@"model": @"MGDM3ZD/A", @"name": @"iPhone 12 Pro Max", @"color": @"海蓝色", @"storage": @"512GB", @"minIOS": @"14.1", @"maxIOS": @"17.5"},
    ];
}

#pragma mark - iPhone 13 系列 (2021) - iOS 15.0 - 17.5

+ (NSArray *)iPhone13Series {
    return @[
        // iPhone 13 mini - 128GB
        @{@"model": @"MLK03ZD/A", @"name": @"iPhone 13 mini", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK13ZD/A", @"name": @"iPhone 13 mini", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK23ZD/A", @"name": @"iPhone 13 mini", @"color": @"午夜色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK33ZD/A", @"name": @"iPhone 13 mini", @"color": @"星光色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK43ZD/A", @"name": @"iPhone 13 mini", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK53ZD/A", @"name": @"iPhone 13 mini", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 mini - 256GB
        @{@"model": @"MLK63ZD/A", @"name": @"iPhone 13 mini", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK73ZD/A", @"name": @"iPhone 13 mini", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK83ZD/A", @"name": @"iPhone 13 mini", @"color": @"午夜色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLK93ZD/A", @"name": @"iPhone 13 mini", @"color": @"星光色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKA3ZD/A", @"name": @"iPhone 13 mini", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKC3ZD/A", @"name": @"iPhone 13 mini", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 mini - 512GB
        @{@"model": @"MLKD3ZD/A", @"name": @"iPhone 13 mini", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKE3ZD/A", @"name": @"iPhone 13 mini", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKF3ZD/A", @"name": @"iPhone 13 mini", @"color": @"午夜色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKG3ZD/A", @"name": @"iPhone 13 mini", @"color": @"星光色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKH3ZD/A", @"name": @"iPhone 13 mini", @"color": @"红色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLKJ3ZD/A", @"name": @"iPhone 13 mini", @"color": @"绿色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        
        // iPhone 13 - 128GB
        @{@"model": @"MLP73ZD/A", @"name": @"iPhone 13", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLP83ZD/A", @"name": @"iPhone 13", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLP93ZD/A", @"name": @"iPhone 13", @"color": @"午夜色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPA3ZD/A", @"name": @"iPhone 13", @"color": @"星光色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPC3ZD/A", @"name": @"iPhone 13", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPD3ZD/A", @"name": @"iPhone 13", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 - 256GB
        @{@"model": @"MLPF3ZD/A", @"name": @"iPhone 13", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPG3ZD/A", @"name": @"iPhone 13", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPH3ZD/A", @"name": @"iPhone 13", @"color": @"午夜色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPJ3ZD/A", @"name": @"iPhone 13", @"color": @"星光色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPK3ZD/A", @"name": @"iPhone 13", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPL3ZD/A", @"name": @"iPhone 13", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 - 512GB
        @{@"model": @"MLPM3ZD/A", @"name": @"iPhone 13", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPN3ZD/A", @"name": @"iPhone 13", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPP3ZD/A", @"name": @"iPhone 13", @"color": @"午夜色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPQ3ZD/A", @"name": @"iPhone 13", @"color": @"星光色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPR3ZD/A", @"name": @"iPhone 13", @"color": @"红色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLPT3ZD/A", @"name": @"iPhone 13", @"color": @"绿色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        
        // iPhone 13 Pro - 128GB
        @{@"model": @"MLV93ZD/A", @"name": @"iPhone 13 Pro", @"color": @"石墨色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVA3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVC3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVD3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"远峰蓝", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVE3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"苍岭绿", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro - 256GB
        @{@"model": @"MLVF3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"石墨色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVG3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVH3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVJ3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"远峰蓝", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVK3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"苍岭绿", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro - 512GB
        @{@"model": @"MLVL3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"石墨色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVM3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVN3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVP3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"远峰蓝", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVQ3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"苍岭绿", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro - 1TB
        @{@"model": @"MLVR3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"石墨色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVT3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"银色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVU3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"金色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVV3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"远峰蓝", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLVW3ZD/A", @"name": @"iPhone 13 Pro", @"color": @"苍岭绿", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        
        // iPhone 13 Pro Max - 128GB
        @{@"model": @"MLL93ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"石墨色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLA3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLC3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLD3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"远峰蓝", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLE3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"苍岭绿", @"storage": @"128GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro Max - 256GB
        @{@"model": @"MLLF3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"石墨色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLG3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLH3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLJ3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"远峰蓝", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLK3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"苍岭绿", @"storage": @"256GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro Max - 512GB
        @{@"model": @"MLLL3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"石墨色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLM3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLN3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLP3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"远峰蓝", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLQ3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"苍岭绿", @"storage": @"512GB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        // iPhone 13 Pro Max - 1TB
        @{@"model": @"MLLR3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"石墨色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLT3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"银色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLU3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"金色", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLV3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"远峰蓝", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
        @{@"model": @"MLLW3ZD/A", @"name": @"iPhone 13 Pro Max", @"color": @"苍岭绿", @"storage": @"1TB", @"minIOS": @"15.0", @"maxIOS": @"17.5"},
    ];
}

#pragma mark - iPhone 14 系列 (2022) - iOS 16.0 - 17.5

+ (NSArray *)iPhone14Series {
    return @[
        // iPhone 14 - 128GB
        @{@"model": @"MPUN3ZD/A", @"name": @"iPhone 14", @"color": @"午夜色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUP3ZD/A", @"name": @"iPhone 14", @"color": @"星光色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUQ3ZD/A", @"name": @"iPhone 14", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUR3ZD/A", @"name": @"iPhone 14", @"color": @"紫色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUT3ZD/A", @"name": @"iPhone 14", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUU3ZD/A", @"name": @"iPhone 14", @"color": @"黄色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 - 256GB
        @{@"model": @"MPUV3ZD/A", @"name": @"iPhone 14", @"color": @"午夜色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUW3ZD/A", @"name": @"iPhone 14", @"color": @"星光色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUX3ZD/A", @"name": @"iPhone 14", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPUY3ZD/A", @"name": @"iPhone 14", @"color": @"紫色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV03ZD/A", @"name": @"iPhone 14", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV13ZD/A", @"name": @"iPhone 14", @"color": @"黄色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 - 512GB
        @{@"model": @"MPV23ZD/A", @"name": @"iPhone 14", @"color": @"午夜色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV33ZD/A", @"name": @"iPhone 14", @"color": @"星光色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV43ZD/A", @"name": @"iPhone 14", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV53ZD/A", @"name": @"iPhone 14", @"color": @"紫色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV63ZD/A", @"name": @"iPhone 14", @"color": @"红色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MPV73ZD/A", @"name": @"iPhone 14", @"color": @"黄色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        
        // iPhone 14 Plus - 128GB
        @{@"model": @"MQ4X3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"午夜色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ4Y3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"星光色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ503ZD/A", @"name": @"iPhone 14 Plus", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ513ZD/A", @"name": @"iPhone 14 Plus", @"color": @"紫色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ523ZD/A", @"name": @"iPhone 14 Plus", @"color": @"红色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ533ZD/A", @"name": @"iPhone 14 Plus", @"color": @"黄色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Plus - 256GB
        @{@"model": @"MQ543ZD/A", @"name": @"iPhone 14 Plus", @"color": @"午夜色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ553ZD/A", @"name": @"iPhone 14 Plus", @"color": @"星光色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ563ZD/A", @"name": @"iPhone 14 Plus", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ573ZD/A", @"name": @"iPhone 14 Plus", @"color": @"紫色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ583ZD/A", @"name": @"iPhone 14 Plus", @"color": @"红色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ593ZD/A", @"name": @"iPhone 14 Plus", @"color": @"黄色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Plus - 512GB
        @{@"model": @"MQ5A3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"午夜色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ5C3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"星光色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ5D3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ5E3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"紫色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ5F3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"红色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ5G3ZD/A", @"name": @"iPhone 14 Plus", @"color": @"黄色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        
        // iPhone 14 Pro - 128GB
        @{@"model": @"MQ1F3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"深空黑色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1G3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1H3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1J3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"暗紫色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro - 256GB
        @{@"model": @"MQ1K3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"深空黑色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1L3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1M3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1N3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"暗紫色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro - 512GB
        @{@"model": @"MQ1P3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"深空黑色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1Q3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1R3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1T3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"暗紫色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro - 1TB
        @{@"model": @"MQ1U3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"深空黑色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1V3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"银色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1W3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"金色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ1X3ZD/A", @"name": @"iPhone 14 Pro", @"color": @"暗紫色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        
        // iPhone 14 Pro Max - 128GB
        @{@"model": @"MQ8T3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"深空黑色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ8U3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"银色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ8V3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"金色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ8W3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"暗紫色", @"storage": @"128GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro Max - 256GB
        @{@"model": @"MQ8X3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"深空黑色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ8Y3ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"银色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ903ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"金色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ913ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"暗紫色", @"storage": @"256GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro Max - 512GB
        @{@"model": @"MQ923ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"深空黑色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ933ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"银色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ943ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"金色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ953ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"暗紫色", @"storage": @"512GB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        // iPhone 14 Pro Max - 1TB
        @{@"model": @"MQ963ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"深空黑色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ973ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"银色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ983ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"金色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
        @{@"model": @"MQ993ZD/A", @"name": @"iPhone 14 Pro Max", @"color": @"暗紫色", @"storage": @"1TB", @"minIOS": @"16.0", @"maxIOS": @"17.5"},
    ];
}

#pragma mark - iPhone 15 系列 (2023) - iOS 17.0 - 17.5

+ (NSArray *)iPhone15Series {
    return @[
        // iPhone 15 - 128GB
        @{@"model": @"MTP03ZD/A", @"name": @"iPhone 15", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP13ZD/A", @"name": @"iPhone 15", @"color": @"黄色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP23ZD/A", @"name": @"iPhone 15", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP33ZD/A", @"name": @"iPhone 15", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP43ZD/A", @"name": @"iPhone 15", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 - 256GB
        @{@"model": @"MTP53ZD/A", @"name": @"iPhone 15", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP63ZD/A", @"name": @"iPhone 15", @"color": @"黄色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP73ZD/A", @"name": @"iPhone 15", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP83ZD/A", @"name": @"iPhone 15", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTP93ZD/A", @"name": @"iPhone 15", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 - 512GB
        @{@"model": @"MTPA3ZD/A", @"name": @"iPhone 15", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTPD3ZD/A", @"name": @"iPhone 15", @"color": @"黄色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTPE3ZD/A", @"name": @"iPhone 15", @"color": @"绿色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTPF3ZD/A", @"name": @"iPhone 15", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTPG3ZD/A", @"name": @"iPhone 15", @"color": @"黑色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        
        // iPhone 15 Plus - 128GB
        @{@"model": @"MU043ZD/A", @"name": @"iPhone 15 Plus", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU053ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黄色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU063ZD/A", @"name": @"iPhone 15 Plus", @"color": @"绿色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU073ZD/A", @"name": @"iPhone 15 Plus", @"color": @"蓝色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU083ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Plus - 256GB
        @{@"model": @"MU093ZD/A", @"name": @"iPhone 15 Plus", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0A3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黄色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0D3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"绿色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0E3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"蓝色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0F3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Plus - 512GB
        @{@"model": @"MU0G3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0H3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黄色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0J3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"绿色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0K3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"蓝色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU0L3ZD/A", @"name": @"iPhone 15 Plus", @"color": @"黑色", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        
        // iPhone 15 Pro - 128GB
        @{@"model": @"MTQ03ZD/A", @"name": @"iPhone 15 Pro", @"color": @"原色钛金属", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ13ZD/A", @"name": @"iPhone 15 Pro", @"color": @"蓝色钛金属", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ23ZD/A", @"name": @"iPhone 15 Pro", @"color": @"白色钛金属", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ33ZD/A", @"name": @"iPhone 15 Pro", @"color": @"黑色钛金属", @"storage": @"128GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Pro - 256GB
        @{@"model": @"MTQ53ZD/A", @"name": @"iPhone 15 Pro", @"color": @"原色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ63ZD/A", @"name": @"iPhone 15 Pro", @"color": @"蓝色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ73ZD/A", @"name": @"iPhone 15 Pro", @"color": @"白色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQ83ZD/A", @"name": @"iPhone 15 Pro", @"color": @"黑色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Pro - 512GB
        @{@"model": @"MTQ93ZD/A", @"name": @"iPhone 15 Pro", @"color": @"原色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQA3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"蓝色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQC3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"白色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQD3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"黑色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Pro - 1TB
        @{@"model": @"MTQE3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"原色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQF3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"蓝色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQG3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"白色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MTQH3ZD/A", @"name": @"iPhone 15 Pro", @"color": @"黑色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        
        // iPhone 15 Pro Max - 256GB
        @{@"model": @"MU1D3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"原色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1E3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"蓝色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1F3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"白色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1G3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"黑色钛金属", @"storage": @"256GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Pro Max - 512GB
        @{@"model": @"MU1H3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"原色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1J3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"蓝色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1K3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"白色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1L3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"黑色钛金属", @"storage": @"512GB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        // iPhone 15 Pro Max - 1TB
        @{@"model": @"MU1M3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"原色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1N3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"蓝色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1P3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"白色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
        @{@"model": @"MU1Q3ZD/A", @"name": @"iPhone 15 Pro Max", @"color": @"黑色钛金属", @"storage": @"1TB", @"minIOS": @"17.0", @"maxIOS": @"17.5"},
    ];
}

#pragma mark - iPhone 16 系列 (2024) - iOS 18.0

+ (NSArray *)iPhone16Series {
    return @[
        // iPhone 16 - 128GB
        @{@"model": @"MYA13ZD/A", @"name": @"iPhone 16", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYA23ZD/A", @"name": @"iPhone 16", @"color": @"白色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYA43ZD/A", @"name": @"iPhone 16", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYA53ZD/A", @"name": @"iPhone 16", @"color": @"深青色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYA63ZD/A", @"name": @"iPhone 16", @"color": @"群青色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 - 256GB
        @{@"model": @"MYA73ZD/A", @"name": @"iPhone 16", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYA83ZD/A", @"name": @"iPhone 16", @"color": @"白色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAA3ZD/A", @"name": @"iPhone 16", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAC3ZD/A", @"name": @"iPhone 16", @"color": @"深青色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAD3ZD/A", @"name": @"iPhone 16", @"color": @"群青色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 - 512GB
        @{@"model": @"MYAF3ZD/A", @"name": @"iPhone 16", @"color": @"黑色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAG3ZD/A", @"name": @"iPhone 16", @"color": @"白色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAH3ZD/A", @"name": @"iPhone 16", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAJ3ZD/A", @"name": @"iPhone 16", @"color": @"深青色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAK3ZD/A", @"name": @"iPhone 16", @"color": @"群青色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        
        // iPhone 16 Plus - 128GB
        @{@"model": @"MYAX3ZD/A", @"name": @"iPhone 16 Plus", @"color": @"黑色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYAY3ZD/A", @"name": @"iPhone 16 Plus", @"color": @"白色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB03ZD/A", @"name": @"iPhone 16 Plus", @"color": @"粉色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB13ZD/A", @"name": @"iPhone 16 Plus", @"color": @"深青色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB23ZD/A", @"name": @"iPhone 16 Plus", @"color": @"群青色", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Plus - 256GB
        @{@"model": @"MYB33ZD/A", @"name": @"iPhone 16 Plus", @"color": @"黑色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB43ZD/A", @"name": @"iPhone 16 Plus", @"color": @"白色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB53ZD/A", @"name": @"iPhone 16 Plus", @"color": @"粉色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB63ZD/A", @"name": @"iPhone 16 Plus", @"color": @"深青色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB73ZD/A", @"name": @"iPhone 16 Plus", @"color": @"群青色", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Plus - 512GB
        @{@"model": @"MYB83ZD/A", @"name": @"iPhone 16 Plus", @"color": @"黑色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYB93ZD/A", @"name": @"iPhone 16 Plus", @"color": @"白色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYBA3ZD/A", @"name": @"iPhone 16 Plus", @"color": @"粉色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYBC3ZD/A", @"name": @"iPhone 16 Plus", @"color": @"深青色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYBD3ZD/A", @"name": @"iPhone 16 Plus", @"color": @"群青色", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        
        // iPhone 16 Pro - 128GB
        @{@"model": @"MYN23ZD/A", @"name": @"iPhone 16 Pro", @"color": @"黑色钛金属", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYN33ZD/A", @"name": @"iPhone 16 Pro", @"color": @"白色钛金属", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYN53ZD/A", @"name": @"iPhone 16 Pro", @"color": @"原色钛金属", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYN63ZD/A", @"name": @"iPhone 16 Pro", @"color": @"沙漠色钛金属", @"storage": @"128GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Pro - 256GB
        @{@"model": @"MYN73ZD/A", @"name": @"iPhone 16 Pro", @"color": @"黑色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYN83ZD/A", @"name": @"iPhone 16 Pro", @"color": @"白色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYN93ZD/A", @"name": @"iPhone 16 Pro", @"color": @"原色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNA3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"沙漠色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Pro - 512GB
        @{@"model": @"MYNC3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"黑色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYND3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"白色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNF3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"原色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNG3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"沙漠色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Pro - 1TB
        @{@"model": @"MYNH3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"黑色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNJ3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"白色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNK3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"原色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYNL3ZD/A", @"name": @"iPhone 16 Pro", @"color": @"沙漠色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        
        // iPhone 16 Pro Max - 256GB
        @{@"model": @"MYTQ3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"黑色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTR3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"白色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTT3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"原色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTU3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"沙漠色钛金属", @"storage": @"256GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Pro Max - 512GB
        @{@"model": @"MYTV3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"黑色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTW3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"白色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTX3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"原色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYTY3ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"沙漠色钛金属", @"storage": @"512GB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        // iPhone 16 Pro Max - 1TB
        @{@"model": @"MYU03ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"黑色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYU13ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"白色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYU23ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"原色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
        @{@"model": @"MYU33ZD/A", @"name": @"iPhone 16 Pro Max", @"color": @"沙漠色钛金属", @"storage": @"1TB", @"minIOS": @"18.0", @"maxIOS": @"18.0"},
    ];
}

#pragma mark - 公共方法

+ (NSArray *)allDevices {
    NSMutableArray *allDevices = [NSMutableArray array];
    [allDevices addObjectsFromArray:[self iPhone11Series]];
    [allDevices addObjectsFromArray:[self iPhone12Series]];
    [allDevices addObjectsFromArray:[self iPhone13Series]];
    [allDevices addObjectsFromArray:[self iPhone14Series]];
    [allDevices addObjectsFromArray:[self iPhone15Series]];
    [allDevices addObjectsFromArray:[self iPhone16Series]];
    return allDevices;
}

+ (NSDictionary *)randomRealisticDeviceForRegion:(NSString *)region {
    NSArray *allDevices = [self allDevices];
    NSUInteger index = arc4random() % allDevices.count;
    NSDictionary *device = allDevices[index];
    
    // 生成该设备支持的随机 iOS 版本
    float minVersion = [device[@"minIOS"] floatValue];
    float maxVersion = [device[@"maxIOS"] floatValue];
    float randomVersion = minVersion + (arc4random() % (int)((maxVersion - minVersion) * 10 + 1)) / 10.0;
    NSString *iosVersion = [NSString stringWithFormat:@"%.1f", randomVersion];
    
    // 生成符合苹果规则的序列号
    NSString *serial = [self generateValidSerialForModel:device[@"model"]];
    
    // 生成 UUID
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    // 根据地区选择运营商
    NSDictionary *carrier = [self carrierForRegion:region];
    
    // 生成法国风格的设备名称
    NSString *deviceName = [self generateDeviceNameForRegion:region];
    
    return @{
        @"model": device[@"model"],
        @"name": device[@"name"],
        @"color": device[@"color"],
        @"storage": device[@"storage"],
        @"iosVersion": iosVersion,
        @"serial": serial,
        @"uuid": uuid,
        @"deviceName": deviceName,
        @"carrier": carrier[@"name"],
        @"mcc": carrier[@"mcc"],
        @"mnc": carrier[@"mnc"],
        @"region": region ?: @"FR",
    };
}

#pragma mark - 辅助方法

+ (NSString *)generateValidSerialForModel:(NSString *)model {
    // 苹果序列号规则：产地(1) + 年份(1) + 周数(2) + 唯一标识(3) + 型号代码(2) + 校验位(1)
    NSArray *factories = @[@"F", @"C", @"D", @"G"]; // F=郑州富士康, C=深圳, D=成都, G=上海和硕
    NSString *factory = factories[arc4random() % factories.count];
    
    // 年份代码（苹果使用特定字母）
    NSArray *yearCodes = @[@"3", @"4", @"5", @"6", @"7", @"8", @"9", @"C", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"M", @"N", @"P", @"Q", @"R", @"T", @"V", @"W", @"X", @"Y"];
    NSString *yearCode = yearCodes[arc4random() % yearCodes.count];
    
    // 周数（01-53）
    int week = 1 + arc4random() % 53;
    NSString *weekStr = [NSString stringWithFormat:@"%02d", week];
    
    // 唯一标识符（3位字母）
    NSString *chars = @"CDEFGHJKLMNPQRTVWXY";
    NSMutableString *unique = [NSMutableString string];
    for (int i = 0; i < 3; i++) {
        [unique appendFormat:@"%c", [chars characterAtIndex:arc4random() % chars.length]];
    }
    
    // 从型号提取代码（简化处理）
    NSString *modelCode = [[model substringFromIndex:2] substringToIndex:MIN(2, model.length - 2)];
    
    // 校验位（随机数字）
    int checkDigit = arc4random() % 10;
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%d", factory, yearCode, weekStr, unique, modelCode, checkDigit];
}

+ (NSString *)generateDeviceNameForRegion:(NSString *)region {
    // 根据不同地区生成常见的设备名称
    NSDictionary *namesByRegion = @{
        @"FR": @[@"iPhone de Pierre", @"iPhone de Marie", @"iPhone de Jean", @"iPhone de Sophie", @"iPhone de Lucas"],
        @"ES": @[@"iPhone de Carlos", @"iPhone de Maria", @"iPhone de Juan", @"iPhone de Ana", @"iPhone de Pedro"],
        @"PL": @[@"iPhone Pawła", @"iPhone Anny", @"iPhone Jana", @"iPhone Katarzyny", @"iPhone Michała"],
        @"US": @[@"John's iPhone", @"Sarah's iPhone", @"Mike's iPhone", @"Emily's iPhone", @"David's iPhone"],
        @"GB": @[@"James's iPhone", @"Emma's iPhone", @"Oliver's iPhone", @"Sophie's iPhone", @"Jack's iPhone"],
    };
    
    NSArray *names = namesByRegion[region] ?: namesByRegion[@"FR"];
    return names[arc4random() % names.count];
}

+ (NSDictionary *)carrierForRegion:(NSString *)region {
    NSDictionary *carriers = @{
        @"FR": @[
            @{@"name": @"Orange F", @"mcc": @"208", @"mnc": @"01"},
            @{@"name": @"SFR", @"mcc": @"208", @"mnc": @"10"},
            @{@"name": @"Bouygues", @"mcc": @"208", @"mnc": @"20"},
            @{@"name": @"Free", @"mcc": @"208", @"mnc": @"15"}
        ],
        @"ES": @[
            @{@"name": @"Movistar", @"mcc": @"214", @"mnc": @"01"},
            @{@"name": @"Vodafone ES", @"mcc": @"214", @"mnc": @"01"},
            @{@"name": @"Orange ES", @"mcc": @"214", @"mnc": @"03"}
        ],
        @"PL": @[
            @{@"name": @"Orange PL", @"mcc": @"260", @"mnc": @"03"},
            @{@"name": @"T-Mobile PL", @"mcc": @"260", @"mnc": @"02"},
            @{@"name": @"Play", @"mcc": @"260", @"mnc": @"06"}
        ],
        @"US": @[
            @{@"name": @"T-Mobile", @"mcc": @"310", @"mnc": @"260"},
            @{@"name": @"AT&T", @"mcc": @"310", @"mnc": @"410"},
            @{@"name": @"Verizon", @"mcc": @"311", @"mnc": @"480"}
        ],
        @"GB": @[
            @{@"name": @"EE", @"mcc": @"234", @"mnc": @"30"},
            @{@"name": @"O2", @"mcc": @"234", @"mnc": @"10"},
            @{@"name": @"Vodafone UK", @"mcc": @"234", @"mnc": @"15"}
        ],
    };
    
    NSArray *regionCarriers = carriers[region] ?: carriers[@"FR"];
    return regionCarriers[arc4random() % regionCarriers.count];
}

@end
