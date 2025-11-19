using BankAccount;

namespace TestProject
{
    [TestClass]
    public class UnitTests
    {
        [TestMethod]
        public void TestMethod_Create_BankAccount()
        {
            string owner = "John";
            int open_balance = 1000;

            BankAccount.BankAccount account =
                new BankAccount.BankAccount(owner, open_balance);

            Assert.AreEqual(open_balance, account.Balance);
            Assert.AreEqual(owner, account.CustomerName);

        }
        [TestMethod]
        public void TestMethod_Debit_Function()
        {
            string owner = "John";
            int open_balance = 10000;
            int debit = 3000;
            int expected = 7000;
            BankAccount.BankAccount account =
                new BankAccount.BankAccount(owner, open_balance);

            account.Debit(debit);

            Assert.AreEqual(expected, account.Balance);
        }

        [TestMethod]
        public void TestMethod_Debit_Function_More_Amount()
        {
            string owner = "John";
            int open_balance = 1000;
            int debit = 3000;
            BankAccount.BankAccount account =
                new BankAccount.BankAccount(owner, open_balance);
            //account.Debit(debit);

            Assert.ThrowsException<System.ArgumentOutOfRangeException>(
                () => account.Debit(debit));
        }

        [TestMethod]
        public void TestMethod_Credit_Function()
        {
            string owner = "John";
            int open_balance = 10000;
            int credit = 3000;
            int expected = 13000;
            BankAccount.BankAccount account =
                new BankAccount.BankAccount(owner, open_balance);

            account.Credit(credit);

            Assert.AreEqual(expected, account.Balance, 0.1, "Check debit function");

        }
    }
}