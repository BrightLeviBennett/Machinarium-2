@tool
extends Daicon

@export var depth := 0.0        # negative = far, positive = near
@export var strength := 0.12    # how strongly the camera motion affects it

var _base_pos := Vector2.ZERO
@onready var _cam: Camera2D = get_viewport().get_camera_2d()

func _ready():
	_base_pos = position

func _process(_dt):
	if _cam:
		var offset := -_cam.global_position * (depth * strength)
		position = _base_pos + offset
