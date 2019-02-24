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
    int expected, desired;
    int* pBalance = &(account->balance);
    expected = *pBalance;
    do {
        desired = expected + amount;
        atomic_compare_exchange_weak(pBalance, &expected, desired);
    } while (expected != desired);
}

int withdraw(CAccount* account, int amount) {
    int expected, desired;
    int* pBalance = &(account->balance);
    expected = *pBalance;
    do {
        desired = expected - amount;
        atomic_compare_exchange_weak(pBalance, &expected, desired);
    } while (expected != desired);

    return amount;
}

void destroyAccount(CAccount* account) {
    free(account);
}
