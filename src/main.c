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
        printf("\nThread [%d] sees account value %d before withdraw.", selfId, getBalance(account));
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
        printf("\nThread [%d] sees account value %d before deposit.", selfId, getBalance(account));
        deposit(account, 2);
    }

    printf("\nThread [%d] complete.", selfId);

    free(arg);
    return NULL;
}

int main() {

    pthread_t tid[2];
    int i = 0;

    account = createAccount(0);
    while (i < 2) {
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

    pthread_join(tid[0], NULL);
    pthread_join(tid[1], NULL);

    destroyAccount(account);
}
