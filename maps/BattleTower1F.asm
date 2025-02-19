	object_const_def
	const BATTLETOWER1F_RECEPTIONIST
	const BATTLETOWER1F_YOUNGSTER
	const BATTLETOWER1F_COOLTRAINER_F
	const BATTLETOWER1F_BUG_CATCHER
	const BATTLETOWER1F_GRANNY

BattleTower1F_MapScripts:
	def_scene_scripts
	scene_script .Scene0 ; SCENE_DEFAULT
	scene_script .Scene1 ; SCENE_FINISHED

	def_callbacks

.Scene0:
	setval BATTLETOWERACTION_CHECKSAVEFILEISYOURS
	special BattleTowerAction
	iffalse .SkipEverything
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $0, .SkipEverything
	ifequal $2, .LeftWithoutSaving
	ifequal $3, .SkipEverything
	ifequal $4, .SkipEverything
	opentext
	writetext Text_WeveBeenWaitingForYou
	waitbutton
	closetext
	sdefer Script_ResumeBattleTowerChallenge
	end

.LeftWithoutSaving
	sdefer BattleTower_LeftWithoutSaving
	setval BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction
	setval BATTLETOWERACTION_06
	special BattleTowerAction
.SkipEverything:
	setscene SCENE_FINISHED
.Scene1:
	end

BattleTower1FRulesSign:
	opentext
	writetext Text_ReadBattleTowerRules
	yesorno
	iffalse .skip
	writetext Text_BattleTowerRules
	waitbutton
.skip:
	closetext
	end

BattleTower1FReceptionistScript:
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	promptbutton
	setval BATTLETOWERACTION_CHECK_EXPLANATION_READ ; if new save file: bit 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	ifnotequal $0, Script_Menu_ChallengeExplanationCancel
	sjump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel:
	writetext Text_WantToGoIntoABattleRoom
	setval TRUE
	special Menu_ChallengeExplanationCancel
	ifequal 1, Script_ChooseChallenge
	ifequal 2, Script_BattleTowerExplanation
	sjump Script_BattleTowerHopeToServeYouAgain

Script_ChooseChallenge:
	setval BATTLETOWERACTION_RESETDATA ; ResetBattleTowerTrainerSRAM
	special BattleTowerAction
	special CheckForBattleTowerRules
	ifnotequal FALSE, Script_WaitButton
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_DEFAULT
	special TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_FINISHED
	setval BATTLETOWERACTION_SET_EXPLANATION_READ ; set 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	special BattleTowerRoomMenu
	ifequal $a, Script_Menu_ChallengeExplanationCancel
	ifnotequal $0, Script_MobileError
	setval BATTLETOWERACTION_11
	special BattleTowerAction
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	closetext
	setval BATTLETOWERACTION_CHOOSEREWARD
	special BattleTowerAction
	sjump Script_WalkToBattleTowerElevator

Script_ResumeBattleTowerChallenge:
	closetext
	setval BATTLETOWERACTION_LOADLEVELGROUP ; load choice of level group
	special BattleTowerAction
Script_WalkToBattleTowerElevator:
	musicfadeout MUSIC_NONE, 8
	setmapscene BATTLE_TOWER_BATTLE_ROOM, SCENE_DEFAULT
	setmapscene BATTLE_TOWER_ELEVATOR, SCENE_DEFAULT
	setmapscene BATTLE_TOWER_HALLWAY, SCENE_DEFAULT
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	setval BATTLETOWERACTION_0A
	special BattleTowerAction
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applymovement PLAYER, MovementData_BattleTowerHallwayPlayerEntersBattleRoom
	warpcheck
	end

;Script_GivePlayerHisPrize:
	;setval BATTLETOWERACTION_1C
	;special BattleTowerAction
	;setval BATTLETOWERACTION_GIVEREWARD
	;special BattleTowerAction
	;ifequal POTION, Script_YourPackIsStuffedFull
	;getitemname STRING_BUFFER_4, USE_SCRIPT_VAR
	;giveitem ITEM_FROM_MEM, 5
	;writetext Text_PlayerGotFive
	;setval BATTLETOWERACTION_1D
	;special BattleTowerAction
	;closetext
	;end

