#include <stdlib.h>
#include <stdio.h>

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

int main() {
    struct CAccount* account= createAccount(5);
    printf("Account value %d\n", getBalance(account));
    deposit(account, 5);
    printf("Account after deposit %d\n", getBalance(account));
    int val = withdraw(account, 10);
    printf("Account after withdrawing %d %d\n", val, getBalance(account));
    free(account);
}
