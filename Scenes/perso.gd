extends AnimatedSprite2D

var actuel: Etats.Persos = Etats.Persos.IULE

func _ready() -> void:
	self_modulate = Etats.COULEURS_PERSOS[actuel]

func charger_perso(perso: Etats.Persos) -> void:
	if actuel == perso:
		return	
	actuel = perso
	
	play(Etats.Persos.keys()[perso])
	self.self_modulate = Etats.COULEURS_PERSOS[perso]
