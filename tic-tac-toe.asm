	org 0x7c00

	push cs
	pop ds

board: equ 0x8000

	mov bx,board
	mov cx,9
	mov al,'1'
init_loop:
	mov [bx],al
	inc al
	inc bx
	loop init_loop

loop:
	call show_board
	call get_movement
	mov byte [bx],'X'
	call show_board
	call get_movement
	mov byte [bx],'O'
	jmp loop

show_board:
	mov bx,board
	call show_row
	call show_div
	mov bx,board+3
	call show_row
	call show_div
	mov bx,board+6
	call show_row
	jmp find_line

show_row:
	call show_square
	mov al,'|'
	call display_letter
	call show_square
	mov al,'|'
	call display_letter
	call show_square

show_crlf:
	mov al,0x0d
	call display_letter
	mov al,0x0a
	jmp display_letter

show_div:
	mov al,'-'
	call display_letter
	mov al,'+'
	call display_letter
	mov al,'-'
	call display_letter
	mov al,'+'
	call display_letter
	mov al,'-'
	call display_letter
	jmp show_crlf

show_square:
	mov al,[bx]
	inc bx
	jmp display_letter

	%Include "_chr-io.asm"

get_movement:
	call read_keyboard
	cmp al,0x1b
	je exit
	sub al,0x31
	jc get_movement
	cmp al,9
	jnc get_movement
	cbw
	mov bx,board
	add bx,ax
	mov al,[bx]
	cmp al,0x40
	jnc get_movement
	call show_crlf
	ret

find_line:
	mov al,[board]
	cmp al,[board+1]
	jne not_1st_row
	cmp al,[board+2]
	je won
not_1st_row:
	cmp al,[board+3]
	jne not_1st_col
	cmp al,[board+6]
	je won
not_1st_col:
	cmp al,[board+4]
	jne not_1st_diag
	cmp al,[board+8]
	je won
not_1st_diag:
	mov al,[board+3]
	cmp al,[board+4]
	jne not_2nd_row
	cmp al,[board+5]
	je won
not_2nd_row:
	mov al,[board+6]
	cmp al,[board+7]
	jne not_3rd_row
	cmp al,[board+8]
	je won
not_3rd_row:
	mov al,[board+1]
	cmp al,[board+4]
	jne not_2nd_col
	cmp al,[board+7]
	je won
not_2nd_col:
	mov al,[board+2]
	cmp al,[board+5]
	jne not_3rd_col
	cmp al,[board+8]
	je won
not_3rd_col:
	cmp al,[board+4]
	jne not_2nd_diag
	cmp al,[board+6]
	je won
not_2nd_diag:
	ret

won:
	call display_letter
	mov al,' '
	call display_letter
	mov al,'w'
	call display_letter
	mov al,'i'
	call display_letter
	mov al,'n'
	call display_letter
	mov al,'s'
	call display_letter

exit:
	jmp $

	times 510-($-$$) db 0
	db 0x55,0xaa
