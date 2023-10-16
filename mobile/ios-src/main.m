#import <stdio.h>

#import "bindings.h"
#import "AdApplovinController.h"

int main(void) {
    //NSLog(@"AppLovinSdkKey:");
    //NSLog([[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppLovinSdkKey"]);
    main_rs();
    return 0;
}

AdApplovinController* adController = nil;
UIViewController* _originalViewController = nil;
UIWindow* _window;
rust_callback display_ad_end_callback;

void init_ads(UIWindow* window, UIViewController* viewController) {
    adController = [[AdApplovinController alloc] init];
    [adController createInterstitialAd];
    _window = window;
    _originalViewController = viewController;
    [ALSdk shared].mediationProvider = @"max";

    //[ALSdk shared].userIdentifier = @"USER_ID";
    [ALSdk shared].settings.verboseLoggingEnabled = YES;
    [ALSdk shared].settings.consentFlowSettings.enabled = YES;
    [ALSdk shared].settings.consentFlowSettings.privacyPolicyURL = [NSURL URLWithString: @"https://thierryberger.com"];

    [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        // Start loading ads
        NSLog(@"initialization complete");
    }];
}

void display_ad_objc( NSString* _Nullable placement_id, rust_callback callback) {
    NSLog(@"{%@}", placement_id);
    display_ad_end_callback = callback;
    [adController showAdForPlacement:placement_id];
}
