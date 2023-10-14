#import "bindings.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "AdApplovinController.h"

@implementation AdApplovinController

- (void)createInterstitialAd
{
    self.interstitialAd = [[MAInterstitialAd alloc] initWithAdUnitIdentifier: @"YOUR_AD_UNIT_ID"];
    self.interstitialAd.delegate = self;

    // Load the first ad
    [self.interstitialAd loadAd];
}

- (void)showAd {
    [self.interstitialAd showAd];
}

#pragma mark - MAAdDelegate Protocol

- (void)didLoadAd:(MAAd *)ad
{
    // Interstitial ad is ready to be shown. '[self.interstitialAd isReady]' will now return 'YES'

    // Reset retry attempt
    self.retryAttempt = 0;
    didLoadAd();
    // TODO:
    // 0: request app tracking transparency
    // 1: init from rust, start loading there.
    // 2: send callbacks to rust
    // 3: call showAd from rust (know when we've loaded ad, and show ad when ready.
    
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withError:(MAError *)error
{
    // Interstitial ad failed to load
    // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
    
    self.retryAttempt++;
    NSInteger delaySec = pow(2, MIN(6, self.retryAttempt));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delaySec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.interstitialAd loadAd];
    });
    didFailToLoadAdForAdUnitIdentifier();
}

- (void)didDisplayAd:(MAAd *)ad {
    didDisplayAd();
}

- (void)didClickAd:(MAAd *)ad {
    didClickAd();
}

- (void)didHideAd:(MAAd *)ad
{
    // Interstitial ad is hidden. Pre-load the next ad
    [self.interstitialAd loadAd];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        didHideAd();
        display_ad_end_callback();
    });
}

- (void)didFailToDisplayAd:(MAAd *)ad withError:(MAError *)error
{
    // Interstitial ad failed to display. We recommend loading the next ad
    [self.interstitialAd loadAd];
    didFailToDisplayAd();
}

@end

/*
int main(int argc, char *argv[]) {
    @autoreleasepool {
        [GADMobileAds.sharedInstance startWithCompletionHandler:nil];
        main_rs();
    }
    return 0;
}
*/
