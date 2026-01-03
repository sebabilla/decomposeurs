extends Control

signal nouvel_acte(n: Etats.Scenar)

var acte: Dialogue = Dialogue.new()
var n_ligne: int = 0
var cliquer: bool = false

const BOUTON_CHOIX: PackedScene = preload("uid://jepdacjp4iy5")

func _ready() -> void:
	var rect: Vector2 = get_viewport_rect().size
	%Perso.global_position = Vector2(rect.x * 0.5, rect.y  * 0.5 - 90)


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		if cliquer:
			cliquer = false
			lire_ligne()
	elif event.is_action_released("ui_cancel"):
		Signaux.pause_on.emit()

func charger_acte(chemin: String) -> void:
	acte = load(chemin)
	n_ligne = 0
	cliquer = false
	lire_ligne()
		
func lire_ligne() -> void:
	if n_ligne >= acte.lignes.size():
		lire_choix()
	else:
		var qui: Etats.Persos = acte.lignes[n_ligne].perso
		if qui in [Etats.Persos.FOULE, Etats.Persos.ISOLE]:
			afficher_foule()
		else:
			afficher_perso()


func afficher_perso() -> void:
	var ligne: Ligne = acte.lignes[n_ligne]
	n_ligne += 1
	if ligne.bruitage:
		Signaux.son_perso.emit(ligne.perso)
	%Perso.charger_perso(ligne.perso)
	%LabelPerso.afficher(ligne.replique, ligne.perso)


func afficher_foule() -> void:
	%LabelPerso.hide()
	var ligne: Ligne = acte.lignes[n_ligne]
	if ligne.bruitage:
		Signaux.son_perso.emit(ligne.perso)
	%Foule.afficher(ligne.replique, ligne.nombre)
	
func arreter_foule() -> void:
	n_ligne += 1
	%LabelPerso.show()
	lire_ligne()


func lire_choix() -> void:
	if %Choix.get_child_count() > 0:
		return
	var taille: int = acte.choix.size()
	if taille == 1:
		nouvel_acte.emit(acte.choix[0].acte)
		return
	for i in taille:
		var bouton: MarginContainer = BOUTON_CHOIX.instantiate()
		if bouton.regler_bouton(acte.choix[i]):
			bouton.pressed.connect(_on_choix_pressed.bind(bouton))
			%Choix.add_child(bouton)
	%Choix.get_child(0).attraper_focus()
	

func _on_choix_pressed(bouton: MarginContainer):
	Etats.maj_total_actions(bouton.action)
	nouvel_acte.emit(bouton.acte)
	nettoyer_choix()
	

func rafraichir() -> void:
	if n_ligne > 0:
		n_ligne -= 1
	lire_ligne()
	nettoyer_choix()

func nettoyer_choix() -> void:
	for c in %Choix.get_children():
		c.queue_free()

func _on_label_perso_texte_affiche() -> void:
	cliquer = true
