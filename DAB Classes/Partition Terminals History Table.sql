
-- create file groups
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202501;
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202502;
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202503;
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202504;
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202505;
ALTER DATABASE TerminalsDB ADD FILEGROUP GB_202506;

--create files on filgroups
ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202501,
    FILENAME = 'D:\SQLData\StatusHistory202501.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202501;

ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202502,
    FILENAME = 'D:\SQLData\StatusHistory202502.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202502;

ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202503,
    FILENAME = 'D:\SQLData\StatusHistory202503.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202503;

ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202504,
    FILENAME = 'D:\SQLData\StatusHistory202504.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202504;

ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202505,
    FILENAME = 'D:\SQLData\StatusHistory202505.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202505;

ALTER DATABASE TerminalsDB ADD FILE (
    NAME = StatusHistory202506,
    FILENAME = 'D:\SQLData\StatusHistory202506.ndf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
) TO FILEGROUP GB_202506;

--check files and filgroups
SELECT 
    fg.name AS FileGroupName,
    f.name AS FileName,
    f.physical_name AS PhysicalFile
FROM sys.filegroups fg
JOIN sys.master_files f ON fg.data_space_id = f.data_space_id
WHERE f.database_id = DB_ID('TerminalsDB');

--create partition function

CREATE PARTITION FUNCTION PF_DateTime1 (DATETIME)
AS RANGE RIGHT
FOR VALUES 
(
    '2025-01-01',
    '2025-02-01',
    '2025-03-01',
    '2025-04-01',
    '2025-05-01',
    '2025-06-01'
);

--create partition schema
CREATE PARTITION SCHEME PS_DateTime1
AS PARTITION PF_DateTime1
TO (
GB_202501, 
GB_202502, 
GB_202503,
GB_202504,
GB_202505, 
GB_202506,
GB_202506
);

--add clustered index
CREATE CLUSTERED INDEX CX_StatusHistory_DateTime1
ON StatusHistory(DateTime1)
ON PS_DateTime1(DateTime1);  


--check partition

SELECT
    ps.name AS partition_scheme,
    dds.destination_id AS partition_number,
    fg.name AS filegroup_name,
    ISNULL(p.rows, 0) AS rows_in_partition
FROM sys.partition_schemes ps
JOIN sys.destination_data_spaces dds
    ON ps.data_space_id = dds.partition_scheme_id
JOIN sys.filegroups fg
    ON dds.data_space_id = fg.data_space_id
LEFT JOIN sys.partitions p
    ON p.partition_number = dds.destination_id
    AND p.object_id = OBJECT_ID('StatusHistory')  -- your partitioned table
    AND p.index_id IN (0,1)  -- 0=heap, 1=clustered index
WHERE ps.name = 'PS_DateTime1'
ORDER BY dds.destination_id;


SELECT *
FROM StatusHistory
WHERE $PARTITION.PF_DateTime1(DateTime1) = 2; -- partition 2




