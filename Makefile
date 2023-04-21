
SRC=$(wildcard *.cpp)
OBJ = $(SRC:.cpp=.o)

RISCVTOOLS = ./riscv64-unknown-elf-gcc-2018.07.0-x86_64-linux-ubuntu14/bin
GCCPARAMS = -Os -march=rv64imac -mabi=lp64 -nostdlib -nostartfiles
ASPARAMS = -march=rv64imac
LDPARAMS = -T linker.ld

all: kernel.bin clean

%.o: %.cpp
	$(RISCVTOOLS)/riscv64-unknown-elf-g++ $(GCCPARAMS) -o $@ -c $<

%.o: %.s
	$(RISCVTOOLS)/riscv64-unknown-elf-as $(ASPARAMS) -o $@ -c $<

kernel.elf: loader.o $(OBJ)
	$(RISCVTOOLS)/riscv64-unknown-elf-ld $(LDPARAMS) $^ -o $@

%.bin: %.elf
	$(RISCVTOOLS)/riscv64-unknown-elf-objcopy $< -O binary $@

%.list: %.elf
	$(RISCVTOOLS)/riscv64-unknown-elf-objdump -D $< > $@
	cat $@

iso: kernel.bin
	sudo cp $< ./boot/kernel.bin

clean:
	rm -f *.bin *.list *.o *.elf

.PHONY: all clean

