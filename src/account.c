#include <stdlib.h>

struct CAccount {
    int balance;
};

struct CAccount* createAccount(int initialValue) {
    struct CAccount* account = (struct CAccount*) malloc(sizeof(struct CAccount));
    account->balance = initialValue;
    return account;
}

int getBalance(struct CAccount* account) {
    return account->balance;
}

void deposit(struct CAccount* account, int amount) {
    account->balance += amount;
}

int withdraw(struct CAccount* account, int amount) {
    account->balance -= amount;
    return amount;
}

void destroyAccount(struct CAccount* account) {
    free(account);
}
