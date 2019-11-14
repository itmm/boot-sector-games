# Test division

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: div.asm)
	@Mul(pre)
	mov ax,0x64
	mov cl,0x21
	div cl
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: div.asm)
```

