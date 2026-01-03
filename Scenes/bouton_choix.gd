extends MarginContainer

signal pressed()

@export var acte: Etats.Scenar = Etats.Scenar.INTRO
@export var action : Etats.Actions = Etats.Actions.RIEN

func regler_bouton(c: Choix) -> bool:
	for condition in c.conditions:
		if (Etats.total_scenar & condition) != condition:
			return false
	%Bouton.text = "• " + tr(c.texte_choix)
	acte = c.acte
	action = c.action
	return true

func attraper_focus() -> void:
	if not %Bouton.disabled:
		%Bouton.grab_focus()

func _on_bouton_pressed() -> void:
	pressed.emit()

func _on_bouton_mouse_entered() -> void:
	%Bouton.grab_focus()
