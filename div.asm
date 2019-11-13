	org 0x7c00

	push cs
	pop ds
start:
	mov ax,0x64
	mov cl,0x21
	div cl

	add al,0x30
	call display_letter

end:
	jmp $

	%Include "_chr-io.asm"

	times 510-($-$$) db 0
	db 0x55,0xaa
