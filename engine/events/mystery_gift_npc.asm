MysteryGiftNPC:
	ld hl, .MysteryGiftItems
	call Random
.loop
	sub [hl]
	jr c, .ok
rept 2
	inc hl
endr
	jr .loop
.ok
	ld a, [hli]
	cp $ff
	ld a, POKE_BALL
	jr z, .done
	ld a, [hli]
.done
	ld [wScriptVar], a
	ret

.MysteryGiftItems:
	db 8, BERRY
	db 8, PRZCUREBERRY
	db 8, MINT_BERRY
	db 8, ICE_BERRY
	db 8, BURNT_BERRY
	db 8, PSNCUREBERRY
	db 8, GUARD_SPEC
	db 8, X_DEFEND
	db 8, X_ATTACK
	db 8, BITTER_BERRY
	db 8, DIRE_HIT
	db 8, X_SPECIAL
	db 8, X_ACCURACY
	db 8, EON_MAIL
	db 8, MORPH_MAIL
	db 8, MUSIC_MAIL
	db 8, MIRACLEBERRY
	db 8, GOLD_BERRY
	db 8, REVIVE
	db 8, GREAT_BALL
	db 8, SUPER_REPEL
	db 8, MAX_REPEL
	db 8, ELIXER
	db 8, ETHER
	db 8, WATER_STONE
	db 8, FIRE_STONE
	db 8, LEAF_STONE
	db 8, THUNDERSTONE
	db 8, MAX_ETHER
	db 8, MAX_ELIXER
	db 8, MAX_REVIVE
	db 8, SCOPE_LENS
	db 8, HP_UP
	db 8, PP_UP
	db 8, RARE_CANDY
	db 8, BLUESKY_MAIL
	db 8, MIRAGE_MAIL
	db -1
	