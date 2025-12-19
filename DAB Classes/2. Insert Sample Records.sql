use BankDB;

;WITH N AS (
    SELECT TOP (10000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)
INSERT INTO Clients (FullName, Email, Phone, Address)
SELECT
    CONCAT('Client ', n),
    CONCAT('client', n, '@mail.com'),
    CONCAT('98', RIGHT('00000000' + CAST(n AS VARCHAR), 8)),
    CONCAT('City ', (n % 50) + 1)
FROM N;


INSERT INTO Accounts (ClientID, AccountNumber, AccountType, Balance)
SELECT
    ClientID,
    CONCAT('ACC-', ClientID),
    CASE WHEN ClientID % 2 = 0 THEN 'Saving' ELSE 'Current' END,
    ABS(CHECKSUM(NEWID())) % 500000 + 1000
FROM Clients;


;WITH T AS (
    SELECT TOP (10000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM sys.objects a
    CROSS JOIN sys.objects b
)


INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate, Remarks)
SELECT
    a.AccountID,
    CASE WHEN rn % 2 = 0 THEN 'Credit' ELSE 'Debit' END,
    ABS(CHECKSUM(NEWID())) % 10000 + 100,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
    'Auto generated transaction'
FROM T
JOIN Accounts a ON a.AccountID = 1000 + (rn % (SELECT COUNT(*) FROM Accounts)) + 1;

SELECT 
    (SELECT COUNT(*) FROM Clients)      AS TotalClients,
    (SELECT COUNT(*) FROM Accounts)     AS TotalAccounts,
    (SELECT COUNT(*) FROM Transactions) AS TotalTransactions;
