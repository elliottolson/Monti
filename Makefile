CFILES = $(wildcard *.c kernel/*.c)
SFILES = $(wildcard boot/*.S kernel/*.S)
OFILES = $(CFILES:.c=.o) $(SFILES:.S=.o)
LLVMPATH = /usr/local/opt/llvm/bin
CLANGFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -mcpu=cortex-a72+nosimd

all: clean kernel8.img

%.o: %.c
	$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c $< -o $@

%.o: %.S
	$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c $< -o $@

kernel8.img: $(OFILES)
	$(LLVMPATH)/ld.lld -m aarch64elf -nostdlib $(OFILES) -T boot/link.ld -o kernel8.elf
	$(LLVMPATH)/llvm-objcopy -O binary kernel8.elf kernel8.img

clean:
	/bin/rm kernel8.elf */*.o *.img > /dev/null 2> /dev/null || true
