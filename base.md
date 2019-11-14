# Common Code for each Boot Sector Game

```
@Def(pre)
	org 0x7c00
	push cs
	pop ds
@End(pre)
```

```
@Def(end)
end:
	jmp $
@End(end)
```

```
@Def(fill)
	times 510-($-$$) db 0
	db 0x55,0xaa
@End(fill)
```

