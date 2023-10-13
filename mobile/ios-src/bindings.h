#import <UIKit/UIKit.h>
#import "AdApplovinViewController.h"

void main_rs(void);

void display_ad(UIWindow* window, UIViewController* viewController);

void didLoadAd(void);//(MAAd *)ad

void didFailToLoadAdForAdUnitIdentifier(void);//:(NSString *)adUnitIdentifier withError:(MAError *)error
void didDisplayAd(void);//:(MAAd *)ad {}
void didClickAd(void);//(MAAd *)ad
void didHideAd(void);//:(MAAd *)ad
void didFailToDisplayAd(void);//:(MAAd *)ad withError:(MAError *)error

extern AdApplovinViewController* shownAd;
