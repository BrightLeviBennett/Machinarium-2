extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
var speed: float = 140.0

func _ready():
	add_to_group("player")  # optional, helps Crater.gd find you as a fallback
	print("[Player] ready @", global_position)

func set_move_target(pos: Vector2) -> void:
	agent.target_position = pos
	print("[Player] target set ->", pos)
	await get_tree().process_frame
	var path := agent.get_current_navigation_path()
	print("[Player] path points:", path.size(), " path:", path)

func _physics_process(_dt):
	if agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var next := agent.get_next_path_position()
		var to_next := next - global_position
		velocity = to_next.normalized() * speed if to_next.length() > 1.0 else Vector2.ZERO
		if Engine.get_frames_drawn() % 20 == 0:
			print("[Player] moving → next:", next, " vel:", velocity)
	move_and_slide()
