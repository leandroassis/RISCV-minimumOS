
SRC=$(wildcard *.cpp)
ASRC=$(wildcard *.s)
OBJ = $(SRC:.cpp=.o) $(ASRC:.s=.o)

RISCVTOOLS = ./riscv64-unknown-elf-gcc-2018.07.0-x86_64-linux-ubuntu14/bin
GCCPARAMS = -Os -march=rv64imac -mabi=lp64 -mcmodel=medany -nostdlib -nostartfiles -Wall
ASPARAMS = -march=rv64imac
LDPARAMS = -T linker.ld

all: kernel.bin

%.o: %.cpp
	$(RISCVTOOLS)/riscv64-unknown-elf-g++ $(GCCPARAMS) -o $@ -c $<

%.o: %.s
	$(RISCVTOOLS)/riscv64-unknown-elf-as $(ASPARAMS) -o $@ -c $<

kernel.elf: $(OBJ)
	$(RISCVTOOLS)/riscv64-unknown-elf-ld $(LDPARAMS) $^ -o $@

%.bin: %.elf
	$(RISCVTOOLS)/riscv64-unknown-elf-objcopy $< -O binary $@

%.list: %.elf
	$(RISCVTOOLS)/riscv64-unknown-elf-objdump -D $< > $@
	cat $@

run: kernel.bin
	qemu-system-riscv64 -nographic -bios none -machine virt -kernel kernel.bin -smp 2 -m 2G

debug: kernel.elf
	qemu-system-riscv64 -nographic -s -S -bios none -machine virt -kernel kernel.elf -smp 2 -m 2G

clean:
	rm -f *.bin *.list *.o *.elf *.iso *.dts *.dtb
	rm -rf iso

.PHONY: all clean

