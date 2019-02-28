#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include "account.h"

long max_delay_nsec = 10;
long initial_delay_nsec = 1;

typedef struct CAccount {
    int balance;
    pthread_mutex_t lock;
} CAccount;

void assignCurrentTimePlusDelay(struct timespec timeoutTime, long delay) {
    clock_gettime(CLOCK_REALTIME, &timeoutTime);
    timeoutTime.tv_nsec += delay;
}

void obtainLock(CAccount* account, Attempt* attempt) {
    long delay = initial_delay_nsec;

    struct timespec timeoutTime;
    assignCurrentTimePlusDelay(timeoutTime, delay);

    attempt->numTries++;
    while(pthread_mutex_timedlock(&(account->lock), &timeoutTime) != 0) {
        attempt->numTries++;
        delay *= 2;
        if (delay >= max_delay_nsec) {
            delay = initial_delay_nsec;
        }
        assignCurrentTimePlusDelay(timeoutTime, delay);
    }
}

void releaseLock(CAccount* account) {
    pthread_mutex_unlock(& (account->lock));
}

CAccount* createAccount(int initialValue) {
    CAccount* account = (CAccount*) malloc(sizeof(CAccount));
    account->balance = initialValue;
    pthread_mutex_init(& (account->lock), NULL);
    return account;
}

int getBalance(CAccount* account, Attempt* attempt) {
    int val;
    obtainLock(account, attempt);
    val = account->balance;
    releaseLock(account);
    return val;
}

void deposit(CAccount* account, int amount, Attempt* attempt) {
    obtainLock(account, attempt);
    account->balance += amount;
    releaseLock(account);
}

int withdraw(CAccount* account, int amount, Attempt* attempt) {
    obtainLock(account, attempt);
    account->balance -= amount;
    releaseLock(account);
    return amount;
}

void destroyAccount(CAccount* account) {
    pthread_mutex_destroy(& (account->lock));
    free(account);
}
