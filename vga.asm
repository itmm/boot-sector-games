	org 0x7c00

	push cs
	pop ds

v_a: equ 0xfa00
v_b: equ 0xfa02

	mov ax,0x0013
	int 0x10

	mov ax,0xa000
	mov ds,ax
	mov es,ax

rows:
	mov ax,127
	mov [v_a],ax
cols:
	mov ax,127
	mov [v_b],ax

cell:
	mov ax,[v_a]
	mov dx,320
	mul dx
	add ax,[v_b]
	xchg ax,di

	mov ax,[v_a]
	and ax,0x78
	add ax,ax

	mov bx,[v_b]
	and bx,0x78
	mov cl,3
	shr bx,cl
	add ax,bx
	stosb

	dec word [v_b]
	jns cell

	dec word [v_a]
	jns cols

	mov ah,0x00
	int 0x16

	mov ax,0x0002
	int 0x10

exit:
	jmp $

	times 510-($-$$) db 0
	db 0x55,0xaa
