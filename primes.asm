
	
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
	call putn
	mov al,','
	call putc
	mov al,' '
	call putc
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

	
putn:
	mov dx,0
	mov cx,10
	div cx
	push dx
	cmp ax,0
	je putn_no_recur
	call putn
putn_no_recur:
	pop ax
	add al,'0'
	call putc
	ret

	
	times 510-($-$$) db 0
	db 0x55,0xaa

