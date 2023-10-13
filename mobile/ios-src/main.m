#include <stdio.h>

#import "bindings.h"

int main() {
    NSLog(@"AppLovinSdkKey:");
    //NSLog([[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppLovinSdkKey"]);
    main_rs();
    return 0;
}

UIView* shownAd = nil;

void display_ad(UIWindow* window, UIViewController* viewController) {
    if (shownAd != nil) {
        NSLog( @"Ad already showing.");
        return;
    }
    shownAd = [[[NSBundle mainBundle] loadNibNamed:@"Ad" owner:viewController options:nil] objectAtIndex:0];
    shownAd.frame = viewController.view.frame;
    [viewController.view addSubview:shownAd];
}

void close_ad() {
    if (shownAd == nil) {
        NSLog( @"Ad not showing.");
        return;
    }
    [shownAd removeFromSuperview];
    shownAd = nil;
}
