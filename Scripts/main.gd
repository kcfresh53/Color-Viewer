extends Control

@onready var color_preview: ColorPreview = $MarginContainer/Layout/ColorPreview/ColorPreview
@onready var color_picker: ColorPicker = $MarginContainer/Layout/InputContainer/ColorPicker

var active_color : String = "fg"


func _ready() -> void:
	color_picker.color = color_preview.foreground_color

# set color preview colors
func _update_color_preview(color: Color):
	if active_color == "fg":
		color_preview.foreground_color = color
	elif active_color == "bg":
		color_preview.background_color = color
	color_picker.color = color

func _on_color_picker_color_changed(color: Color) -> void:
	_update_color_preview(color)

func _on_alpha_btn_pressed() -> void:
	_update_color_preview(Color(1, 1, 1, 0))

func _on_white_btn_pressed() -> void:
	_update_color_preview(Color("#ffffff"))

func _on_black_btn_pressed() -> void:
	_update_color_preview(Color("#000000"))

func _on_random_btn_pressed() -> void:
	_update_color_preview(_generate_random_color(Color(1, 1, 1)))

# algorithm from here(https://stackoverflow.com/questions/43044/algorithm-to-randomly-generate-an-aesthetically-pleasing-color-palette)
func _generate_random_color(mix: Color) -> Color:
	var red: float = randf_range(0, 1)
	var green: float = randf_range(0, 1)
	var blue: float = randf_range(0, 1)
	
	red = (red + mix.r) /2
	green = (green + mix.g) /2
	blue = (blue + mix.b) /2
	
	return Color(red, green, blue)

func _on_color_preview_layer_selected(layer: String, color: Color) -> void:
	active_color = layer
	color_picker.color = color

func _on_copy_btn_pressed() -> void:
	DisplayServer.clipboard_set(str(color_picker.color.to_html(false)))
