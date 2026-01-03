extends MarginContainer

@export var unique: bool = false

func _ready() -> void:
	var duree: float = 2.0 if unique else randf_range(0.8, 1.5)
	await get_tree().create_timer(duree).timeout
	queue_free()
	
func texte_foule(t: String) -> void:
	%Foule.text = tr(t)
