#include <stdio.h>
#include "account.h"

int main() {
    struct CAccount* account = createAccount(5);
    printf("Account value %d\n", getBalance(account));
    deposit(account, 5);
    printf("Account after deposit %d\n", getBalance(account));
    int val = withdraw(account, 10);
    printf("Account after withdrawing %d %d\n", val, getBalance(account));
    destroyAccount(account);
}
