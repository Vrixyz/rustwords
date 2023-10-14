#import <stdio.h>

#import "bindings.h"
#import "AdApplovinViewController.h"
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

int main() {
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

AdApplovinViewController* shownAd = nil;
UIViewController* originalViewController = nil;


void display_ad(UIWindow* window, UIViewController* viewController) {
    originalViewController = viewController;
    AdApplovinViewController *adVC = [[AdApplovinViewController alloc] init];
    window.rootViewController = adVC;
    [adVC createInterstitialAd];
}
/*
void display_ad(UIWindow* window, UIViewController* viewController) {
    if (shownAd != nil) {
        NSLog( @"Ad already showing.");
        return;
    }
    shownAd = [[[NSBundle mainBundle] loadNibNamed:@"Ad" owner:viewController options:nil] objectAtIndex:0];
    shownAd.frame = viewController.view.frame;
    [viewController.view addSubview:shownAd];
}*/

void close_ad() {
    if (shownAd == nil) {
        NSLog( @"Ad not showing.");
        return;
    }
    UIWindow* currentWindow = shownAd.view.window;
    currentWindow.rootViewController = originalViewController;
    shownAd = nil;
}
/*
void close_ad() {
    if (shownAd == nil) {
        NSLog( @"Ad not showing.");
        return;
    }
    [shownAd removeFromSuperview];
    shownAd = nil;
}
*/
