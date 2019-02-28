#include <stdio.h>
#include <pthread.h>
#include <float.h>
#include <limits.h>
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
    attemptArrays = malloc(sizeof(Attempt*) * nThreads);
    for(int i = 0; i < nThreads; ++i) {
        attemptArrays[i] = calloc(NUM_TRIES_PER_THREAD, sizeof(Attempt));
    }
}

void recordAndFreeResultArray(int nThreads) {
    for(int i = 0; i < nThreads; ++i) {
        Attempt* attempts = attemptArrays[i];
        double totalWaitTime = 0;
        double maxWaitTime = 0;
        double minWaitTime = DBL_MAX;

        unsigned int totalTries = 0;
        unsigned int maxTries = 0;
        unsigned int minTries = UINT_MAX;

        for(int j = 0; j < NUM_TRIES_PER_THREAD; ++j) {
            unsigned int numTries = attempts[j].numTries;
            double waitTime = attempts[j].waitTime;

            totalWaitTime += waitTime;
            totalTries += numTries;

            if (numTries > maxTries) maxTries = numTries;
            if (numTries < minTries) minTries = numTries;

            if (waitTime > maxWaitTime) maxWaitTime = waitTime;
            if (waitTime < minWaitTime) minWaitTime = waitTime;
        }

        double averageWaitTime = totalWaitTime / (double) NUM_TRIES_PER_THREAD;
        double averageNumTries = (double) totalTries / (double) NUM_TRIES_PER_THREAD;

        printf("\n%d, %f, %d, %d, %f, %f, %f", i, averageNumTries, minTries, maxTries, averageWaitTime, minWaitTime, maxWaitTime);

        free(attempts);
    }
    free(attemptArrays);
}

int main() {
    for (int nThreads = 1; nThreads < 24; ++nThreads) {
        printf("\nthreadId, averageNumTries, minNumTries, maxNumTries, averageWaitTime, minWaitTime, maxWaitTime");
        initialiseResultArray(nThreads);
        testWithNThreads(nThreads);
        recordAndFreeResultArray(nThreads);
    }
}
