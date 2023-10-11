use bevy::input::touch::TouchPhase;
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
    pub fn close_ad();
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
        _ => info!("Unsupported window."),
    }
}

pub struct AdsPlugin;

impl Plugin for AdsPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Update, (mock_touch, bevy_display_ad));
    }
}

pub fn mock_touch(
    mouse: Res<Input<MouseButton>>,
    q_window: Query<&Window, With<PrimaryWindow>>,
    mut touch_events: EventWriter<TouchInput>,
) {
    let window = q_window.single();
    let touch_phase = if mouse.just_pressed(MouseButton::Left) {
        Some(TouchPhase::Started)
    } else if mouse.just_released(MouseButton::Left) {
        Some(TouchPhase::Ended)
    } else if mouse.pressed(MouseButton::Left) {
        Some(TouchPhase::Moved)
    } else {
        None
    };
    if let (Some(phase), Some(cursor_pos)) = (touch_phase, window.cursor_position()) {
        touch_events.send(TouchInput {
            phase,
            position: cursor_pos,
            force: None,
            id: 0,
        })
    }
}

fn bevy_display_ad(
    touches: Res<Touches>,
    windows: NonSend<WinitWindows>,
    window_query: Query<Entity, With<PrimaryWindow>>,
    mut counter: Local<i32>,
) {
    for touch in touches.iter_just_pressed() {
        info!(
            "just pressed touch with id: {:?}, at: {:?}",
            touch.id(),
            touch.position()
        );
        *counter += 1;
        if *counter % 2 == 1 {
            bevy_display_ad_inner(&windows, &window_query);
        } else {
            unsafe {
                close_ad();
            }
        }
    }
}
