# Test division

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: shift.asm)
	@Mul(pre)
	mov al,0x02
	shl al,1
	add al,0x30
	call putc
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: shift.asm)
```