Script_GivePlayerHisPrize:
    setval BATTLETOWERACTION_1C
    special BattleTowerAction
    random 20 ; any number really
    ifequal 0, MasterBall
    ifequal 1, MaxRevive
    ifequal 2, MaxPotion
	ifequal 3, FullRestore
	ifequal 4, HpUp
	ifequal 5, Protein
	ifequal 6, Iron
	ifequal 7, Carbos
	ifequal 8, Calcium
	ifequal 9, RareCandy
	ifequal 10, Nugget
	ifequal 11, PP_Up
	ifequal 12, DireHit
	ifequal 13, GuardSpec
	ifequal 14, BerserkGene
	ifequal 15, ScopeLens
	ifequal 16, LuckyPunch
	ifequal 17, LightBall
	ifequal 18, TwistedSpoon
	ifequal 19, NormalBox
	ifequal 20, GorgeousBox
	end
	
MasterBall:
	checkitem MASTER_BALL, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, MASTER_BALL
    giveitem MASTER_BALL, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
MaxRevive:
	checkitem MAX_REVIVE, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, MAX_REVIVE
    giveitem MAX_REVIVE, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end

MaxPotion:
	checkitem MAX_POTION, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, MAX_POTION
    giveitem MAX_POTION, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
FullRestore:
    checkitem FULL_RESTORE, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, FULL_RESTORE
    giveitem FULL_RESTORE, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
HpUp:
    checkitem HP_UP, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, HP_UP
    giveitem HP_UP, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end

Protein:
    checkitem PROTEIN, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, PROTEIN
    giveitem PROTEIN, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
Iron:
    checkitem IRON, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, IRON
    giveitem IRON, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end

Carbos:
    checkitem CARBOS, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, CARBOS
    giveitem CARBOS, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end

Calcium:
    checkitem CALCIUM, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, CALCIUM
    giveitem CALCIUM, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
RareCandy:
    checkitem RARE_CANDY, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, RARE_CANDY
    giveitem RARE_CANDY, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
Nugget:
    checkitem NUGGET, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, NUGGET
    giveitem NUGGET, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
PP_Up:
    checkitem PP_UP, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, PP_UP
    giveitem PP_UP, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
DireHit:
	checkitem DIRE_HIT, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, DIRE_HIT
    giveitem DIRE_HIT, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
GuardSpec:
	checkitem GUARD_SPEC, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, GUARD_SPEC
    giveitem GUARD_SPEC, 5
    writetext Text_PlayerGotFive
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end

BerserkGene:
    checkitem BERSERK_GENE, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, BERSERK_GENE
    giveitem BERSERK_GENE, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
ScopeLens:
	checkitem SCOPE_LENS, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, SCOPE_LENS
    giveitem SCOPE_LENS, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
LuckyPunch:
	checkitem LUCKY_PUNCH, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, LUCKY_PUNCH
    giveitem LUCKY_PUNCH, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
LightBall:
	checkitem LIGHT_BALL, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, LIGHT_BALL
    giveitem LIGHT_BALL, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
TwistedSpoon:
	checkitem TWISTEDSPOON, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, TWISTEDSPOON
    giveitem TWISTEDSPOON, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end	
	
NormalBox:
    checkitem NORMAL_BOX, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, NORMAL_BOX
    giveitem NORMAL_BOX, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
GorgeousBox:
    checkitem GORGEOUS_BOX, 99
	iftrue Script_YourPackIsStuffedFull
    getitemname STRING_BUFFER_3, GORGEOUS_BOX
    giveitem GORGEOUS_BOX, 1
    writetext Text_PlayerGotOne
    setval BATTLETOWERACTION_1D
    special BattleTowerAction
    closetext
    end
	
	
Script_YourPackIsStuffedFull:
	writetext Text_YourPackIsStuffedFull
	waitbutton
	closetext
	end

Script_BattleTowerIntroductionYesNo:
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation:
	writetext Text_BattleTowerIntroduction_2
Script_BattleTowerSkipExplanation:
	setval BATTLETOWERACTION_SET_EXPLANATION_READ
	special BattleTowerAction
	sjump Script_Menu_ChallengeExplanationCancel

Script_BattleTowerHopeToServeYouAgain:
	writetext Text_WeHopeToServeYouAgain
	waitbutton
	closetext
	end

Script_MobileError2: ; unreferenced
	special BattleTowerMobileError
	closetext
	end

Script_WaitButton:
	waitbutton
	closetext
	end

