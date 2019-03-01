typedef struct CAccount CAccount;

typedef struct Attempt {
    unsigned int numTries;
    double waitTime;
} Attempt;

extern CAccount* createAccount(int initialValue);

extern int getBalance(CAccount* account, Attempt* attempt);

extern void deposit(CAccount* account, int amount, Attempt* Attempt);

extern int withdraw(CAccount* account, int amount, Attempt* attempt);

extern void destroyAccount(CAccount* account);
