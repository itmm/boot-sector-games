SRCs = $(filter-out _%,$(wildcard *.asm))
BINs = $(SRCs:.asm=.img)

.PHONY: all clean srcs

all: $(BINs)

%.img: %.asm
	@echo "AS $@"
	@nasm -f bin $^ -o $@

clean:
	@echo "RM"
	@rm -f $(BINs)

srcs:
	@echo "SRCs $(SRCs)"

