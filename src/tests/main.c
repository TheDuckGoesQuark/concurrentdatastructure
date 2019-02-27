#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "account.h"

CAccount* account;

int NUM_TRIES_PER_THREAD = 1000;

Attempt** attemptArrays;

void* repeatedlyWithdraw(void* arg) {
    int selfId = *((int *) arg);
    Attempt* attempts = attemptArrays[selfId];
    for (int i = 0; i < NUM_TRIES_PER_THREAD; i++) {
        clock_t begin = clock();
        withdraw(account, 2, &(attempts[i]));
        clock_t end = clock();
        attempts[i].waitTime = (double)(end - begin) / CLOCKS_PER_SEC;
    }
    free(arg);
    return NULL;
}

void* repeatedlyDeposit(void* arg) {
    int selfId = *((int *) arg);
    Attempt* attempts = attemptArrays[selfId];
    for (int i = 0; i < NUM_TRIES_PER_THREAD; i++) {
        clock_t begin = clock();
        deposit(account, 2, &(attempts[i]));
        clock_t end = clock();
        attempts[i].waitTime = (double)(end - begin) / CLOCKS_PER_SEC;
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

    destroyAccount(account);
}

void initialiseResultArray(int nThreads) {
        for(int i = 0; i < nThreads; ++i) {
            attemptArrays[i] = malloc(sizeof(Attempt) * NUM_TRIES_PER_THREAD);
        }
}

void recordAndFreeResultArray(int nThreads) {
        for(int i = 0; i < nThreads; ++i) {
            Attempt* attempts = attemptArrays[i];
            for(int j = 0; j < NUM_TRIES_PER_THREAD; ++j) {
                printf("\n%d, %d, %f", i, attempts[j].numTries, attempts[j].waitTime);
            }
            free(attempts);
        }
}

int main() {
    for (int nThreads = 1; nThreads < 100; nThreads++) {
        printf("\nUSING %d THREADS", nThreads);
        printf("\nthreadId, numTries, waitTime");
        initialiseResultArray(nThreads);
        testWithNThreads(nThreads);
        recordAndFreeResultArray(nThreads);
    }
}
