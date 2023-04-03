# Test logical AND

Generate `and.asm`.

[base.md](base.md)
[io.md](io.md)

```asm
// ...
; start
	mov al,0x32
	and al,0x0f
	add al,0x30
	call putc
// ...
```

