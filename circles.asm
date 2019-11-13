	org 0x7c00

	push cs
	pop ds

	mov ax,0x0002
	int 0x10

	mov ax,0xb800
	mov ds,ax
	mov es,ax

loop:
	mov ah,0x00
	int 0x1a
	mov al,dl
	test al,0x40
	je dont_invert
	not al
dont_invert:
	and al,0x3f
	sub al,0x20
	cbw
	mov cx,ax

	mov di,0x0000
	mov dh,0
next_row:
	mov dl,0
next_cell:
	push dx
	mov bx,sin_table
	mov al,dh
	shl al,1
	and al,0x3f
	cs xlat
	cbw
	push ax

	mov al,dl
	and al,0x3f
	cs xlat
	cbw

	pop dx
	add ax,dx
	add ax,cx
	mov ah,al
	mov al,'*'
	mov [di],ax
	add di,2

	pop dx
	inc dl
	cmp dl,80
	jne next_cell
	inc dh
	cmp dh,25
	jne next_row

	mov ah,0x01
	int 0x16
	jne exit
	jmp loop

exit:
	jmp $

sin_table:
	db 0,6,12,19,24,30,36,41
	db 45,49,53,56,59,61,63,64
	db 64,64,63,61,59,56,53,49
	db 45,41,36,30,24,19,12,6
	db 0,-6,-12,-19,-24,-30,-36,-41
	db -45,-49,-53,-56,-59,-61,-63,-64
	db -64,-64,-63,-61,-59,-56,-53,-49
	db -45,-41,-36,-30,-24,-19,-12,-9

	times 510-($-$$) db 0
	db 0x55,0xaa
