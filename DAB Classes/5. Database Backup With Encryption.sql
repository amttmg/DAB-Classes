use master;

create master key
encryption by password = 'pass1'

create certificate BackupCert
with subject = 'Certificate for Backup Encryption'

BACKUP DATABASE BankDB
TO DISK = 'D:\SQLData\Backup\BankDB_Encrypted_FULL.bak'
WITH
    FORMAT,
    ENCRYPTION
    (
        ALGORITHM = AES_256,
        SERVER CERTIFICATE = BackupCert
    ),
    COMPRESSION;
GO