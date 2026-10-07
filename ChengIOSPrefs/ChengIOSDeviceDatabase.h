// ChengIOSDeviceDatabase.h
#import <Foundation/Foundation.h>

@interface ChengIOSDeviceDatabase : NSObject
+ (NSDictionary *)randomRealisticDeviceForRegion:(NSString *)region;
+ (NSArray *)allDevices;
@end
