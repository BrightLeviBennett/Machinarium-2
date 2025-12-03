extends HBoxContainer

func _process(_delta):
	# crude auto-refresh
	if get_child_count() != GameState.inventory.size():
		_rebuild()

func _rebuild():
	# remove all current children
	for child in get_children():
		remove_child(child)
		child.queue_free()

	# rebuild from inventory
	for id in GameState.inventory:
		var b := Button.new()
		b.text = id
		add_child(b)
