# 01 Bootsector Barebones

    loop:
        jmp loop

The loop calls itself

    times 510-($-$$) db 0

Fills the remaining file with zeros.

    dw 0xaa55

Magic Number