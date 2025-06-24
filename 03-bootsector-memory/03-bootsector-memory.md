# 03 Bootsector Memory

Print the secret defined:

    the_secret:
        db "X"

## Attempt 1

    mov al, '1'
    int 0x10
    mov al, the_secret
    int 0x10

Fails: variables are called with [variable name], prints location not value

## Attempt 2

    mov al, '2'
    int 0x10
    mov al, [the_secret]
    int 0x10

Fails: Neglects to account for the offset 

## Attempt 3

    mov al, '3'
    int 0x10
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10

Succeeds: adds offeset 0x7c00 to [the_secret]

## Attempt 4

    mov al, '4'
    int 0x10
    mov al, [0x7c2d]
    int 0x10

Fails: wrong address

# Attempt 5

    mov al, '5'
    int 0x10
    mov al, [0x7c36]
    int 0x10

Succeeds: manual address for [the_secret]

## Org Version

Don't want to put offset everytime

    [org 0x7c00]

## Attempt 1

    mov al, '1'
    int 0x10
    mov al, the_secret
    int 0x10

Fails: variables are called with [variable name], prints location not value

## Attempt 2

    mov al, '2'
    int 0x10
    mov al, [the_secret]
    int 0x10

Succeeds: Offset is globally accounted for

## Attempt 3

    mov al, '3'
    int 0x10
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10

Fails: The offset is already added

## Attempt 4

    mov al, '4'
    int 0x10
    mov al, [0x7c2d]
    int 0x10

Fails: wrong address

# Attempt 5

    mov al, '5'
    int 0x10
    mov al, [0x7c36]
    int 0x10

Succeeds: manual address for [the_secret]