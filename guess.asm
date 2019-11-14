
	
	org 0x7c00
	push cs
	pop ds

	
	in al,(0x40)
	and al,0x07
	add al,0x30
	mov cl,al

loop:
	mov al,'?'
	call putc
	call getc
	cmp al,cl
	jne loop

	call putc
	mov al,':'
	call putc
	mov al,')'
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

	
getc:
	
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

	
	times 510-($-$$) db 0
	db 0x55,0xaa

