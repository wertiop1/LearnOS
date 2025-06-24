; inf loop (e9 fd ff)
loop:
    jmp loop


;fill 510 zeros without the size of the previous code
times 510-($-$$) db 0


;end number
dw 0xaa55