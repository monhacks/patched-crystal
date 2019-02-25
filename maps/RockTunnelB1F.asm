const_value set 2
	const ROCKTUNNELB1F_ZAPDOS
	const ROCKTUNNELB1F_POKE_BALL1
	const ROCKTUNNELB1F_POKE_BALL2
	const ROCKTUNNELB1F_POKE_BALL3

RockTunnelB1F_MapScripts:
.SceneScripts:
	db 0

.MapCallbacks:
	db 1
	callback MAPCALLBACK_OBJECTS, .Zapdos
	
.Zapdos:
    checkevent EVENT_FOUGHT_ZAPDOS
    iftrue .NoAppear
	checkitem CLEAR_BELL
	iftrue .Appear
	jump .NoAppear
	
	
.Appear
	appear ROCKTUNNELB1F_ZAPDOS
	return
	
.NoAppear
	disappear ROCKTUNNELB1F_ZAPDOS
	return
	
Zapdos:
	faceplayer
	opentext
	writetext ZapdosText
	cry ZAPDOS
	pause 15
	closetext
	setevent EVENT_FOUGHT_ZAPDOS
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
    loadwildmon ZAPDOS, 50
    startbattle
    disappear ROCKTUNNELB1F_ZAPDOS
    reloadmapafterbattle
    end

RockTunnelB1FIron:
	itemball IRON

RockTunnelB1FPPUp:
	itemball PP_UP

RockTunnelB1FRevive:
	itemball REVIVE

RockTunnelB1FHiddenMaxPotion:
	hiddenitem EVENT_ROCK_TUNNEL_B1F_HIDDEN_MAX_POTION, MAX_POTION
	
ZapdosText:
	text "Gyaoo!"
	done

RockTunnelB1F_MapEvents:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def 3, 3, 6, ROCK_TUNNEL_1F
	warp_def 17, 9, 4, ROCK_TUNNEL_1F
	warp_def 23, 3, 3, ROCK_TUNNEL_1F
	warp_def 25, 23, 5, ROCK_TUNNEL_1F

.CoordEvents:
	db 0

.BGEvents:
	db 1
	bg_event 4, 14, BGEVENT_ITEM, RockTunnelB1FHiddenMaxPotion

.ObjectEvents:
	db 4
	object_event 7, 24, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Zapdos, EVENT_ROCK_TUNNEL_B1F_ZAPDOS
	object_event 7, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RockTunnelB1FIron, EVENT_ROCK_TUNNEL_B1F_IRON
	object_event 6, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RockTunnelB1FPPUp, EVENT_ROCK_TUNNEL_B1F_PP_UP
	object_event 15, 2, SPRITE_POKE_BALL, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RockTunnelB1FRevive, EVENT_ROCK_TUNNEL_B1F_REVIVE
