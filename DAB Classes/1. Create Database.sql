create database BankDB;

use BankDB;

CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Email NVARCHAR(150) UNIQUE,
    Phone NVARCHAR(20),
    Address NVARCHAR(250),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Accounts (
    AccountID INT IDENTITY(1001,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    AccountNumber NVARCHAR(20) UNIQUE NOT NULL,
    AccountType NVARCHAR(50),  -- Saving, Current, etc.
    Balance DECIMAL(18,2) DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Accounts_Clients
        FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE Transactions (
    TransactionID BIGINT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionType NVARCHAR(20), -- Credit / Debit
    Amount DECIMAL(18,2) NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    Remarks NVARCHAR(250),

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

