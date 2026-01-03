extends Control

func _ready() -> void:
	Signaux.pause_on.connect(init_pause)


func init_pause() -> void:
	get_tree().paused = true
	if Etats.total_scenar == 0:
		%Continuer.disabled = true
		%Nouveau.grab_focus()
	else:
		%Continuer.disabled = false
		%Continuer.grab_focus()
	show()
	%Details.visible = false


func sortir_pause() -> void:
	hide()
	Signaux.pause_off.emit()
	get_tree().paused = false


func _on_continuer_pressed() -> void:
	sortir_pause()


func _on_nouveau_pressed() -> void:
	if Etats.total_scenar & Etats.Scenar.INTRO:
		Etats.total_scenar -= Etats.Scenar.INTRO
	sortir_pause()
	

func _on_musique_pressed() -> void:
	Etats.serveur_son.switch_musique()
	%Musique.text = tr("JOUER_M") if Etats.serveur_son.musique_en_pause else tr("COUPER_M")


func _on_bruitages_pressed() -> void:
	Etats.serveur_son.jouer_bruitages = not Etats.serveur_son.jouer_bruitages
	%Bruitages.text = tr("COUPER_B") if Etats.serveur_son.jouer_bruitages else tr("JOUER_B")


func _on_credits_pressed() -> void:
	%Details.visible = not %Details.visible
	

func _on_langue_pressed() -> void:
	if TranslationServer.get_locale().substr(0, 2) == "fr":
		TranslationServer.set_locale("en")
	else:
		TranslationServer.set_locale("fr")
	%Langue.text = tr("LANGUE")
