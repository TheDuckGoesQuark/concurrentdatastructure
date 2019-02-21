#include <stdlib.h>
#include <pthread.h>
#include "account.h"

typedef struct CAccount {
    int balance;
} CAccount;

CAccount* createAccount(int initialValue) {
    CAccount* account = (CAccount*) malloc(sizeof(CAccount));
    account->balance = initialValue;
    pthread_mutex_init(& (account->lock), NULL);
    return account;
}

int getBalance(CAccount* account) {
    return account->balance;
}

void deposit(CAccount* account, int amount) {
    pthread_mutex_lock(& (account->lock));
    account->balance += amount;
    pthread_mutex_unlock(& (account->lock));
}

int withdraw(CAccount* account, int amount) {
    pthread_mutex_lock(& (account->lock));
    account->balance -= amount;
    pthread_mutex_unlock(& (account->lock));
    return amount;
}

void destroyAccount(CAccount* account) {
    pthread_mutex_destroy(& (account->lock));
    free(account);
}
