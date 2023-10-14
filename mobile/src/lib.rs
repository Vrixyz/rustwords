use bevy::prelude::*;
use bevy::window::WindowMode;
use rustwords::GamePlugin;

#[no_mangle]
pub extern "C" fn didLoadAd() {
    dbg!("didLoadAd");
}
#[no_mangle]
pub extern "C" fn didFailToLoadAdForAdUnitIdentifier() {
    dbg!("didFailToLoadAdForAdUnitIdentifier");
} //:(NSString *)adUnitIdentifier withError:(MAError *)error
#[no_mangle]
pub extern "C" fn didDisplayAd() {
    dbg!("didDisplayAd");
} //:(MAAd *)ad {}
#[no_mangle]
pub extern "C" fn didClickAd() {
    dbg!("didClickAd");
} //(MAAd *)ad
#[no_mangle]
pub extern "C" fn didHideAd() {
    dbg!("didHideAd");
} //:(MAAd *)ad
#[no_mangle]
pub extern "C" fn didFailToDisplayAd() {
    dbg!("didFailToDisplayAd");
}

#[bevy_main]
fn main() {
    App::new()
        .add_plugins((
            DefaultPlugins.set(WindowPlugin {
                primary_window: Some(Window {
                    resizable: false,
                    mode: WindowMode::BorderlessFullscreen,
                    ..default()
                }),
                ..default()
            }),
            GamePlugin,
        ))
        .run()
}
