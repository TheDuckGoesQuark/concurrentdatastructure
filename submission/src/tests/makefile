LDFLAGS = -lGL -lm -lpthread -O3

lockfree: account.h main.c lockfree_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

locking: account.h main.c locking_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

locking_backoff: account.h main.c locking_backoff_account.c
	$(CC) -o $@ $^ $(LDFLAGS)

all: lockfree locking locking_backoff

.PHONY: clean
clean:
	rm -f $(obj) *.o lockfree locking locking_backoff
