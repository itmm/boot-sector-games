	org 0x7c00

	push cs
	pop ds

table: equ 0x8000
size: equ 1000

	mov bx,table
	mov cx,size
	mov al,0
clean_loop:
	mov [bx],al
	inc bx
	loop clean_loop

	mov ax,2
sieve:
	mov bx,table
	add bx,ax
	cmp byte [bx],0
	jne not_prime
	push ax
	call display_number
	mov al,','
	call display_letter
	mov al,' '
	call display_letter
	pop ax

	mov bx,table
	add bx,ax
loop:
	add bx,ax
	cmp bx,table+size
	jnc not_prime
	mov byte [bx],1
	jmp loop

not_prime:
	inc ax
	cmp ax,size
	jne sieve

end:
	jmp $

	%Include "_chr-io.asm"

	times 510-($-$$) db 0
	db 0x55,0xaa
