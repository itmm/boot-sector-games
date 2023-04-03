	org 0x7c00
	push cs
	pop ds
; start
	mov bx,string
repeat:
	mov al,[bx]
	test al,al
	je end
	; write ch
	push bx
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop bx
	inc bx
	jmp repeat
end:
	jmp $
; libraries
string:
	db "Hello, world",0
; fill
	times 510 - ($ - $$) db 0
	db 0x55, 0xaa
