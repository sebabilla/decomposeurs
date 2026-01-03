extends Node

var total_scenar: int = 0
enum Scenar {
	INTRO=0b0000000000000000000000000001,
	HISTOIRE=0b0000000000000000000000000010,
	FEU=0b0000000000000000000000000100,
	AGRICULTURE=0b0000000000000000000000001000,
	PETROLE=0b0000000000000000000000010000,
	BETON=0b0000000000000000000000100000,
	CLIMAT=0b0000000000000000000001000000,
	CONCLU_HIST=0b0000000000000000000010000000,
	GEOGRAPHIE=0b0000000000000000000100000000,
	CONTINENTS=0b0000000000000000001000000000,
	EROSION=0b0000000000000000010000000000,
	REPARTITION=0b0000000000000000100000000000,
	GRAVATS=0b0000000000000001000000000000,
	CONCLU_GEO=0b0000000000000010000000000000,
	ACTIONS=0b0000000000000100000000000000,
	TIQUE=0b0000000000001000000000000000,
	ESCARGOT=0b0000000000010000000000000000,
	FOURMI=0b0000000000100000000000000000,
	VOTE=0b0000000001000000000000000000,
	FIN_HBC=0b0000000010000000000000000000,
	FIN_HBF=0b0000000100000000000000000000,
	FIN_HRC=0b0000001000000000000000000000,
	FIN_HRF=0b0000010000000000000000000000,
	FIN_BBC=0b0000100000000000000000000000,
	FIN_BBF=0b0001000000000000000000000000,
	FIN_BRC=0b0010000000000000000000000000,
	FIN_BRF=0b0100000000000000000000000000,
	REPLAY=0b1000000000000000000000000000
}

var total_actions: int = 0
enum Actions {
	RIEN=0b0000001,
	HORREURS=0b0000010,
	BETES=0b0000100,
	BOUCHER=0b0001000,
	RESTAURATION=0b0010000,
	CHAMPIGNON=0b0100000,
	FORET=0b1000000
}

enum Persos{
	RIEN,
	IULE,
	ACARIEN,
	LOMBRIC,
	CLOPORTE,
	FOULE,
	ISOLE,
	TIQUE,
	ESCARGOT,
	FOURMI,
	ROTIFERE
}
# Doit être dans le même ordre que les persos
const COULEURS_PERSOS: Array[Color] = [
	Color.WHITE,
	Color("e8d3c7"),
	Color("c1e4e9"),
	Color("f6bfbc"),
	Color("d8a373"),
	Color("fdeff2"),
	Color("fdeff2"),
	Color("f19072"),
	Color("cca6bf"),
	Color("f5e56b"),
	Color("a0d8ef")
	]

func maj_total_actions(action: Actions) -> void:
	match action:
		Actions.RIEN:
			return
		Actions.HORREURS:
			_switcher_bits(Actions.HORREURS, Actions.BETES)
		Actions.BETES:
			_switcher_bits(Actions.BETES, Actions.HORREURS)
		Actions.BOUCHER:
			_switcher_bits(Actions.BOUCHER, Actions.RESTAURATION)
		Actions.RESTAURATION:
			_switcher_bits(Actions.RESTAURATION, Actions.BOUCHER)
		Actions.CHAMPIGNON:
			_switcher_bits(Actions.CHAMPIGNON, Actions.FORET)
		Actions.FORET:
			_switcher_bits(Actions.FORET, Actions.CHAMPIGNON)
		_:
			return
	_maj_chemin()
	
func _switcher_bits(allumer: Actions, eteindre: Actions) -> void:
	if (total_actions & allumer) != allumer:
		total_actions += allumer
	if (total_actions & eteindre) == eteindre:
		total_actions -= eteindre
		
func _maj_chemin() -> void:
	match total_actions:
		Actions.HORREURS + Actions.BOUCHER + Actions.CHAMPIGNON:
			_ajouter_fin(Scenar.FIN_HBC)
		Actions.HORREURS + Actions.BOUCHER + Actions.FORET:
			_ajouter_fin(Scenar.FIN_HBF)
		Actions.HORREURS + Actions.RESTAURATION + Actions.CHAMPIGNON:
			_ajouter_fin(Scenar.FIN_HRC)
		Actions.HORREURS + Actions.RESTAURATION + Actions.FORET:
			_ajouter_fin(Scenar.FIN_HRF)
		Actions.BETES + Actions.BOUCHER + Actions.CHAMPIGNON:
			_ajouter_fin(Scenar.FIN_BBC)
		Actions.BETES + Actions.BOUCHER + Actions.FORET:
			_ajouter_fin(Scenar.FIN_BBF)
		Actions.BETES + Actions.RESTAURATION + Actions.CHAMPIGNON:
			_ajouter_fin(Scenar.FIN_BRC)
		Actions.BETES + Actions.RESTAURATION + Actions.FORET:
			_ajouter_fin(Scenar.FIN_BRF)
		_:
			pass

func _ajouter_fin(fin: Scenar) -> void:
	for f in [Scenar.FIN_HBC,Scenar.FIN_HBF,Scenar.FIN_HRC,Scenar.FIN_HRF,Scenar.FIN_BBC,Scenar.FIN_BBF,Scenar.FIN_BRC,Scenar.FIN_BRF]:
		if total_scenar & f == f:
			total_scenar -= f
	total_scenar += fin
