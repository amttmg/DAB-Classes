alter database BankDB add filegroup FG_2024_BEFORE
alter database BankDB add filegroup FG_2024;
alter database BankDB add filegroup FG_2025;
alter database BankDB add filegroup FG_2025_AFTER

alter database BankDB add file (
    NAME = TransactionBefore2024,
    FILENAME = 'D:\SQLData\Data\TransactionBefore2024.ndf',
    SIZE = 50MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_2024_BEFORE;

alter database BankDB add file (
    NAME = Transaction2024,
    FILENAME = 'D:\SQLData\Data\Transaction2024.ndf',
    SIZE = 50MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_2024;

alter database BankDB add file (
    NAME = Transaction2025,
    FILENAME = 'D:\SQLData\Data\Transaction2025.ndf',
    SIZE = 50MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_2025;

alter database BankDB add file (
    NAME = TransactionAfter2025,
    FILENAME = 'D:\SQLData\Data\TransactionAfter2025.ndf',
    SIZE = 50MB,
    FILEGROWTH = 10MB
) TO FILEGROUP FG_2025_AFTER;


create partition function pf_transaction_date(DATETIME)
AS RANGE RIGHT FOR VALUES
(
    '2024-01-01',
    '2025-01-01',
    '2026-01-01'
);


create partition SCHEME ps_transaction_date
as partition pf_transaction_date
to(
FG_2024_BEFORE,
FG_2024,
FG_2025,
FG_2025_AFTER
);


CREATE CLUSTERED INDEX clustered_index_transaction_date
ON Transactions (TransactionDate, TransactionID)
ON ps_transaction_date (TransactionDate);

SELECT
    p.partition_number,
    SUM(p.rows) AS row_count
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID('dbo.Transactions')
  AND p.index_id IN (0,1)   -- heap or clustered index
GROUP BY p.partition_number
ORDER BY p.partition_number;


INSERT INTO dbo.Transactions
    (AccountID, TransactionType, Amount, TransactionDate, Remarks)
VALUES
    (1001, N'Credit',  15000.00, '2026-01-05 10:15:00', N'Opening balance 2025'),
    (1002, N'Debit',    2500.00, '2026-03-12 14:20:00', N'ATM withdrawal'),
    (1003, N'Credit',  42000.00, '2026-06-18 09:45:00', N'Salary deposit'),
    (1001, N'Debit',    8000.00, '2026-09-02 16:30:00', N'Online payment'),
    (1002, N'Credit',  12000.00, '2026-12-20 11:05:00', N'Year-end bonus');




