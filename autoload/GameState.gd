extends Node
var inventory: Array[String] = []
var flags := {}

func add_item(id: String) -> void:
	if id not in inventory:
		inventory.append(id)

func has_item(id: String) -> bool:
	return id in inventory

func set_flag(key: String, value) -> void:
	flags[key] = value

func get_flag(key: String, default_val := false):
	return flags.get(key, default_val)
