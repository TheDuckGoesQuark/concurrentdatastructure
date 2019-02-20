src = $(wildcard *.c)
obj = $(src:.c=.o)

LDFLAGS = -lGL -lm -lpthread

myprog: $(obj)
	$(CC) -o $@ $^ $(LDFLAGS)

run: myprog
	./myprog

.PHONY: clean
clean:
	rm -f $(obj) myprog

# http://nuclear.mutantstargoat.com/articles/make/#simpler-makefile
