# Tic Tac Toe

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: tic-tac-toe.asm)
	@Mul(pre)
	@put(steps)
@End(file: tic-tac-toe.asm)
```

```
@def(steps)
board: equ 0x8000
@end(steps)
```

```
@add(steps)
	mov bx,board
	mov cx,9
	mov al,'1'
init_loop:
	mov [bx],al
	inc al
	inc bx
	loop init_loop
@end(steps)
```

```
@add(steps)
loop:
	call show_board
	call get_movement
	mov byte [bx],'X'
	call show_board
	call get_movement
	mov byte [bx],'O'
	jmp loop
@end(steps)
```

```
@add(steps)
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
@end(steps)
```

```
@add(steps)
show_row:
	call show_square
	mov al,'|'
	call putc
	call show_square
	mov al,'|'
	call putc
	call show_square
@end(steps)
```

```
@add(steps)
show_crlf:
	mov al,0x0d
	call putc
	mov al,0x0a
	jmp putc
@end(steps)
```

```
@add(steps)
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
@end(steps)
```

```
@add(steps)
show_square:
	mov al,[bx]
	inc bx
	jmp putc
@end(steps)
```

```
@add(steps)
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
@end(steps)
```

```
@add(steps)
find_line:
	mov al,[board]
	cmp al,[board+1]
	jne not_1st_row
	cmp al,[board+2]
	je won
@end(steps)
```

```
@add(steps)
not_1st_row:
	cmp al,[board+3]
	jne not_1st_col
	cmp al,[board+6]
	je won
@end(steps)
```

```
@add(steps)
not_1st_col:
	cmp al,[board+4]
	jne not_1st_diag
	cmp al,[board+8]
	je won
@end(steps)
```

```
@add(steps)
not_1st_diag:
	mov al,[board+3]
	cmp al,[board+4]
	jne not_2nd_row
	cmp al,[board+5]
	je won
@end(steps)
```

```
@add(steps)
not_2nd_row:
	mov al,[board+6]
	cmp al,[board+7]
	jne not_3rd_row
	cmp al,[board+8]
	je won
@end(steps)
```

```
@add(steps)
not_3rd_row:
	mov al,[board+1]
	cmp al,[board+4]
	jne not_2nd_col
	cmp al,[board+7]
	je won
@end(steps)
```

```
@add(steps)
not_2nd_col:
	mov al,[board+2]
	cmp al,[board+5]
	jne not_3rd_col
	cmp al,[board+8]
	je won
@end(steps)
```

```
@add(steps)
not_3rd_col:
	cmp al,[board+4]
	jne not_2nd_diag
	cmp al,[board+6]
	je won
not_2nd_diag:
	ret
@end(steps)
```

```
@add(steps)
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
@end(steps)
```

```
@add(steps)
	@Mul(end)
	@Mul(getc)
	@Mul(putc)
	@Mul(fill)
@end(steps)
```

