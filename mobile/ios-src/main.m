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
    NSLog( @"viewController dimensions:%i;%i",  viewController.view.frame.size.width,viewController.view.frame.size.height );
    shownAd = [[[NSBundle mainBundle] loadNibNamed:@"Ad" owner:viewController options:nil] objectAtIndex:0];
    NSLog( @"shownAd dimensions:%i;%i",  viewController.view.frame.size.width,shownAd.frame.size.height );
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
