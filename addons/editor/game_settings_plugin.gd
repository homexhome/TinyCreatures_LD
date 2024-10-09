@tool
extends EditorPlugin
var settings_screen
func _get_plugin_name():
	return "Game Settings"

func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon(&"CheckBox", &"EditorIcons")

func _has_main_screen() -> bool:
	return true

func _enter_tree():
	settings_screen = preload("res://addons/editor/game_settings_screen.tscn").instantiate()
	settings_screen.hide()
	get_editor_interface().get_editor_main_screen().add_child(settings_screen)
	_make_visible(false)
	
func _make_visible(visible):
	if settings_screen:
		settings_screen.visible = visible
