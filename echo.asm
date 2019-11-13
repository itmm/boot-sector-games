	org 0x7c00

	push cs
	pop ds
start:
	mov ah,0x00
	int 0x16

	cmp al,0x1b
	je end
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	jmp start

end:
	jmp $

	times 510-($-$$) db 0
	db 0x55,0xaa
