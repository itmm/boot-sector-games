# Test multiplication

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: mul.asm)
	@Mul(pre)
	mov al,0x02
	mov cl,0x03
	mul cl
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: mul.asm)
```

