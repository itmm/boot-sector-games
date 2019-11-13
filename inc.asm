	org 0x7c00

	push cs
	pop ds
start:
	mov al,0x30

count_up:
	call display_letter
	inc al
	cmp al,0x39
	jne count_up

count_down:
	call display_letter
	dec al
	cmp al,0x30
	jne count_down

end:
	jmp $

	%Include "_chr-io.asm"

	times 510-($-$$) db 0
	db 0x55,0xaa
