extends ColorRect


func fondu_entree() -> void:
	show()
	var tween: Tween = create_tween()
	tween.tween_property(self, "self_modulate:a", 0, 0.5).from(1)
	await tween.finished
	%Transition.hide()
