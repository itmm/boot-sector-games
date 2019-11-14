# Basic I/O functions

```
@Def(putc)
putc:
	push ax
	@mul(push bx-di)
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	@mul(pop di-bx)
	pop ax
	ret
@End(putc)
```

```
@def(push bx-di)
	push bx
	push cx
	push dx
	push si
	push di
@end(push bx-di)
```

```
@def(pop di-bx)
	pop di
	pop si
	pop dx
	pop cx
	pop bx
@end(pop di-bx)
```

```
@Def(getc)
getc:
	@mul(push bx-di)
	mov ah,0x00
	int 0x16
	@mul(pop di-bx)
	ret
@End(getc)
```

```
@Def(putn)
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
@End(putn)
```

