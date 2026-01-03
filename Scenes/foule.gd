extends Node2D

signal foule_affichee

const LABEL_FOULE: PackedScene = preload("uid://c1sqwe5js46cr")

func afficher(replique: String, nombre: int) -> void:
	var positions = tirer_positions(nombre)
	for p in positions:
		var label: MarginContainer = LABEL_FOULE.instantiate()
		label.texte_foule(replique)
		label.position = p
		label.unique = true if nombre == 1 else false
		add_child(label)
		await get_tree().create_timer(randf_range(0, 0.1)).timeout
	foule_affichee.emit()
	

func tirer_positions(n: int) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	for i in n:
		var rect_max: Vector2 = get_viewport_rect().size
		var centre_assemblee: Vector2 = Vector2(rect_max.x * 0.5, rect_max.y * 0.8) + Vector2(-50, 0)
		var angle: float = randf_range(-PI, 0)
		var longueur: float = rect_max.y * 0.7 + randf_range(0, rect_max.y * 0.1)
		var pos_init: Vector2 = Vector2(longueur, 0).rotated(angle)
		var pos_finale: Vector2 = centre_assemblee + pos_init
		positions.append(pos_finale)
	return positions
