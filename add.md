# Test add

Generate `add.asm`.

[base.md](base.md)
[io.md](io.md)

```asm
// ...
; start
	mov al,0x04
	add al,0x03
	add al,0x30
	call putc
// ...
```
