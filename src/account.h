typedef struct CAccount CAccount;

extern CAccount* createAccount(int initialValue);

extern int getBalance(CAccount* account);

extern void deposit(CAccount* account, int amount);

extern int withdraw(CAccount* account, int amount);

extern void destroyAccount(CAccount* account);
