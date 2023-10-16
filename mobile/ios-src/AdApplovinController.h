#import <AppLovinSDK/AppLovinSDK.h>

#ifndef AdApplovinViewController_h
#define AdApplovinViewController_h

@class AdApplovinViewController;

@interface AdApplovinController : NSObject<MAAdDelegate>
@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttempt;

- (void)createInterstitialAd;
- (void)showAdForPlacement:(nullable NSString*)placement_id;

@end
#endif /* AdApplovinViewController_h */
