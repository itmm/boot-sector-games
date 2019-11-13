SRCs = $(wildcard *.asm)
BINs = $(SRCs:.asm=.img)

.PHONY: all clean

all: $(BINs)

%.img: %.asm
	@echo "AS $@"
	@nasm -f bin $^ -o $@

clean:
	@echo "RM"
	@rm -f $(BINs)

