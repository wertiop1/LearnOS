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
