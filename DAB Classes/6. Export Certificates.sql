BACKUP MASTER KEY
TO FILE = 'D:\SQLData\Securities\master_key.bak'
ENCRYPTION BY PASSWORD = 'pass2';

BACKUP CERTIFICATE BackupCert
TO FILE = 'D:\SQLData\Securities\BackupCert.cer'
WITH PRIVATE KEY
(
    FILE = 'D:\SQLData\Securities\BackupCert.pvk',
    ENCRYPTION BY PASSWORD = 'pass3'
);