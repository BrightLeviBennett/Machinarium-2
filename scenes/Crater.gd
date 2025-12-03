extends Node2D

# Tries %Player first (unique name), then searches by group "player"
@onready var player: Node = get_node_or_null("%Player")

func _ready():
	# If player still null, try a tolerant search
	if player == null:
		var found := get_tree().get_nodes_in_group("player")
		if found.size() > 0:
			player = found[0]
			print("[Room] player:", player)

	# Collect all click spots anywhere in the tree (group-based, not path-based)
	var spots := get_tree().get_nodes_in_group("move_spot")
	print("[Room] found spots:", spots.size())

	for s in spots:
		if s.has_signal("selected") and not s.is_connected("selected", Callable(self, "_on_spot_selected")):
			s.connect("selected", Callable(self, "_on_spot_selected"))
			print("[Room] connected spot:", s.name, "@", s.global_position)

func _on_spot_selected(spot: Node) -> void:
	print("[Room] spot selected:", spot.name, "->", spot.global_position)
	if player and player.has_method("set_move_target"):
		player.call("set_move_target", spot.global_position)
	else:
		push_error("[Room] Player missing or set_move_target() not found")

func _on_hotspot_clicked(h):
	# If you want: optionally move player close before interacting.
	# Simple rule: if item required, check it:
	if h.requires_item != "" and not GameState.has_item(h.requires_item):
		_say(Dialogue.get_text(h.dialogue_key + "_need"))
		return

	if h.give_item != "":
		GameState.add_item(h.give_item)
		_say(Dialogue.get_text(h.dialogue_key + "_got"))
	elif h.flag_to_set != "":
		GameState.set_flag(h.flag_to_set, true)
		_say(Dialogue.get_text(h.dialogue_key + "_done"))
	else:
		_say(Dialogue.get_text(h.dialogue_key))

@onready var ui_dialogue: Label = get_node_or_null("UI/DialogueLabel")

func _say(text: String) -> void:
	ui_dialogue.text = text
	ui_dialogue.visible = true
	ui_dialogue.modulate.a = 1.0
	ui_dialogue.create_tween().tween_property(ui_dialogue, "modulate:a", 0.0, 2.0)
