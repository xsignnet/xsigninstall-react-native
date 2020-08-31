#import "XsigninstallReactNative.h"
#import "XSignInstallSDK.h"

@interface XsigninstallReactNative()<XSignInstallDelegate>
@property (copy, nonatomic) RCTPromiseResolveBlock wakeupBlock;
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

RCT_EXPORT_METHOD(initWakeupHandler:(RCTPromiseResolveBlock)resolve)
{
    [XsigninstallReactNative sharedInstance].wakeupBlock = resolve;
}

RCT_EXPORT_METHOD(getInstallParams:(RCTPromiseResolveBlock)resolve)
{
    [XSignInstallSDK getInstallParams:^(NSDictionary * _Nullable dic) {
        resolve(dic);
    }];
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
