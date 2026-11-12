;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _checkState
	.globl _updateSnake
	.globl _move
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _SnakeSegmentSprite
	.globl _lastState
	.globl _TimePerClock
	.globl _playerlocation
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_playerlocation::
	.ds 4
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_TimePerClock::
	.ds 2
_lastState::
	.ds 1
_SnakeSegmentSprite::
	.ds 32
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:29: uint8_t move() 
;	---------------------------------
; Function move
; ---------------------------------
_move::
;main.c:31: uint8_t input = joypad();
	call	_joypad
	ld	c, a
;main.c:33: if((input > J_RIGHT ) && (input < (J_LEFT | J_RIGHT | J_UP | J_DOWN))) input = lastState;
	ld	a, #0x01
	sub	a, c
	jr	NC, 00102$
	ld	a, c
	sub	a, #0x0f
	jr	NC, 00102$
	ld	a, (_lastState)
	ld	c, a
00102$:
;main.c:35: if(input == J_LEFT){
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00105$
;main.c:36: playerlocation[0] = playerlocation[0] - 10;
	ld	hl, #_playerlocation
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xf6
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	hl, #_playerlocation
	ld	a, c
	ld	(hl+), a
;main.c:37: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	a, b
	ld	(hl+), a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), c
;main.c:38: return J_LEFT;
	ld	a, #0x02
	ret
00105$:
;main.c:40: if(input == J_RIGHT){
	ld	a, c
	dec	a
	jr	NZ, 00107$
;main.c:41: playerlocation[0] = playerlocation[0] + 10;
	ld	hl, #_playerlocation
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_playerlocation
	ld	a, c
	ld	(hl+), a
;main.c:42: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	a, b
	ld	(hl+), a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), c
;main.c:43: return J_RIGHT;
	ld	a, #0x01
	ret
00107$:
;main.c:45: if(input == J_UP){
	ld	a, c
	sub	a, #0x04
	jr	NZ, 00109$
;main.c:46: playerlocation[1] = playerlocation[1] - 10;
	ld	hl, #(_playerlocation + 2)
	ld	a, (hl+)
	ld	l, (hl)
	add	a, #0xf6
	ld	b, a
	ld	a, l
	adc	a, #0xff
	ld	c, a
	ld	hl, #(_playerlocation + 2)
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:47: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #_playerlocation
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:48: return J_UP;
	ld	a, #0x04
	ret
00109$:
;main.c:50: if(input == J_DOWN){
	ld	a, c
	sub	a, #0x08
	jr	NZ, 00111$
;main.c:51: playerlocation[1] = playerlocation[1] + 10;
	ld	hl, #(_playerlocation + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_playerlocation + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:52: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #_playerlocation
	ld	b, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:53: return J_DOWN;
	ld	a, #0x08
	ret
00111$:
;main.c:55: return J_DOWN;
	ld	a, #0x08
;main.c:56: }
	ret
;main.c:58: void updateSnake() 
;	---------------------------------
; Function updateSnake
; ---------------------------------
_updateSnake::
;main.c:61: }
	ret
;main.c:62: void checkState()
;	---------------------------------
; Function checkState
; ---------------------------------
_checkState::
;main.c:65: }
	ret
;main.c:70: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:71: set_sprite_data(0, 8, SnakeSegmentSprite);
	ld	de, #_SnakeSegmentSprite
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:75: playerlocation[0] = 10;
	ld	hl, #_playerlocation
	ld	(hl), #0x0a
	inc	hl
	ld	(hl), #0x00
;main.c:77: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #(_playerlocation + 2)
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), c
	inc	hl
	ld	(hl), #0x0a
;main.c:79: DISPLAY_ON;						// Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:80: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:82: while(1){
00102$:
;main.c:83: delay((TimePerClock-1));
	ld	hl, #_TimePerClock
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	call	_delay
;main.c:84: lastState = move();
	call	_move
	ld	(#_lastState),a
;main.c:85: updateSnake();
	call	_updateSnake
;main.c:86: checkState();
	call	_checkState
;main.c:88: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
__xinit__TimePerClock:
	.dw #0x02ee
__xinit__lastState:
	.db #0x08	; 8
__xinit__SnakeSegmentSprite:
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
