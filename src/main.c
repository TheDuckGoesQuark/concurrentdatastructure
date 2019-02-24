#include <stdio.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include "account.h"

CAccount* account;

void* repeatedlyWithdraw(void* arg) {
    int selfId = *((int *) arg);
    printf("\nThread [%d] started.", selfId);
    for (int i = 0; i < 100; i++) {
        withdraw(account, 2);
    }

    printf("\nThread [%d] complete.", selfId);

    free(arg);
    return NULL;
}

void* repeatedlyDeposit(void* arg) {
    int selfId = *((int *) arg);
    printf("\nThread [%d] started.", selfId);
    for (int i = 0; i < 100; i++) {
        deposit(account, 2);
    }

    printf("\nThread [%d] complete.", selfId);

    free(arg);
    return NULL;
}

int main() {

    int nThreads = 10;
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

    printf("\nFinal value of account: %d", getBalance(account));

    destroyAccount(account);
}
