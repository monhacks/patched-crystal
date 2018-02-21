npctrade: MACRO
; dialog set, requested mon, offered mon, nickname, dvs, item, OT ID, OT name, gender requested
	db \1, \2, \3, \4, \5, \6, \7
	shift
	dw \7
	db \8, \9, 0
ENDM

NPCTrades: ; fce58
; entries correspond to NPCTRADE_* constants
	npctrade TRADE_DIALOG_COLLECTOR, ELECTABUZZ, ZAPDOS,     "ZAPDOS@@@@@", $37, $66, MAGNET,   37460, "MIKE@@@@@@@", TRADE_EITHER_GENDER
	npctrade TRADE_DIALOG_COLLECTOR, MAGMAR,  MOLTRES,       "MOLTRES@@@@", $96, $66, CHARCOAL, 48926, "KYLE@@@@@@@", TRADE_EITHER_GENDER
	npctrade TRADE_DIALOG_HAPPY,     JYNX,     ARTICUNO,    "ARTICUNO@@@", $98, $88, NEVERMELTICE, 29189, "TIM@@@@@@@@", TRADE_EITHER_GENDER
	npctrade TRADE_DIALOG_GIRL,      DRAGONAIR,  DODRIO,     "DORIS@@@@@@", $77, $66, SMOKE_BALL,   00283, "EMY@@@@@@@@", TRADE_FEMALE_ONLY
	npctrade TRADE_DIALOG_NEWBIE,    DITTO,    MEW,       "MEW@@@@@@@@", $96, $86, MYSTERYBERRY, 15616, "CHRIS@@@@@@", TRADE_EITHER_GENDER
	npctrade TRADE_DIALOG_GIRL,      CHANSEY,    AERODACTYL, "AEROY@@@@@@", $96, $66, GOLD_BERRY,   26491, "KIM@@@@@@@@", TRADE_EITHER_GENDER
	npctrade TRADE_DIALOG_COLLECTOR, PORYGON2,    MEWTWO,   "MEWTWO@@@@@", $96, $66, BERSERK_GENE,   50082, "FOREST@@@@@", TRADE_EITHER_GENDER
; fcf38
