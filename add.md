# Test add

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: add.asm)
	@Mul(pre)
	mov al,0x04
	add al,0x03
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: add.asm)
```
