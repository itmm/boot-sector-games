
	
	org 0x7c00
	push cs
	pop ds

	mov al,0x04
	sub al,0x03
	add al,0x30
	call putc
	
end:
	jmp $

	
putc:
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

	
	times 510-($-$$) db 0
	db 0x55,0xaa

