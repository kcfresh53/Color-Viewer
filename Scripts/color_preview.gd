extends CenterContainer
class_name ColorPreview

# colors
@export var foreground_color: Color = Color("#000000"):
	set(val):
		foreground_color = val
		# update color_rect
		fgcolor.color = val
@export var background_color: Color = Color("#ffffff"):
	set(val):
		background_color = val
		# update color_rect
		bgcolor.color = val

# color rects
@onready var bgcolor: ColorRect = $MarginContainer/PanelContainer/BGcolor
@onready var fgcolor: ColorRect = $MarginContainer2/PanelContainer/FGcolor
# buttons
@onready var bgtoggle: Button = $MarginContainer/BGtoggle
@onready var fgtoggle: Button = $MarginContainer2/FGtoggle

# signals
signal layer_selected(layer: String, color: Color)


func _ready() -> void:
	# update colors on start
	bgcolor.color = background_color
	fgcolor.color = foreground_color
	
	# connect button toggle to function
	bgtoggle.pressed.connect(_on_color_toggle.bind("bg", background_color))
	fgtoggle.pressed.connect(_on_color_toggle.bind("fg", foreground_color))

func _on_color_toggle(layer: String, color: Color) -> void:
	layer_selected.emit(layer, color)
