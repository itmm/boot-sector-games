# Tic Tac Toe

Generate `tic-tac-toe.asm`.

[base.md](base.md)
[io.md](io.md)

```asm
// ...
; start
board: equ 0x8000

; setup
loop:
	jmp loop
// ...
```

```asm
// ...
; setup
	mov bx,board
	mov cx,9
	mov al,'1'
.init_loop:
	mov [bx],al
	inc al
	inc bx
	loop .init_loop
// ...
```

```asm
// ...
loop:
	call show_board
	call get_movement
	mov byte [bx],'X'
	call show_board
	call get_movement
	mov byte [bx],'O'
// ...
```

```asm
// ...
; libraries
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
// ...
```

```asm
// ...
; libraries
show_row:
	call show_square
	mov al,'|'
	call putc
	call show_square
	mov al,'|'
	call putc
	call show_square
show_crlf:
	mov al,0x0d
	call putc
	mov al,0x0a
	jmp putc
// ...
```

```asm
// ...
; libraries
show_div:
	mov al,'-'
	call putc
	mov al,'+'
	call putc
	mov al,'-'
	call putc
	mov al,'+'
	call putc
	mov al,'-'
	call putc
	jmp show_crlf
// ...
```

```asm
// ...
; libraries
show_square:
	mov al,[bx]
	inc bx
	jmp putc
// ...
```

```asm
// ...
; libraries
get_movement:
	call getc
	cmp al,0x1b
	je end
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
// ...
```

```asm
// ...
; libraries
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
// ...
```

```asm
// ...
; libraries
won:
	call putc
	mov al,' '
	call putc
	mov al,'w'
	call putc
	mov al,'i'
	call putc
	mov al,'n'
	call putc
	mov al,'s'
	call putc
	jmp end
// ...
```

