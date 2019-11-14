# Test division

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: not.asm)
	@Mul(pre)
	mov al,0xfc
	not al
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@nd(file: not.asm)
```

