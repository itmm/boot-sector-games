# Test logical AND

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: and.asm)
	@Mul(pre)
	mov al,0x32
	and al,0x0f
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: and.asm)
```

