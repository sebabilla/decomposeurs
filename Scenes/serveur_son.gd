extends Node

var jouer_bruitages: bool = true
var musique_en_pause: bool = false

func _ready() -> void:
	Signaux.son_perso.connect(jouer_persos)

## Attention l'ordre des noeuds est important!
func jouer_persos(son: Etats.Persos) -> void:
	if not jouer_bruitages: 
		return
	%Bruitages.get_child(son).play()
	
func switch_musique() -> void:
	%Musique.stream_paused = not $Musique.stream_paused
	musique_en_pause = %Musique.stream_paused
