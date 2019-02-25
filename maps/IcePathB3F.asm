const_value set 2
	const ICEPATHB3F_ARTICUNO
	const ICEPATHB3F_POKE_BALL
	const ICEPATHB3F_ROCK

IcePathB3F_MapScripts:
.SceneScripts:
	db 0

.MapCallbacks:
	db 1
	callback MAPCALLBACK_OBJECTS, .Articuno
	
.Articuno:
    checkevent EVENT_FOUGHT_ARTICUNO
    iftrue .NoAppear
	checkitem CLEAR_BELL
	iftrue .Appear
	jump .NoAppear
	
	
.Appear
	appear ICEPATHB3F_ARTICUNO
	return
	
.NoAppear
	disappear ICEPATHB3F_ARTICUNO
	return
	
Articuno:
	faceplayer
	opentext
	writetext ArticunoText
	cry ARTICUNO
	pause 15
	closetext
	setevent EVENT_FOUGHT_ARTICUNO
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
    loadwildmon ARTICUNO, 50
    startbattle
    disappear ICEPATHB3F_ARTICUNO
    reloadmapafterbattle
    end

IcePathB3FNevermeltice:
	itemball NEVERMELTICE

IcePathB3FRock:
	jumpstd smashrock
	
ArticunoText:
	text "Gyaoo!"
	done

IcePathB3F_MapEvents:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def 3, 5, 2, ICE_PATH_B2F_MAHOGANY_SIDE
	warp_def 15, 5, 2, ICE_PATH_B2F_BLACKTHORN_SIDE

.CoordEvents:
	db 0

.BGEvents:
	db 0

.ObjectEvents:
	db 3
	object_event 12, 4, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Articuno, EVENT_ICE_PATH_B3F_ARTICUNO
	object_event 5, 7, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB3FNevermeltice, EVENT_ICE_PATH_B3F_NEVERMELTICE
	object_event 6, 6, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB3FRock, -1
