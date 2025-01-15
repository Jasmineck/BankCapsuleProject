CREATE DATABASE BankAnalyst;

USE BankAnalyst;


CREATE TABLE Users (
    UserID VARCHAR(50) PRIMARY KEY,
    Name CHAR(50) NOT NULL,
    AccountNumber VARCHAR(20) UNIQUE,
    MobileNo BIGINT NOT NULL,
    IDNo VARCHAR(50) NOT NULL,
    accountType VARCHAR(50) NOT NULL,
    DOB varchar(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    AccountNumber VARCHAR(20),
    Amount DECIMAL(15, 2) NOT NULL,
    Interest DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (AccountNumber) REFERENCES Users(AccountNumber)
);

CREATE TABLE Balance (
    BalanceID INT PRIMARY KEY AUTO_INCREMENT,
    AccountNumber VARCHAR(20),
    BalanceAmount DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (AccountNumber) REFERENCES Users(AccountNumber)
);

CREATE TABLE PasswordRecovery (
    RecoveryID INT PRIMARY KEY AUTO_INCREMENT,
    UserID VARCHAR(50),
    RecoveryToken VARCHAR(255) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE BlacklistedAccounts (
    BlacklistID INT PRIMARY KEY AUTO_INCREMENT,
    IDNo VARCHAR(20) UNIQUE
);


CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountNumber VARCHAR(20),
    Debit DECIMAL(15, 2),
    Credit DECIMAL(15, 2),
    FOREIGN KEY (AccountNumber) REFERENCES Users(AccountNumber)
);


DELIMITER //

CREATE PROCEDURE GetAccountDetails(IN accNumber VARCHAR(20))
BEGIN

    SELECT BalanceAmount 
    FROM Balance 
    WHERE AccountNumber = accNumber;


    SELECT Debit, Credit
    FROM Transactions 
    WHERE AccountNumber = accNumber
    ORDER BY TransactionID DESC; 
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER UpdateBalanceAfterTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.Debit IS NOT NULL THEN
        UPDATE Balance
        SET BalanceAmount = BalanceAmount - NEW.Debit
        WHERE AccountNumber = NEW.AccountNumber;
    END IF;

    IF NEW.Credit IS NOT NULL THEN
        UPDATE Balance
        SET BalanceAmount = BalanceAmount + NEW.Credit
        WHERE AccountNumber = NEW.AccountNumber;
    END IF;
END //

DELIMITER ;