Script_ChooseChallenge2: ; unreferenced
	writetext Text_SaveBeforeEnteringBattleRoom
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	special TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	setval BATTLETOWERACTION_SET_EXPLANATION_READ
	special BattleTowerAction
	special Function1700ba
	ifequal $a, Script_Menu_ChallengeExplanationCancel
	ifnotequal $0, Script_MobileError
	writetext Text_ReceivedAListOfLeadersOnTheHonorRoll
	turnobject BATTLETOWER1F_RECEPTIONIST, LEFT
	writetext Text_PleaseConfirmOnThisMonitor
	waitbutton
	turnobject BATTLETOWER1F_RECEPTIONIST, DOWN
	closetext
	end

Script_StartChallenge: ; unreferenced
	setval BATTLETOWERACTION_LEVEL_CHECK
	special BattleTowerAction
	ifnotequal $0, Script_AMonLevelExceeds
	setval BATTLETOWERACTION_UBERS_CHECK
	special BattleTowerAction
	ifnotequal $0, Script_MayNotEnterABattleRoomUnderL70
	special CheckForBattleTowerRules
	ifnotequal FALSE, Script_WaitButton
	setval BATTLETOWERACTION_05
	special BattleTowerAction
	ifequal $0, .zero
	writetext Text_CantBeRegistered_PreviousRecordDeleted
	sjump .continue

.zero
	writetext Text_CantBeRegistered
.continue
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	writetext Text_SaveBeforeReentry
	yesorno
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_DEFAULT
	special TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel
	setscene SCENE_FINISHED
	setval BATTLETOWERACTION_06
	special BattleTowerAction
	setval BATTLETOWERACTION_12
	special BattleTowerAction
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	sjump Script_ResumeBattleTowerChallenge

Script_ReachedBattleLimit: ; unreferenced
	writetext Text_FiveDayBattleLimit_Mobile
	waitbutton
	sjump Script_BattleTowerHopeToServeYouAgain

Script_AMonLevelExceeds:
	writetext Text_AMonLevelExceeds
	waitbutton
	sjump Script_Menu_ChallengeExplanationCancel

Script_MayNotEnterABattleRoomUnderL70:
	writetext Text_MayNotEnterABattleRoomUnderL70
	waitbutton
	sjump Script_Menu_ChallengeExplanationCancel

Script_MobileError:
	special BattleTowerMobileError
	closetext
	end

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	sjump Script_BattleTowerHopeToServeYouAgain

BattleTower1FYoungsterScript:
	faceplayer
	opentext
	writetext Text_BattleTowerYoungster
	waitbutton
	closetext
	turnobject BATTLETOWER1F_YOUNGSTER, RIGHT
	end

BattleTower1FCooltrainerFScript:
	jumptextfaceplayer Text_BattleTowerCooltrainerF

BattleTower1FBugCatcherScript:
	jumptextfaceplayer Text_BattleTowerBugCatcher

BattleTower1FGrannyScript:
	jumptextfaceplayer Text_BattleTowerGranny

MovementData_BattleTower1FWalkToElevator:
	step UP
	step UP
	step UP
	step UP
	step UP
MovementData_BattleTowerHallwayPlayerEntersBattleRoom:
	step UP
	step_end

MovementData_BattleTowerElevatorExitElevator:
	step DOWN
	step_end

MovementData_BattleTowerHallwayWalkTo1020Room:
	step RIGHT
	step RIGHT
MovementData_BattleTowerHallwayWalkTo3040Room:
	step RIGHT
	step RIGHT
	step UP
	step RIGHT
	turn_head LEFT
	step_end

MovementData_BattleTowerHallwayWalkTo90100Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo7080Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo5060Room:
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomPlayerWalksIn:
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksIn:
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	turn_head LEFT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksOut:
	turn_head UP
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer:
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	slow_step UP
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksAway:
	slow_step DOWN
	slow_step DOWN
	slow_step LEFT
	slow_step LEFT
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist:
	turn_head DOWN
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent:
	turn_head RIGHT
	step_end

Text_BattleTowerWelcomesYou:
	text "BATTLE TOWER"
	line "welcomes you!"

	para "I could show you"
	line "to a BATTLE ROOM."
	done

Text_WantToGoIntoABattleRoom:
	text "Want to go into a"
	line "BATTLE ROOM?"
	done

Text_RightThisWayToYourBattleRoom:
	text "Right this way to"
	line "your BATTLE ROOM."
	done

