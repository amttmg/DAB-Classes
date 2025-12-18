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