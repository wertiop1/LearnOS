#create a list of the names of headers and c files
C_SOURCES= $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.c)

#Create a list of object file names with the c file names defined in C_SOURCE 
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

#Define the compile and debug commands, so it becomes unneeded to call i686-elf-gcc and i386-elf-gdb directly.
CC = /usr/local/bin/i686-elf-gcc
LD = /usr/local/bin/i686-elf-ld 
GDB = /usr/local/bin/i386-elf-gdb

CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs # / -Wall -Werror -Wextra
#default target
os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin 

kernel.bin: boot/kernel_entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 $^ --oformat binary --allow-multiple-definition

kernel.elf: boot/kernel_entry.o ${OBJ}
	${LD} -o $@ -Ttext 0x1000 $^ --allow-multiple-definition

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf libc/*.o cpu/*.o kernel/*.o boot/*.bin drivers/*.o boot/*.o


