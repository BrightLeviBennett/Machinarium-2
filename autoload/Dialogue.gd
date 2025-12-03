extends Node
var lines := {
	"door_need": "It's locked. I need a key.",
	"door_done": "It clicks open.",
	"door": "A heavy iron door.",
	"key_got": "I found a small key."
}

func get_text(key: String) -> String:
	return lines.get(key, "")
