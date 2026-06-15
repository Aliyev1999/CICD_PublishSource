ALTER TABLE SYS_SqlQueryExecutorSchedule
    ADD RunAgainOnError BIT NOT NULL DEFAULT 1
GO
ALTER TABLE SYS_SqlQueryExecutorSchedule
    ADD Name NVARCHAR(50) NOT NULL DEFAULT ''
GO
ALTER TABLE SYS_SqlQueryExecutorSchedule
    ADD Description NVARCHAR(255)
GO
ALTER TABLE SYS_SqlQueryExecutorSchedule
    ALTER COLUMN Status TINYINT NOT NULL