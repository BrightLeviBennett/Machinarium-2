extends Area2D
@export var display_name := "Door"
@export var requires_item := ""
@export var give_item := ""
@export var flag_to_set := ""
@export var dialogue_key := ""   # key into Dialogue lines

signal requested_interaction(hotspot: Node)

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if event.is_action_released("ui_left_click"):
		emit_signal("requested_interaction", self)
