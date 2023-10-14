#import <UIKit/UIKit.h>
#import "AdApplovinController.h"

#ifndef bindings_h
#define bindings_h

void main_rs(void);

void init_ads(UIWindow *window, UIViewController *viewController);
typedef void (*rust_callback)(void);
extern rust_callback display_ad_end_callback;
void display_ad_objc(rust_callback);

void didLoadAd(void);                          //(MAAd *)ad
void didFailToLoadAdForAdUnitIdentifier(void); //:(NSString *)adUnitIdentifier withError:(MAError *)error
void didDisplayAd(void);                       //:(MAAd *)ad {}
void didClickAd(void);                         //(MAAd *)ad
void didHideAd(void);                          //:(MAAd *)ad
void didFailToDisplayAd(void);                 //:(MAAd *)ad withError:(MAError *)error

#endif
