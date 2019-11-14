# Test division

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: inc.asm)
	@Mul(pre)
	mov al,0x30
	@put(do)
	@Mul(end)
	@Mul(putc)
	@Mul(fill)
@End(file: inc.asm)
```

```
@def(do)
count_up:
	call putc
	inc al
	cmp al,0x39
	jne count_up
@end(do)
```

```
@add(do)
count_down:
	call putc
	dec al
	cmp al,0x30
	jne count_down
@end(do)
```
