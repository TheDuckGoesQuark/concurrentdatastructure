LDFLAGS = -lGL -lm -lpthread -O3

lockfree: account.h main.c lockfree_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

locking: account.h main.c locking_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

locking_backoff: account.h main.c locking_backoff_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -f $(obj) *.o lockfree locking

# http://nuclear.mutantstargoat.com/articles/make/#simpler-makefile
