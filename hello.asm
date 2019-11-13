	org 0x7c00
start:
	push cs
	pop ds
	mov bx,string
repeat:
	mov al,[bx]
	test al,al
	je end
	push bx
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop bx
	inc bx
	jmp repeat

end:
	jmp $

string:
	db "Hello, world",0

	times 510-($-$$) db 0
	db 0x55,0xaa
