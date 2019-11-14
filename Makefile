MDs = $(shell hx-srcs.sh)
SRCs = $(shell hx-files.sh $(MDs))
BINs = $(SRCs:.asm=.img)

.PHONY: all clean mds srcs

hx-run: $(MDs)
	@echo "HX"
	@hx
	@make -s all
	@date >$@

all: $(BINs)

%.img: %.asm
	@echo "AS $@"
	@nasm -f bin $^ -o $@

clean:
	@echo "RM"
	@rm -f $(SRCs) $(BINs)

mds:
	@echo "MDs $(MDs)"

srcs:
	@echo "SRCs $(SRCs)"

