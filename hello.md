# Simple Hello World

Generates `hello.asm`.

[base.md](base.md)

```asm
// ...
; start
	mov bx,string
repeat:
	mov al,[bx]
	test al,al
	je end
	; write ch
	inc bx
	jmp repeat
// ...
```

```asm
// ...
	; write ch
	push bx
	mov ah,0x0e
	mov bx,0x000f
	int 0x10
	pop bx
// ...
```

```asm
// ...
; libraries
string:
	db "Hello, world",0
// ...
```