Text_BattleTowerIntroduction_1: ; unreferenced
	text "BATTLE TOWER is a"
	line "facility made for"
	cont "#MON battles."

	para "Countless #MON"
	line "trainers gather"

	para "from all over to"
	line "hold battles in"

	para "specially designed"
	line "BATTLE ROOMS."

	para "There are many"
	line "BATTLE ROOMS in"
	cont "the BATTLE TOWER."

	para "Each ROOM holds"
	line "seven trainers."

	para "If you defeat the"
	line "seven in a ROOM,"

	para "and you have a"
	line "good record, you"

	para "could become the"
	line "ROOM's LEADER."

	para "All LEADERS will"
	line "be recorded in the"

	para "HONOR ROLL for"
	line "posterity."

	para "You may challenge"
	line "in up to five"

	para "BATTLE ROOMS each"
	line "day."

	para "However, you may"
	line "battle only once a"

	para "day in any given"
	line "ROOM."

	para "To interrupt a"
	line "session, you must"

	para "SAVE. If not, you"
	line "won't be able to"

	para "resume your ROOM"
	line "challenge."

	para ""
	done

Text_BattleTowerIntroduction_2:
	text "BATTLE TOWER is a"
	line "facility made for"
	cont "#MON battles."

	para "Countless #MON"
	line "trainers gather"

	para "from all over to"
	line "hold battles in"

	para "specially designed"
	line "BATTLE ROOMS."

	para "There are many"
	line "BATTLE ROOMS in"
	cont "the BATTLE TOWER."

	para "Each ROOM holds"
	line "seven trainers."

	para "Beat them all, and"
	line "win a prize."

	para "To interrupt a"
	line "session, you must"

	para "SAVE. If not, you"
	line "won't be able to"

	para "resume your ROOM"
	line "challenge."

	para ""
	done

Text_ReceivedAListOfLeadersOnTheHonorRoll:
	text "Received a list of"
	line "LEADERS on the"
	cont "HONOR ROLL."

	para ""
	done

Text_PleaseConfirmOnThisMonitor:
	text "Please confirm on"
	line "this monitor."
	done

Text_ThankYou: ; unreferenced
	text "Thank you!"

	para ""
	done

Text_ThanksForVisiting:
	text "Thanks for"
	line "visiting!"
	done

Text_BeatenAllTheTrainers_Mobile: ; unreferenced
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "Your feat may be"
	line "worth registering,"

	para "<PLAYER>. With your"
	line "results, you may"

	para "be chosen as a"
	line "ROOM LEADER."

	para ""
	done

Text_CongratulationsYouveBeatenAllTheTrainers:
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "For that, you get"
	line "this great prize!"

	para ""
	done

Text_AskRegisterRecord_Mobile: ; unreferenced
	text "Would you like to"
	line "register your"

	para "record with the"
	line "CENTER?"
	done

Text_PlayerGotFive:
	text "<PLAYER> got five"
	line "@"
	text_ram wStringBuffer3
	text "!@"
	sound_item
	text_promptbutton
	text_end

Text_PlayerGotOne:
	text "<PLAYER> got a"
	line "@"
	text_ram wStringBuffer3
	text "!@"
	sound_item
	text_promptbutton
	text_end

Text_YourPackIsStuffedFull:
	text "Oops, your PACK is"
	line "stuffed full."

	para "Please make room"
	line "and come back."
	done

Text_YourRegistrationIsComplete: ; unreferenced
	text "Your registration"
	line "is complete."

	para "Please come again!"
	done

Text_WeHopeToServeYouAgain:
	text "We hope to serve"
	line "you again."
	done

Text_PleaseStepThisWay:
	text "Please step this"
	line "way."
	done

Text_WouldYouLikeToHearAboutTheBattleTower:
	text "Would you like to"
	line "hear about the"
	cont "BATTLE TOWER?"
	done

Text_CantBeRegistered:
	text "Your record from"
	line "the previous"

	para "BATTLE ROOM can't"
	line "be registered. OK?"
	done

Text_CantBeRegistered_PreviousRecordDeleted:
	text "Your record from"
	line "the previous"

	para "BATTLE ROOM can't"
	line "be registered."

	para "Also, the existing"
	line "record will be"
	cont "deleted. OK?"
	done

Text_CheckTheLeaderHonorRoll: ; unreferenced
	text "Check the LEADER"
	line "HONOR ROLL?"
	done

Text_ReadBattleTowerRules:
	text "BATTLE TOWER rules"
	line "are written here."

	para "Read the rules?"
	done

