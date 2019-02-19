src = $(wildcard *.c)
obj = $(src:.c=.o)

LDFLAGS = -lGL -lpng -lz -lm

myprog: $(obj)
	$(CC) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -f $(obj) myprog

# http://nuclear.mutantstargoat.com/articles/make/#simpler-makefile
