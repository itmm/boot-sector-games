	org 0x7c00

	push cs
	pop ds
start:
	mov al,0x02
	mov cl,0x03
	mul cl

	add al,0x30
	call display_letter

end:
	jmp $

	%Include "_chr-io.asm"

	times 510-($-$$) db 0
	db 0x55,0xaa
