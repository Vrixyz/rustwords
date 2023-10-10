use bevy::prelude::*;
use bevy::window::PrimaryWindow;
use bevy::winit::WinitWindows;
//use bevy::{PresentMode, PrimaryWindow, WindowMode};
use raw_window_handle::{HasRawWindowHandle, RawWindowHandle};
use std::ffi::c_void;
use std::panic;

/// External obj-c function to append an Ad in the game
extern "C" {
    pub fn display_ad(ui_window: *mut c_void, ui_view_controller: *mut c_void);
}

fn bevy_display_ad_inner(
    windows: &NonSend<WinitWindows>,
    window_query: &Query<Entity, With<PrimaryWindow>>,
) {
    let entity = window_query.single();
    let raw_window = windows.get_window(entity).unwrap();
    match raw_window.raw_window_handle() {
        RawWindowHandle::UiKit(ios_handle) => {
            let old_view_controller = ios_handle.ui_view_controller;
            let ui_window: *mut c_void = ios_handle.ui_window;
            info!("UIWindow to be passed to bridge {:?}", ui_window);
            let result = panic::catch_unwind(|| unsafe {
                display_ad(ui_window, old_view_controller);
            });
            match result {
                Ok(_) => {
                    info!("AdMob added in Bevy UIWindow successfully");
                }
                Err(_) => info!("Panic trying to add Ad in UIWindow"),
            }
        }
        _ => info!("No Window available to add a new Ad"),
    }
}

pub struct AdsPlugin;

impl Plugin for AdsPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Update, bevy_display_ad);
    }
}

fn bevy_display_ad(
    touches: Res<Touches>,
    windows: NonSend<WinitWindows>,
    window_query: Query<Entity, With<PrimaryWindow>>,
) {
    for touch in touches.iter_just_pressed() {
        info!(
            "just pressed touch with id: {:?}, at: {:?}",
            touch.id(),
            touch.position()
        );
        bevy_display_ad_inner(&windows, &window_query);
    }
}
