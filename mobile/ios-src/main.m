#import <stdio.h>

#import "bindings.h"
#import "AdApplovinViewController.h"

int main() {
    [ALSdk shared].mediationProvider = @"max";

        [ALSdk shared].userIdentifier = @"USER_ID";

        [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
            // Start loading ads
            NSLog(@"initialization complete");
        }];
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
