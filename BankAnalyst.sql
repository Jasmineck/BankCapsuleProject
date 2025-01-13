CREATE DATABASE BankAnalyst;

USE BankAnalyst;

CREATE TABLE Users (
    UserID VARCHAR(50) PRIMARY KEY,
    Name CHAR(50) NOT NULL,
    AccountNumber VARCHAR(20) UNIQUE,
    MobileNo BIGINT NOT NULL,
    IDNo VARCHAR(50) NOT NULL,
    accountType VARCHAR(50) NOT NULL,
    DOB VARCHAR(50) NOT NULL,
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
