SRCs = $(filter-out _%,$(wildcard *.asm))
BINs = $(SRCs:.asm=.bin)
FLOPPYs =$(SRCs:.asm=.img)

.PHONY: all clean mds srcs

all: $(FLOPPYs)

add.asm: add.md base.md io.md
	mdp $(filter-out base.md io.md,$^)

and.asm: and.md base.md io.md
	mdp $(filter-out base.md io.md,$^)

tic-tac-toe.asm: tic-tac-toe.md base.md io.md
	mdp $(filter-out base.md io.md,$^)

%.bin: %.asm
	nasm -f bin $^ -o $@

empty.bin:
	dd if=/dev/zero of=$@ bs=512 count=2879

%.img: %.bin empty.bin
	cat $(filter-out empty.bin,$^) empty.bin > $@

clean:
	rm -f $(BINs) $(FLOPPYs) empty.bin

