package account;

public class LockingAccount implements CAccount {
    @Override
    public int getBalance() {
        return 0;
    }

    @Override
    public void deposit(int amount) {

    }

    @Override
    public boolean withdraw(int amount) {
        return false;
    }
}
