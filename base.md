# Common Code for each Boot Sector Game

```asm
	org 0x7c00
	push cs
	pop ds
; start
end:
	jmp $
; libraries
; fill
	times 510 - ($ - $$) db 0
	db 0x55, 0xaa
```

