#import "XsigninstallReactNative.h"
#import "XSignInstallSDK.h"

@interface XsigninstallReactNative()<XSignInstallDelegate>
@property (copy, nonatomic) RCTResponseSenderBlock wakeupBlock;
@end

@implementation XsigninstallReactNative

RCT_EXPORT_MODULE();

// Example method
// See // https://facebook.github.io/react-native/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}

RCT_EXPORT_METHOD(reportRegister)
{
    [XSignInstallSDK reportRegister];
    NSLog(@"[XSignInstallSDK reportRegister]");
}

RCT_EXPORT_METHOD(initWakeupHandler:(RCTResponseSenderBlock)resolve)
{
    [XsigninstallReactNative sharedInstance].wakeupBlock = resolve;
    #warning need delete
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XsigninstallReactNative sharedInstance].wakeupBlock(@[@{@"abcWakeup":@"123"}]);
    });
}

RCT_EXPORT_METHOD(getInstallParams:(RCTResponseSenderBlock)resolve)
{
    [XSignInstallSDK getInstallParams:^(NSDictionary * _Nullable dic) {
        resolve(@[dic]);
    }];
    #warning need delete
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        resolve(@[@{@"abcInstall":@"123"}]);
    });
}

static id shared;

+ (instancetype)sharedInstance {
    if (shared != nil) {
        return shared;
    }
    shared = [[self alloc]init];
    [XSignInstallSDK initWithDelegate:shared];
    return shared;
}

- (void)getWakeUpParams:(NSDictionary *)params {
    [XsigninstallReactNative sharedInstance].wakeupBlock(params);
}

@end
