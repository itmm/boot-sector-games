# Simple echo client

```
@inc(base.md)
```

```
@Def(file: echo.asm)
	@Mul(pre)
loop:
	mov ah,0x00
	int 0x16
	cmp al,0x1b
	je end
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	jmp loop
	@Mul(end)
	@Mul(fill)
@End(file: echo.asm)
```

