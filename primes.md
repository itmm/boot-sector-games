# Prime Numbers

```
@inc(base.md)
```

```
@inc(io.md)
```

```
@Def(file: primes.asm)
	@Mul(pre)
	@put(steps)
	@Mul(end)
	@Mul(putc)
	@Mul(putn)
	@Mul(fill)
@End(file: primes.asm)
```

```
@def(steps)
table: equ 0x8000
size: equ 1000
@end(steps)
```

```
@add(steps)
	mov bx,table
	mov cx,size
	mov al,0
clean_loop:
	mov [bx],al
	inc bx
	loop clean_loop
@end(steps)
```

```
@add(steps)
	mov ax,2
sieve:
	mov bx,table
	add bx,ax
	cmp byte [bx],0
	jne not_prime
@end(steps)
```

```
@add(steps)
	push ax
	call putn
	mov al,','
	call putc
	mov al,' '
	call putc
	pop ax
@end(steps)
```

```
@add(steps)
	mov bx,table
	add bx,ax
loop:
	add bx,ax
	cmp bx,table+size
	jnc not_prime
	mov byte [bx],1
	jmp loop
@end(steps)
```

```
@add(steps)
not_prime:
	inc ax
	cmp ax,size
	jne sieve
@end(steps)
```

