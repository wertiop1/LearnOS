# Learn OS

Simple OS following [cfenollosa/os-tutorial](https://github.com/cfenollosa/os-tutoria) and [this pdf](https://github.com/wertiop1/LearnOS/blob/main/os-dev.pdf)

## Compile and Run

    $ nasm -f bin {asm_file_name} -o {bin_file_name}
    $ qemu-system-x86_64 {bin_file_name}

## View hexadecimal

    $ od -t x1 -A n {bin_file_name}

## Cross Compiler Setup

On M1 Sequia 15.3

    $ brew install i686-elf-gcc
    $ brew install i686-elf-gdb

Brew redirects i386-elf-gcc to x86_64-elf-gcc

## Compile, Link, and Dissassmble C files

Compile

    $ i686-elf-gcc -ffreestanding -c {c_file_name} -o {object_file_name}

Link

    $ i686-elf-ld -o {bin_file_name} -Ttext 0x0 --oformat binary {object_file_name}

Dissassmble

Method 1:

    $ objdump -d {object_file_name}

Method 2:

    $ ndisasm -b 32 {object_file_name} > {dissasmbled_file_name}
