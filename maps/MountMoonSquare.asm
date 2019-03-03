const_value set 2
	const MOUNTMOONSQUARE_SYLVIA
	const MOUNTMOONSQUARE_FAIRY1
	const MOUNTMOONSQUARE_FAIRY2
	const MOUNTMOONSQUARE_ROCK

MountMoonSquare_MapScripts:
.SceneScripts:
	db 1
	scene_script .DummyScene

.MapCallbacks:
	db 2
	callback MAPCALLBACK_NEWMAP, .DisappearMoonStone
	callback MAPCALLBACK_OBJECTS, .DisappearRock
	callback MAPCALLBACK_OBJECTS, .Sylvia

.DummyScene:
	end

.DisappearMoonStone:
	setevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	return

.DisappearRock:
	disappear MOUNTMOONSQUARE_ROCK
	return

.Sylvia
	checkitem CLEAR_BELL
	iftrue .Appear
	jump .NoAppear
	
.Appear
	appear MOUNTMOONSQUARE_SYLVIA
	return
	
.NoAppear
	disappear MOUNTMOONSQUARE_SYLVIA
	return


Sylvia:
	faceplayer
	opentext
	checkevent EVENT_GOT_MEW_FROM_SYLVIA
	iftrue GotMew
	checkevent EVENT_BEAT_COOLTRAINER_SYLVIA
	iftrue Defeated
	writetext SylviaEncounterText
	waitbutton
	closetext
	winlosstext SylviaDefeatedText, 0
	loadtrainer COOLTRAINERF, SYLVIA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINER_SYLVIA
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
	setevent EVENT_GOT_MEW_FROM_SYLVIA
GotMew:
	writetext GotMewText
	yesorno
	iftrue SylviaRematch
	end

FullParty:
	writetext FullPartyText
	waitbutton
	closetext
	end
	
SylviaRematch:
	winlosstext SylviaDefeatedText, 0
	loadtrainer COOLTRAINERF, SYLVIA2
	startbattle
	reloadmapafterbattle
	
GotMewText:
	text "Oh, Hello <PLAYER>."
	
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
	
	para"I think you deserve"
	line "this reward."
	done
	
FullPartyText:
	text "Oh, your party is"
	cont "full."
	done
	
SylviaEncounterText:
	text "Oh, hello there."
	
	para "You seem like"
	line "quite the #MON"
	cont "trainer."
	
	para "But i bet you're"
	line "not as strong as"
	cont "my boyfriend!"
	
	para "Care to prove me"
	line "wrong?"
	done
	
SylviaDefeatedText:
	text "Oh, you're way"
	line "better than i"
	cont "thought."
	para "Congratulations!"
	done
	
RewardText:
	text "<PLAYER> received"
	line "MEW."
	done
	
ClefairyDance:
	checkflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	iftrue .NoDancing
	checkcode VAR_WEEKDAY
	if_not_equal MONDAY, .NoDancing
	checknite
	iffalse .NoDancing
	appear MOUNTMOONSQUARE_FAIRY1
	appear MOUNTMOONSQUARE_FAIRY2
	applymovement PLAYER, PlayerWalksUpToDancingClefairies
	pause 15
	appear MOUNTMOONSQUARE_ROCK
	spriteface MOUNTMOONSQUARE_FAIRY1, RIGHT
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
	spriteface MOUNTMOONSQUARE_FAIRY1, DOWN
	pause 10
	showemote EMOTE_SHOCK, MOUNTMOONSQUARE_FAIRY1, 15
	spriteface MOUNTMOONSQUARE_FAIRY1, DOWN
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
	hiddenitem EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE, MOON_STONE

DontLitterSign:
	jumptext DontLitterSignText

MtMoonSquareRock:
	jumpstd smashrock

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
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def 20, 5, 5, MOUNT_MOON
	warp_def 22, 11, 6, MOUNT_MOON
	warp_def 13, 7, 1, MOUNT_MOON_GIFT_SHOP

.CoordEvents:
	db 1
	coord_event 7, 11, 0, ClefairyDance

.BGEvents:
	db 2
	bg_event 7, 7, BGEVENT_ITEM, MountMoonSquareHiddenMoonStone
	bg_event 17, 7, BGEVENT_READ, DontLitterSign

.ObjectEvents:
	db 4
	object_event 22, 6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Sylvia, -1
	object_event 6, 6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event 7, 6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event 7, 7, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MtMoonSquareRock, EVENT_MT_MOON_SQUARE_ROCK
