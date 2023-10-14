#import <UIKit/UIKit.h>
#import "AdApplovinController.h"

void main_rs(void);

void init_ads(UIWindow* window, UIViewController* viewController);
void display_ad(void);

void didLoadAd(void);//(MAAd *)ad
void didFailToLoadAdForAdUnitIdentifier(void);//:(NSString *)adUnitIdentifier withError:(MAError *)error
void didDisplayAd(void);//:(MAAd *)ad {}
void didClickAd(void);//(MAAd *)ad
void didHideAd(void);//:(MAAd *)ad
void didFailToDisplayAd(void);//:(MAAd *)ad withError:(MAError *)error
