	cpu 8086

ROW_WIDTH	equ 0x00a0
BOX_MAX_WIDTH	equ 23
BOX_MAX_HEIGHT	equ 6
BOX_WIDTH	equ 26
BOX_HEIGHT	equ 8

LIGHT_COLOR	equ 0x06
HERO_COLOR	equ 0x0e

GR_VERT		equ 0xba
GR_TOP_RIGHT	equ 0xbb
GR_BOT_RIGHT	equ 0xbc
GR_BOT_LEFT	equ 0xc8
GR_TOP_LEFT	equ 0xc9
GR_HORIZ	equ 0xcd

GR_TUNNEL	equ 0xb1
GR_DOOR		equ 0xce
GR_FLOOR	equ 0xfa

GR_HERO		equ 0x01

GR_LADDER	equ 0xf0
GR_TRAP		equ 0x04
GR_FOOD		equ 0x05
GR_ARMOR	equ 0x08
GR_YENDOR	equ 0x0c
GR_GOLD		equ 0x0f
GR_WEAPON	equ 0x18

YENDOR_LEVEL	equ 26

	org 0x7c00

rnd		equ 0x0008
starve		equ 0x0006
hp		equ 0x0004
level		equ 0x0003
yendor		equ 0x0002
armor		equ 0x0001
weapon		equ 0x0000

start:
	in ax,0x40
	push ax
	mov ax,16
	push ax
	push ax
	mov al,1
	push ax
	push ax
	inc ax
	int 0x10
	mov ax,0xb800
	mov ds,ax
	mov es,ax

	mov si,random

	mov bp,sp

generate_dungeon:
	mov bl,[bp+yendor]
	add [bp+level],bl
	je $

	mov ax,[bp+rnd]
	and ax,0x4182
	or ax,0x1a6d
	xchg ax,dx

	xor ax,ax
	xor di,di
	mov ch,0x08
	rep stosw

.7:
	push ax
	call fill_room
	pop ax
	add ax,BOX_WIDTH*2
	cmp al,0x9c
	jne .6
	add ax,ROW_WIDTH*BOX_HEIGHT-BOX_WIDTH*3*2
.6:
	cmp ax,ROW_WIDTH*BOX_HEIGHT*3
	jb .7

	shl word [bp+rnd],1
	mov ax,3*ROW_WIDTH+12*2
	mov bx,19*ROW_WIDTH+12*2
	jnc .2
	xchg ax,bx
.2:	jns .8
	add ax,BOX_WIDTH*2*2
.8:
	xchg ax,di

	mov byte [di],GR_LADDER

	cmp byte [bp+level],YENDOR_LEVEL
	jb .1
	mov byte [bx],GR_YENDOR
.1:
	mov di,11*ROW_WIDTH+38*2

game_loop:
	mov ax,game_loop
	push ax

	mov bx,0x0005
.1:	dec bx
	dec bx
	mov al,LIGHT_COLOR
	mov [bx+di-ROW_WIDTH],al
	mov [bx+di],al
	mov [bx+di+ROW_WIDTH],al
	jns .1

	push word [di]
	mov word [di],HERO_COLOR*256+GR_HERO
	add byte [bp+starve],2
	sbb ax,ax
	call add_hp
	int 0x16
	pop word [di]

	mov al,ah
	sub al,0x4c
	mov ah,0x02
	cmp al,0xff
	je .2
	cmp al,0x01
	je .2
	cmp al,0xfc
	je .3
	cmp al,0x04
	jne move_cancel

.3:	mov ah,0x28
.2:	imul ah
	xchg ax,bx
	mov al,[di+bx]

	cmp al,GR_LADDER
	je ladder_found

	cmp al,GR_DOOR
	jnc .4
	cmp al,GR_TUNNEL
	ja move_cancel
