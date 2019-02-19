package account;

public interface CAccount {

    /**
     * Checks current balance of account
     * @return balance of account
     */
    int getBalance();

    /**
     * Adds the given amount to the current balance
     * @param amount amount to increase balance by
     */
    void deposit (int amount);

    /**
     * Removes the given amount from the current balance
     * @param amount amount to remove from balance
     * @return the requested amount to remove
     */
    boolean withdraw (int amount);

}