Text_BattleTowerRules:
	text "Three #MON may"
	line "enter battles."

	para "All three must be"
	line "different."

	para "The items they"
	line "hold must also be"
	cont "different."

	para "Certain #MON"
	line "may also have"

	para "level restrictions"
	line "placed on them."
	done

Text_BattleTower_LeftWithoutSaving:
	text "Excuse me!"
	line "You didn't SAVE"

	para "before exiting"
	line "the BATTLE ROOM."

	para "I'm awfully sorry,"
	line "but your challenge"

	para "will be declared"
	line "invalid."
	done

Text_YourMonWillBeHealedToFullHealth:
	text "Your #MON will"
	line "be healed to full"
	cont "health."
	done

Text_NextUpOpponentNo:
	text "Next up, opponent"
	line "no.@"
	text_ram wStringBuffer3
	text ". Ready?"
	done

Text_SaveBeforeConnecting_Mobile: ; unreferenced
	text "Your session will"
	line "be SAVED before"

	para "connecting with"
	line "the CENTER."
	done

Text_SaveBeforeEnteringBattleRoom:
	text "Before entering"
	line "the BATTLE ROOM,"

	para "your progress will"
	line "be saved."
	done

Text_SaveAndEndTheSession:
	text "SAVE and end the"
	line "session?"
	done

Text_SaveBeforeReentry:
	text "Your record will"
	line "be SAVED before"

	para "you go back into"
	line "the previous ROOM."
	done

Text_CancelYourBattleRoomChallenge:
	text "Cancel your BATTLE"
	line "ROOM challenge?"
	done

Text_RegisterRecordOnFile_Mobile: ; unreferenced
	text "We have your"
	line "previous record on"

	para "file. Would you"
	line "like to register"
	cont "it at the CENTER?"
	done

Text_WeveBeenWaitingForYou:
	text "We've been waiting"
	line "for you. This way"

	para "to a BATTLE ROOM,"
	line "please."
	done

Text_FiveDayBattleLimit_Mobile:
	text "You may enter only"
	line "five BATTLE ROOMS"
	cont "each day."

	para "Please come back"
	line "tomorrow."
	done

Text_TooMuchTimeElapsedNoRegister:
	text "Sorry, but it's"
	line "not possible to"

	para "register your"
	line "current record at"

	para "the CENTER because"
	line "too much time has"

	para "elapsed since the"
	line "start of your"
	cont "challenge."
	done

Text_RegisterRecordTimedOut_Mobile: ; unreferenced
; duplicate of Text_TooMuchTimeElapsedNoRegister
	text "Sorry, but it's"
	line "not possible to"

	para "register your most"
	line "recent record at"

	para "the CENTER because"
	line "too much time has"

	para "elapsed since the"
	line "start of your"
	cont "challenge."
	done

Text_AMonLevelExceeds:
	text "One or more of"
	line "your #MON's"
	cont "levels exceeds @"
	text_decimal wScriptVar, 1, 3
	text "."
	done

Text_MayNotEnterABattleRoomUnderL70:
	text_ram wcd49
	text " may not"
	line "enter a BATTLE"
	cont "ROOM under L70."

	para "This BATTLE ROOM"
	line "is for L@"
	text_decimal wScriptVar, 1, 3
	text "."
	done

Text_BattleTowerYoungster:
	text "Destroyed by the"
	line "first opponent in"

	para "no time at all…"
	line "I'm no good…"
	done

Text_BattleTowerCooltrainerF:
	text "There are lots of"
	line "BATTLE ROOMS, but"

	para "I'm going to win"
	line "them all!"
	done

Text_BattleTowerGranny:
	text "It's a grueling"
	line "task, not being"

	para "able to use items"
	line "in battle."

	para "Making your"
	line "#MON hold items"

	para "is the key to"
	line "winning battles."
	done

Text_BattleTowerBugCatcher:
	text "I'm trying to see"
	line "how far I can go"

	para "using just bug"
	line "#MON."

	para "Don't let there be"
	line "any fire #MON…"
	done

BattleTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  9, BATTLE_TOWER_OUTSIDE, 3
	warp_event  8,  9, BATTLE_TOWER_OUTSIDE, 4
	warp_event  7,  0, BATTLE_TOWER_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, BattleTower1FRulesSign

	def_object_events
	object_event  7,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FReceptionistScript, -1
	object_event 14,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BattleTower1FYoungsterScript, -1
	object_event  4,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTower1FCooltrainerFScript, -1
	object_event  1,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleTower1FBugCatcherScript, -1
	object_event 14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FGrannyScript, -1
