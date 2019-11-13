	org 0x7c00

	push cs
	pop ds

	in al,(0x40)
	and al,0x07
	add al,0x30
	mov cl,al
	call display_letter

loop:
	mov al,'?'
	call display_letter
	call read_keyboard
	cmp al,cl
	jne loop

	call display_letter
	mov al,':'
	call display_letter
	mov al,')'
	call display_letter

end:
	jmp $

	%Include "_chr-io.asm"

	times 510-($-$$) db 0
	db 0x55,0xaa
