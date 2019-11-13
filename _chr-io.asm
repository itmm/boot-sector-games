display_letter:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret

read_keyboard:
	push bx
	push cx
	push dx
	push si
	push di
	mov ah,0x00
	int 0x16
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	ret

display_number:
	mov dx,0
	mov cx,10
	div cx
	push dx
	cmp ax,0
	je no_recur
	call display_number
no_recur:
	pop ax
	add al,'0'
	call display_letter
	ret

