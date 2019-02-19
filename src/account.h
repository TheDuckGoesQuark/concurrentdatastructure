struct CAccount* createAccount(int initialValue);

int getBalance(struct CAccount* account);

void deposit(struct CAccount* account, int amount);

int withdraw(struct CAccount* account, int amount);

void destroyAccount(struct CAccount* account);
