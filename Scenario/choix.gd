class_name Choix extends Resource

@export var acte: Etats.Scenar = Etats.Scenar.INTRO
@export var texte_choix: String = ""
@export var conditions: Array[Etats.Scenar] = [Etats.Scenar.INTRO]
@export var action: Etats.Actions = Etats.Actions.RIEN
