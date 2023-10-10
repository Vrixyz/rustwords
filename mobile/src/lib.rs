use bevy::prelude::*;
use bevy::window::WindowMode;
use rustwords::GamePlugin;

extern "C" {
    pub fn my_print();
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
