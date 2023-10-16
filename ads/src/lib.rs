use objc_foundation::{INSString, NSString};
use objc_id::{Id, ShareId};
use tracing::info;

/// External obj-c function to append an Ad in the game
extern "C" {
    pub fn display_ad_objc(placement: Option<ShareId<NSString>>, callback: extern "C" fn());
}

#[no_mangle]
extern "C" fn didLoadAd() {
    dbg!("didLoadAd");
}
#[no_mangle]
extern "C" fn didFailToLoadAdForAdUnitIdentifier() {
    dbg!("didFailToLoadAdForAdUnitIdentifier");
} //:(NSString *)adUnitIdentifier withError:(MAError *)error
#[no_mangle]
extern "C" fn didDisplayAd() {
    dbg!("didDisplayAd");
} //:(MAAd *)ad {}
#[no_mangle]
extern "C" fn didClickAd() {
    dbg!("didClickAd");
} //(MAAd *)ad
#[no_mangle]
extern "C" fn didHideAd() {
    dbg!("didHideAd");
} //:(MAAd *)ad
#[no_mangle]
extern "C" fn didFailToDisplayAd() {
    dbg!("didFailToDisplayAd");
}

#[no_mangle]
extern "C" fn callback_c() {
    dbg!("I know the ad was done for from Rust");
}

pub fn display_ad(placement: Option<&str>, callback_rust: fn()) {
    let Some(placement) = placement else {
        unsafe { display_ad_objc(None, callback_c) };
        return;
    };
    let objc_nsstring: Id<NSString> = INSString::from_str(placement);

    // TODO: store the callback and use that in callback_c
    unsafe { display_ad_objc(Some(objc_nsstring.share()), callback_c) }
}
