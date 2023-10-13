#import <AppLovinSDK/AppLovinSDK.h>

#ifndef AdApplovinViewController_h
#define AdApplovinViewController_h

@class AdApplovinViewController;

@interface AdApplovinViewController : UIViewController<MAAdDelegate>
@property (nonatomic, strong) MAInterstitialAd *interstitialAd;
@property (nonatomic, assign) NSInteger retryAttempt;

- (void)createInterstitialAd;

@end
#endif /* AdApplovinViewController_h */
