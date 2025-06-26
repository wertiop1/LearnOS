# 04 Bootsector Stack

    mov bp, 0x8000
    mov sp, bp

Set the base of the stack at 0x8000

    push 'A'
    push 'B'
    push 'C'

The Stack now looks like this

| Address | Value |
| ------- | ----- |
| 0x7ffa  | C     |
| 0x7ffc  | B     |
| 0x7ffe  | A     |
| 0x8000  | base  |

    pop bx
    mov al, bl
    int 0x10

Remove the topmost value (C) from the stack and into bx, and print it. Repeat with the remaining values
