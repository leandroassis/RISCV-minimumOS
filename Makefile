
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

kernel.iso: kernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/kernel.bin
	echo 'set timeout=0' >> iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "RISC-V OS" {' >> iso/boot/grub/grub.cfg
	echo ' multiboot /boot/kernel.bin' >> iso/boot/grub/grub.cfg
	echo ' boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=$@ iso
	rm -rf iso

run_iso: kernel.iso
	qemu-system-riscv64 -cdrom kernel.iso -boot d -nographic -machine virt

run_bin: kernel.bin
	qemu-system-riscv64 -nographic -bios none -machine virt -kernel kernel.bin


clean:
	rm -f *.bin *.list *.o *.elf *.iso *.dts *.dtb
	rm -rf iso

.PHONY: all clean

