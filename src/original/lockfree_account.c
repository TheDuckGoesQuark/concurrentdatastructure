#include <stdlib.h>
#include <pthread.h>
#include <stdatomic.h>
#include "account.h"

typedef struct CAccount {
    int balance;
} CAccount;

CAccount* createAccount(int initialValue) {
    CAccount* account = (CAccount*) malloc(sizeof(CAccount));
    account->balance = initialValue;
    return account;
}

int getBalance(CAccount* account) {
    return account->balance;
}

void deposit(CAccount* account, int amount) {
    int expected;
    int new;
    int* pCurrent = &(account->balance);
    do {
        expected = *pCurrent;
        new = expected + amount;
    } while (!__sync_bool_compare_and_swap(pCurrent, expected, new));
}

int withdraw(CAccount* account, int amount) {
    int expected;
    int new;
    int* pCurrent = &(account->balance);
    do {
        expected = *pCurrent;
        new = expected - amount;
    } while (!__sync_bool_compare_and_swap(pCurrent, expected, new));
    return amount;
}

void destroyAccount(CAccount* account) {
    free(account);
}
