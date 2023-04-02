	org 0x7c00
	mov si, HelloString
	call PrintString
	jmp $

PrintCharacter:

	mov ah, 0x0E
	mov bh, 0x00
	mov bl, 0x07
	int 0x10
	ret

PrintString:
.next:
	mov al, [si]
	inc SI
	or al, al
	jz .exit
	call PrintCharacter
	jmp .next
.exit:
	ret

HelloString:
	db "Hello World 2", 0

	times 510 - ($ - $$) db 0
	dw 0xAA55

	
