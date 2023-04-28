
SRC=$(wildcard */*/*.cpp */*.cpp *.cpp */*/*/*.cpp */*/*/*/*.cpp)
ASRC=$(wildcard *.s */*.s */*/*.s */*/*/*.s)
LD=$(wildcard *.ld  */*.ld */*/*.ld */*/*/*.ld)
OBJC=$(SRC:.cpp=.o)
OBJAS=$(ASRC:.s=.o)
OBJ=$(OBJC) $(OBJAS)

RISCVTOOLS = ./riscv64-unknown-elf-gcc-2018.07.0-x86_64-linux-ubuntu14/bin
GCCPARAMS = -Os -march=rv64imac -mabi=lp64 -mcmodel=medany -nostdlib -nostartfiles -Wall -std=c++11
ASPARAMS = -march=rv64imac
LDPARAMS = -T

all: kernel.bin

%.o: %.cpp
	$(RISCVTOOLS)/riscv64-unknown-elf-g++ $(GCCPARAMS) -o $@ -c $<

%.o: %.s
	$(RISCVTOOLS)/riscv64-unknown-elf-as $(ASPARAMS) -o $@ -c $<

kernel.elf: $(OBJ)
	$(RISCVTOOLS)/riscv64-unknown-elf-ld $(LDPARAMS) $(LD) $^ -o $@

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
	rm -f *.bin *.list $(OBJ) *.elf *.iso *.dts *.dtb
	rm -rf iso

.PHONY: all clean

