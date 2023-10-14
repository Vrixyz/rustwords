#import <stdio.h>

#import "bindings.h"
#import "AdApplovinController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

void request_att(void) {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        switch(status) {
            case ATTrackingManagerAuthorizationStatusNotDetermined :
                NSLog(@"Unknown consent");
                break;
            case ATTrackingManagerAuthorizationStatusRestricted :
                NSLog(@"Device has an MDM solution applied");
                break;
            case ATTrackingManagerAuthorizationStatusDenied :
                NSLog(@"Denied consent");
                break;
            case ATTrackingManagerAuthorizationStatusAuthorized :
                NSLog(@"Granted consent");
                break;
            default :
                NSLog(@"Unknown");
                break;
        }
        [ALSdk shared].mediationProvider = @"max";

        //[ALSdk shared].userIdentifier = @"USER_ID";
        [ALSdk shared].settings.verboseLoggingEnabled = YES;
        [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
            // Start loading ads
            NSLog(@"initialization complete");
        }];
    }];
}

int main(void) {
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)); // 1
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // 2
        request_att();
    });
    
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
}

void display_ad_objc(rust_callback callback) {
    display_ad_end_callback = callback;
    [adController showAd];
}
