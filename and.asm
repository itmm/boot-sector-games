	org 0x7c00
	push cs
	pop ds
; start
	mov al,0x32
	and al,0x0f
	add al,0x30
	call putc
end:
	jmp $
; libraries
putn:
	mov dx,0
	mov cx,10
	div cx
	push dx
	cmp ax,0
	je .no_recur
	call putn
.no_recur:
	pop ax
	add al,'0'
	call putc
	ret
getc:
	; push bx-di
	push bx
	push cx
	push dx
	push si
	push di
	mov ah,0x00
	int 0x16
	; pop bx-di
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	ret
putc:
	; push ax-di
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	; pop ax-di
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
; fill
	times 510 - ($ - $$) db 0
	db 0x55, 0xaa
