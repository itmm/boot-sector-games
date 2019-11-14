# Guess Game

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: guess.asm)
	@Mul(pre)
	@put(steps)
	@Mul(end)
	@Mul(putc)
	@Mul(getc)
	@Mul(fill)
@End(file: guess.asm)
```

```
@def(steps)
	in al,(0x40)
	and al,0x07
	add al,0x30
	mov cl,al
@end(steps)
```

```
@add(steps)
loop:
	mov al,'?'
	call putc
	call getc
	cmp al,cl
	jne loop
@end(steps)
```

```
@add(steps)
	call putc
	mov al,':'
	call putc
	mov al,')'
	call putc
@end(steps)
```
