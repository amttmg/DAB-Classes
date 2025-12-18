--create master key
use master

--create master key
create master key
encryption by password = 'P@ssw9rd###'

BACKUP MASTER KEY
TO FILE = 'D:\SQLData\Securities\master_DMK.bak'
ENCRYPTION BY PASSWORD = 'P@ssw9rd###1';



SELECT * FROM sys.symmetric_keys
WHERE name = '##MS_DatabaseMasterKey##';


create certificate BackupCert
with subject = 'Certificate for Backup Encryption'
GO

BACKUP CERTIFICATE BackupCert
TO FILE = 'D:\SQLData\Securities\BackupCert.cer'
WITH PRIVATE KEY
(
    FILE = 'D:\SQLData\Securities\BackupCert.pvk',
    ENCRYPTION BY PASSWORD = 'P@ssw9rd###2'
);
GO


BACKUP DATABASE OrderDB
TO DISK = 'D:\SQLData\Backup\OrderDB_FULL.bak'
WITH
    FORMAT,  --  Important
    ENCRYPTION
    (
        ALGORITHM = AES_256,
        SERVER CERTIFICATE = BackupCert
    ),
    COMPRESSION;
GO





