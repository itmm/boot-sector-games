SRCs = $(filter-out _%,$(wildcard *.asm))
BINs = $(SRCs:.asm=.bin)
FLOPPYs =$(SRCs:.asm=.img)

.PHONY: all clean mds srcs

hx-run: $(MDs)
	@echo "HX"
	@hx
	@make -s all
	@date >$@

all: $(FLOPPYs)

%.bin: %.asm
	@echo "AS $@"
	@nasm -f bin $^ -o $@

empty.bin:
	@echo "CREATE $@"
	@dd if=/dev/zero of=$@ bs=512 count=2879

%.img: %.bin empty.bin
	@echo "CREATE $@"
	@cat $(filter-out empty.bin,$^) empty.bin > $@

clean:
	@echo "RM"
	@rm -f $(BINs) $(FLOPPYs) empty.bin

