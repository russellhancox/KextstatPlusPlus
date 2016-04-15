EXE = kextstat++

CFLAGS=-Wall -Werror -O2 -g -fobjc-arc
LDFLAGS=-lobjc -framework Foundation -framework IOKit

.PHONY: all
all: $(EXE)

.PHONY: clean
clean:
	$(RM) -r $(EXE) *.dSYM
