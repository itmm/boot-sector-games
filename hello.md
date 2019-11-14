# Simple Hello World

```
@inc(base.md)
```

```
@Def(file: hello.asm)
	@Mul(pre)
	@put(write msg)
	@Mul(end)
	@put(msg)
	@Mul(fill)
@End(file: hello.asm)
```

```
@def(write msg)
	mov bx,string
repeat:
	mov al,[bx]
	test al,al
	je end
	@put(write ch)
	inc bx
	jmp repeat
@end(write msg)
```

```
@def(write ch)
	push bx
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop bx
@end(write ch)
```

```
@def(msg)
string:
	db "Hello, world",0
@end(msg)
```

