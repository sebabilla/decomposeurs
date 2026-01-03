extends Label

signal texte_affiche

func _ready() -> void:
	label_settings.font_size = 24


func afficher(replique: String, perso: Etats.Persos) -> void:
	label_settings.font_color = Etats.COULEURS_PERSOS[perso]
	text = tr(replique)
	var taille_texte: float= text.length()
	var temps: float = max(0.5, taille_texte * 0.015)
	var affichage: Tween = create_tween()
	affichage.tween_property(self, "visible_ratio", 1, temps).from(0)
	await affichage.finished
	texte_affiche.emit()
