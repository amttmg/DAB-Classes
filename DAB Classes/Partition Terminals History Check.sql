SET STATISTICS IO ON;        -- Logical/physical reads
SET STATISTICS TIME ON;      -- CPU time and elapsed time


USE TerminalsDB1;
GO

SELECT *
FROM dbo.StatusHistory
WHERE DateTime1 >= '2025-01-01' AND DateTime1 < '2025-01-30';

USE TerminalsDB;
GO

SELECT *
FROM dbo.StatusHistory
WHERE DateTime1 >= '2025-01-01' AND DateTime1 < '2025-01-30';
