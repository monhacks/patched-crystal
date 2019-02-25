const_value set 2
	const SILVERCAVEROOM1_MEWTWOO
	const SILVERCAVEROOM1_POKE_BALL1
	const SILVERCAVEROOM1_POKE_BALL2
	const SILVERCAVEROOM1_POKE_BALL3
	const SILVERCAVEROOM1_POKE_BALL4

SilverCaveRoom1_MapScripts:
.SceneScripts:
	db 0

.MapCallbacks:
	db 1
	callback MAPCALLBACK_OBJECTS, .Mewtwo
	
.Mewtwo:
    checkevent EVENT_FOUGHT_MEWTWO
    iftrue .NoAppear
	checkitem CLEAR_BELL
	iftrue .Appear
	jump .NoAppear

.Appear
	appear SILVERCAVEROOM1_MEWTWOO
	return
	
.NoAppear
	disappear SILVERCAVEROOM1_MEWTWOO
	return
	
Mewtwo:
	faceplayer
	opentext
	writetext MewtwoText
	cry MEWTWO
	pause 15
	closetext
	setevent EVENT_FOUGHT_MEWTWO
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
    loadwildmon MEWTWO, 75
    startbattle
    disappear SILVERCAVEROOM1_MEWTWOO
    reloadmapafterbattle
    end
	
SilverCaveRoom1MaxElixer:
	itemball MAX_ELIXER

SilverCaveRoom1Protein:
	itemball PROTEIN

SilverCaveRoom1EscapeRope:
	itemball ESCAPE_ROPE

SilverCaveRoom1UltraBall:
	itemball ULTRA_BALL

SilverCaveRoom1HiddenDireHit:
	hiddenitem EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT, DIRE_HIT

SilverCaveRoom1HiddenUltraBall:
	hiddenitem EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL, ULTRA_BALL

MewtwoText:
	text "Mew!"
	done
	
SilverCaveRoom1_MapEvents:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def 9, 33, 2, SILVER_CAVE_OUTSIDE
	warp_def 15, 1, 1, SILVER_CAVE_ROOM_2

.CoordEvents:
	db 0

.BGEvents:
	db 2
	bg_event 16, 23, BGEVENT_ITEM, SilverCaveRoom1HiddenDireHit
	bg_event 17, 12, BGEVENT_ITEM, SilverCaveRoom1HiddenUltraBall

.ObjectEvents:
	db 5
	object_event 8, 3, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Mewtwo, EVENT_SILVER_CAVE_ROOM_1_MEWTWOO
	object_event 4, 9, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom1MaxElixer, EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXER
	object_event 15, 29, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom1Protein, EVENT_SILVER_CAVE_ROOM_1_PROTEIN
	object_event 5, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom1EscapeRope, EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE
	object_event 7, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom1UltraBall, EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL
