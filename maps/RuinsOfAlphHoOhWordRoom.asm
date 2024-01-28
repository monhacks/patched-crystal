	object_const_def
	const RUINS_MEW

RuinsOfAlphHoOhWordRoom_MapScripts:
	def_scene_scripts
	
	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Mew 

.Mew:
    checkevent EVENT_GOT_MEW_FROM_ROSE
    iftrue .NoAppear
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .Appear
	sjump .NoAppear

.Appear
	appear RUINS_MEW
	endcallback
	
.NoAppear
	disappear RUINS_MEW
	endcallback

Mew:
	faceplayer
	opentext
	writetext MewText
	cry MEW
	pause 15
	closetext
	setevent EVENT_GOT_MEW_FROM_ROSE
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
    loadwildmon MEW, 30
    startbattle
    disappear RUINS_MEW
    reloadmapafterbattle
    end
	
MewText:
	text "Mew!"
	done

RuinsOfAlphHoOhWordRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9,  9, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 3
	warp_event 10,  9, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 4
	warp_event 17, 21, RUINS_OF_ALPH_INNER_CHAMBER, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  4, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Mew, EVENT_MEW_COOLTRAINER_ROSE
	