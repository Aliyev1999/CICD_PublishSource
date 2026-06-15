DECLARE @Id SMALLINT
SET @Id = (SELECT MAX(Id)
           FROM SYS_PushMethod)
INSERT INTO SYS_PushMethod
VALUES ('ImConfirmedTransportPackage', 'Transport package confirmation', null, null, 1, 3, 1, null, null, 2, GETDATE(),
        @Id + 1)

GO
