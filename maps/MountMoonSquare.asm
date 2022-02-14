	object_const_def
	const MOUNTMOONSQUARE_ROSE
	const MOUNTMOONSQUARE_FAIRY1
	const MOUNTMOONSQUARE_FAIRY2
	const MOUNTMOONSQUARE_ROCK

MountMoonSquare_MapScripts:
	def_scene_scripts
	scene_script .DummyScene ; SCENE_DEFAULT

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .DisappearMoonStone
	callback MAPCALLBACK_OBJECTS, .DisappearRock

.DummyScene:
	end

.DisappearMoonStone:
	setevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	endcallback

.DisappearRock:
	disappear MOUNTMOONSQUARE_ROCK
	endcallback

.Rose
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Appear
	sjump .NoAppear
	
.Appear
	appear MOUNTMOONSQUARE_ROSE
	endcallback
	
.NoAppear
	disappear MOUNTMOONSQUARE_ROSE
	endcallback


Rose:
	faceplayer
	opentext
	checkevent EVENT_GOT_MEW_FROM_ROSE
	iftrue GotMew
	checkevent EVENT_BEAT_COOLTRAINER_ROSE
	iftrue Defeated
	writetext RoseEncounterText
	waitbutton
	closetext
	winlosstext RoseDefeatedText, 0
	loadtrainer COOLTRAINERF, ROSE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINER_ROSE
	opentext
Defeated:
	writetext DefeatedText
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	if_equal PARTY_LENGTH, FullParty
	writetext RewardText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke MEW, 5
	setevent EVENT_GOT_MEW_FROM_ROSE
GotMew:
	writetext GotMewText
	yesorno
	iftrue RoseRematch
	closetext
	end
	
FullParty:
	writetext FullPartyText
	waitbutton
	closetext
	end
	
RoseRematch:
	winlosstext RoseDefeatedText, 0
	loadtrainer COOLTRAINERF, ROSE2
	startbattle
	reloadmapafterbattle
	opentext
	writetext RematchDefeat
	closetext
	end
	
RematchDefeat:
	text "Your bond between"
	line "your #MON"
	cont "holds strong."
	done
	
GotMewText:
	text "Oh, Hello <PLAYER>"
	
	para "I hope you take"
	line "care of your"
	cont "#MON."
	
	para "We can have"
	line "another battle and"
	cont "see if that's true"
	done
	
DefeatedText:
	text "Your skills are"
	line "quite impressive."
	
	para "I think you"
	line "deserve this"
	cont "reward."
	
	para "It's a very"
	line "rare #MON."
	cont "I think it"
	
	para "will help you"
	line "on your journey."
	done
	
FullPartyText:
	text "Your party is"
	cont "full."
	done
	
RoseEncounterText:
	text "Hello there."
	
	para "You seem like"
	line "quite the #MON"
	cont "trainer."
	
	para "ROSE: My name is"
	cont "ROSE."
	
	para "I come from a"
	line "different region"
	cont "to learn more"
	
	para "about the elusive"
	line "moon #MON."
	
	para "Either way im"
	line "always looking for"
	cont "greater challenges"
	
	para "I hope you're"
	line "ready."
	done
	
RoseDefeatedText:
	text "That's quite"
	line "impressive."
	done
	
RewardText:
	text "<PLAYER> received"
	line "MEW."
	done
	
ClefairyDance:
	checkflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	iftrue .NoDancing
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NoDancing
	checktime NITE
	iffalse .NoDancing
	appear MOUNTMOONSQUARE_FAIRY1
	appear MOUNTMOONSQUARE_FAIRY2
	applymovement PLAYER, PlayerWalksUpToDancingClefairies
	pause 15
	appear MOUNTMOONSQUARE_ROCK
	turnobject MOUNTMOONSQUARE_FAIRY1, RIGHT
	cry CLEFAIRY
	waitsfx
	pause 30
	follow MOUNTMOONSQUARE_FAIRY1, MOUNTMOONSQUARE_FAIRY2
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep1
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep2
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep3
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep4
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep5
	stopfollow
	applymovement MOUNTMOONSQUARE_FAIRY2, ClefairyDanceStep6
	follow MOUNTMOONSQUARE_FAIRY1, MOUNTMOONSQUARE_FAIRY2
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyDanceStep7
	stopfollow
	turnobject MOUNTMOONSQUARE_FAIRY1, DOWN
	pause 10
	showemote EMOTE_SHOCK, MOUNTMOONSQUARE_FAIRY1, 15
	turnobject MOUNTMOONSQUARE_FAIRY1, DOWN
	cry CLEFAIRY
	pause 15
	follow MOUNTMOONSQUARE_FAIRY1, MOUNTMOONSQUARE_FAIRY2
	applymovement MOUNTMOONSQUARE_FAIRY1, ClefairyFleeMovement
	disappear MOUNTMOONSQUARE_FAIRY1
	disappear MOUNTMOONSQUARE_FAIRY2
	stopfollow
	clearevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	setflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	end

.NoDancing:
	end

MountMoonSquareHiddenMoonStone:
	hiddenitem MOON_STONE, EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE

DontLitterSign:
	jumptext DontLitterSignText

MtMoonSquareRock:
	jumpstd SmashRockScript

PlayerWalksUpToDancingClefairies:
	step UP
	step_end

ClefairyDanceStep1:
	slow_step DOWN
	slow_jump_step DOWN
	step_end

ClefairyDanceStep2:
	slow_jump_step RIGHT
	step_end

ClefairyDanceStep3:
	slow_step UP
	slow_jump_step UP
	step_end

ClefairyDanceStep4:
	slow_jump_step LEFT
	step_end

ClefairyDanceStep5:
	slow_step DOWN
	slow_jump_step DOWN
	step_end

ClefairyDanceStep6:
	slow_step DOWN
	step_end

ClefairyDanceStep7:
	slow_step RIGHT
	step_end

ClefairyFleeMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	jump_step RIGHT
	step RIGHT
	step RIGHT
	step_end

DontLitterSignText:
	text "MT.MOON SQUARE"
	line "DON'T LITTER"
	done

MountMoonSquare_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 20,  5, MOUNT_MOON, 5
	warp_event 22, 11, MOUNT_MOON, 6
	warp_event 13,  7, MOUNT_MOON_GIFT_SHOP, 1

	def_coord_events
	coord_event  7, 11, SCENE_DEFAULT, ClefairyDance

	def_bg_events
	bg_event  7,  7, BGEVENT_ITEM, MountMoonSquareHiddenMoonStone
	bg_event 17,  7, BGEVENT_READ, DontLitterSign

	def_object_events
	object_event 22, 6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Rose, -1
	object_event  6,  6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  7, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MtMoonSquareRock, EVENT_MT_MOON_SQUARE_ROCK