.4:
	cmp al,GR_TRAP
	jb move_cancel
	lea di,[di+bx]
	mov bh,0x06
	je trap_found

	cmp al,GR_TUNNEL
	jnc move_cancel

	cmp al,GR_WEAPON
	ja battle
	mov byte [di],GR_FLOOR
	je weapon_found

	cmp al,GR_ARMOR
	je armor_found
	jb food_found
	cmp al,GR_GOLD
	je move_cancel
	neg byte [bp+yendor]
move_cancel:
	ret

ladder_found:
	jmp generate_dungeon

armor_found:
	inc byte [bp+armor]
	ret

weapon_found:
	inc byte [bp+weapon]
	ret

trap_found:
	call si
sub_hp:
	neg ax
	db 0xbb
food_found:
	call si
add_hp:
	add ax,[bp+hp]
	js $
	mov [bp+hp],ax

	mov bx,0x0f98
	call .1
	mov al,[bp+level]
.1:
	xor cx,cx
.2:	inc cx
	sub ax,10
	jnc .2
	add ax,0x0a3a
	call .3
	xchg ax,cx
	dec ax
	jnz .1
.3:
	mov [bx],ax
	dec bx
	dec bx
	ret

battle:
	and al,0x1f
	shl al,1
	mov ah,al
	xchg ax,dx
.2:
	mov bh,[bp+weapon]
	call si
	sub dh,al
	jc .3

	mov bh,dl
	call si
	sub al,[bp+armor]
	jc .4
	call sub_hp
.4:
	int 0x16
	jmp .2

.3:
	mov byte [di],GR_FLOOR
	ret

fill_room:
	add ax,(BOX_HEIGHT/2-1)*ROW_WIDTH+(BOX_WIDTH/2)*2
	push ax
	xchg ax,di
	shr dx,1
	mov ax,0x0000+GR_TUNNEL
	mov cx,BOX_WIDTH
	jnc .3
	push di
	rep stosw
	pop di
.3:
	shr dx,1
	jnc .5
	mov cl,BOX_HEIGHT
.4:
	stosb
	add di,ROW_WIDTH-1
	loop .4
.5:
	mov bh,BOX_MAX_WIDTH-2
	call si
	xchg ax,cx
	mov bh,BOX_MAX_HEIGHT-2
	call si
	mov ch,al
	
	shr al,1
	inc ax
	mov ah,ROW_WIDTH
	mul ah
	add ax,cx
	sub ah,ch
	and al,0xfe
	add al,0x04
	pop di
	sub di,ax

	mov al,GR_TOP_LEFT
	mov bx,GR_TOP_RIGHT*256+GR_HORIZ
	call fill

.9:
	mov al,GR_VERT
	mov bx,GR_VERT*256+GR_FLOOR
	call fill
	dec ch
	jns .9
	mov al,GR_BOT_LEFT
	mov bx,GR_BOT_RIGHT*256+GR_HORIZ

fill:
	push cx
	push di
	call door
.1:	mov al,bl
	call door
	dec cl
	jns .1
	mov al,bh
	call door
	pop di
	pop cx
	add di,0x00a0
	ret

door:
	cmp al,GR_FLOOR
	jne .3
	call si
	cmp al,6
	jnc .11
	add al,[bp+level]
.9:
	sub al,0x05
	cmp al,0x17
	jge .9
	add al,0x44
	jmp short .12

.11:
	cmp al,11
	xchg ax,bx
	cs mov bl,[si+bx+(items-random-6)]
	xchg ax,bx
	jb .12
	mov al,GR_FLOOR
.12:
.3:
	cmp al,GR_HORIZ
	je .1
	cmp al,GR_VERT
	jne .2
.1:	cmp byte [di],GR_TUNNEL
	jne .2
	mov al,GR_DOOR
.2:	stosb
	inc di
	ret

random:
	mov al,251
	mul byte [bp+rnd]
	add al,83
	mov [bp+rnd],ax

	xor ah,ah
	div bh
	mov al,ah
	cbw
	inc ax
	ret

items:	db GR_FOOD
	db GR_GOLD
	db GR_TRAP
	db GR_WEAPON
	db GR_ARMOR

	times 510 - ($ - $$) db 0x4f
	db 0x55,0xaa

