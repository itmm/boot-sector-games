	org 0x7c00

	push cs
	pop ds

v_a: equ 0xfa00
v_b: equ 0xfa02
v_x: equ 0xfa04
v_y: equ 0xfa08
v_s1: equ 0xfa0c
v_s2: equ 0xfa10

	mov ax,0x0013
	int 0x10

	mov ax,0xa000
	mov ds,ax
	mov es,ax

	mov ax,199
	mov [v_a],ax

next_row:
	mov ax,319
	mov [v_b],ax

next_cell:
	xor ax,ax
	mov [v_x],ax
	mov [v_x+2],ax
	mov [v_y],ax
	mov [v_y+2],ax
	mov cx,0

iter:
	push cx
	mov ax,[v_x]
	mov dx,[v_x+2]
	call square
	push dx
	push ax
	mov ax,[v_y]
	mov dx,[v_y+2]
	call square

	pop bx
	add ax,bx
	pop bx
	adc dx,bx

	pop cx
	cmp dx,0
	jne overflow
	cmp ax,4*256
	jnc overflow

	push cx
	mov ax,[v_y]
	mov dx,[v_y+2]
	call square
	push dx
	push ax
	mov ax,[v_x]
	mov dx,[v_x+2]
	call square

	pop bx
	sub ax,bx
	pop bx
	sbb dx,bx

	add ax,[v_b]
	adc dx,0
	add ax,[v_b]
	adc dx,0

	sub ax,480
	sbb dx,0
	
	push ax
	push dx

	mov ax,[v_x]
	mov dx,[v_x+2]
	mov bx,[v_y]
	mov cx,[v_y+2]
	call mult
	
	shl ax,1
	rcl dx,1

	add ax,[v_a]
	adc dx,0
	add ax,[v_a]
	adc dx,0

	sub ax,250
	sbb dx,0

	mov [v_y],ax
	mov [v_y+2],dx

	pop dx
	pop ax

	mov [v_x],ax
	mov [v_x+2],dx

	pop cx
	inc cx
	cmp cx,100
	je overflow
	jmp iter

overflow:
	mov ax,[v_a]
	mov dx,320
	mul dx
	add ax,[v_b]
	xchg ax,di

	add cl,0x20
	mov [di],cl

	dec word [v_b]
	jns next_cell

	dec word [v_a]
	jns next_row

	mov ah,0x00
	int 0x16

	mov ax,0x0002
	int 0x10

exit:
	jmp $

square:
	mov bx,ax
	mov cx,dx

mult:
	xor dx,cx
	pushf
	xor dx,cx
	jns d_not_neg
	not ax
	not dx
	add ax,1
	adc dx,0
d_not_neg:
	test cx,cx
	jns c_not_neg
	not bx
	not cx
	add bx,1
	adc cx,0
c_not_neg:
	mov [v_s1],ax
	mov [v_s1+2],dx
	mul bx
	mov [v_s2],ax
	mov [v_s2+2],dx
	mov ax,[v_s1+2]
	mul cx
	mov [v_s2+4],ax
	mov ax,[v_s1+2]
	mul bx
	add [v_s2+2],ax
	adc [v_s2+4],dx
	mov ax,[v_s1]
	mul cx
	add [v_s2+2],ax
	adc [v_s2+4],dx
	mov ax,[v_s2+1]
	mov dx,[v_s2+3]
	popf
	jns res_not_neg
	not ax
	not dx
	add ax,1
	adc dx,0
res_not_neg:
	ret

	times 510-($-$$) db 0
	db 0x55,0xaa
