# Basic I/O functions

```asm
// ...
; libraries
putc:
	; push ax-di
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	; pop ax-di
	ret
// ...
```

```asm
// ...
putc:
// ...
	; push ax-di
	push ax
	push bx
	push cx
	push dx
	push si
	push di
// ...
```

```asm
// ...
putc:
// ...
	; pop ax-di
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
// ...
```

```asm
// ...
; libraries
getc:
	; push bx-di
	mov ah,0x00
	int 0x16
	; pop bx-di
	ret
// ...
```

```asm
// ...
getc:
// ...
	; push bx-di
	push bx
	push cx
	push dx
	push si
	push di
// ...
```

```asm
// ...
getc:
// ...
	; pop bx-di
	pop di
	pop si
	pop dx
	pop cx
	pop bx
// ...
```

```asm
// ...
; libraries
putn:
	mov dx,0
	mov cx,10
	div cx
	push dx
	cmp ax,0
	je .no_recur
	call putn
.no_recur:
	pop ax
	add al,'0'
	call putc
	ret
// ...
```

