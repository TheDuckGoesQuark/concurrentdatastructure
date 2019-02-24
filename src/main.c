#include <stdio.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include "account.h"

CAccount* account;

void* repeatedlyWithdraw(void* arg) {
    int selfId = *((int *) arg);
    for (int i = 0; i < 1000; i++) {
        withdraw(account, 2);
    }
    free(arg);
    return NULL;
}

void* repeatedlyDeposit(void* arg) {
    int selfId = *((int *) arg);
    for (int i = 0; i < 1000; i++) {
        deposit(account, 2);
    }
    free(arg);
    return NULL;
}

void testWithNThreads(int nThreads) {
    pthread_t tid[nThreads];
    int i = 0;

    account = createAccount(0);
    while (i < nThreads) {
        int* arg = malloc(sizeof(*arg));
        *arg = i;

        int err;
        if (i % 2 == 0) {
            err = pthread_create(&(tid[i]), NULL, repeatedlyWithdraw, arg);
        } else {
            err = pthread_create(&(tid[i]), NULL, repeatedlyDeposit, arg);
        }

        if (err != 0) {
            printf("\ncouldn't create thread : [%s]", strerror(err));
        }
        i++;
    }

    for (int j = 0; j < nThreads; j++) {
        pthread_join(tid[j], NULL);
    }

    printf("\nnThreads: %d, balance: %d", nThreads, getBalance(account));

    destroyAccount(account);
}

int main() {
    for (int nThreads = 1; nThreads < 100; nThreads++) {
        testWithNThreads(nThreads);
    }
}
