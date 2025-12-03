extends Area2D
@export var id: String = ""
signal selected(spot: Area2D)

func _ready():
	input_pickable = true
	add_to_group("move_spot")   # critical: lets Crater.gd find you regardless of parent
	print("[Spot]", name, "ready @", global_position)

func _input_event(_vp, event, _shape_idx):
	if event.is_action_released("ui_left_click"):
		print("[Spot]", name, "CLICK @", global_position, " id:", id)
		emit_signal("selected", self)
