-- 1. Create master key
USE master;
GO
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'P@ssw9rd###';
GO

-- 2. Restore certificate
CREATE CERTIFICATE BackupCert
FROM FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Securities\BackupCert.cer'
WITH PRIVATE KEY
(
    FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Securities\BackupCert.pvk',
    DECRYPTION BY PASSWORD = 'P@ssw9rd###2'
);
GO

-- 3. Restore database
RESTORE DATABASE OrderDB
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\OrderDB_FULL.bak';
GO
