extends Node

const REP_SCENAR: String = "res://Scenario/"
var etat: Etats.Scenar = Etats.Scenar.INTRO


func _ready() -> void:
	Signaux.pause_on.emit()
	Signaux.pause_off.connect(sortie_de_pause)


func sortie_de_pause() -> void:
	if Etats.total_scenar == 0:
		acte_suivant(Etats.Scenar.INTRO)
	%Assemblee.rafraichir()

	
func acte_suivant(suivant:Etats.Scenar) -> void:
	%Transition.fondu_entree()
	if (Etats.total_scenar & suivant) != suivant:
		Etats.total_scenar += suivant
	# alternative pour convertir le binaire en sa position dans le binaire
	# Mais comment fonctionne le log pour un grand entier dans godot?
	# var pos: int = int(log(suivant)/log(2))
	# var s: String = Etats.Scenar.keys()[pos]
	var s: String = ""
	for i in Etats.Scenar.keys().size():
		if suivant & Etats.Scenar.values()[i]:
			s = Etats.Scenar.keys()[i]
			break
	var chemin: String = REP_SCENAR + s.to_lower() + ".tres"
	%Assemblee.charger_acte(chemin)
	
