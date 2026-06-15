 -- CREATED BY RAMIL ALIYEV
 -- This script will remove auto increement from ID column.
 -- See more: https://stackoverflow.com/a/23511453/8810311
 
 Begin try
  Begin transaction
            ALTER TABLE SYS_UserActionType ADD Id_WithoutIdentity SMALLINT NULL
				
			-- See more: https://stackoverflow.com/a/6376909/8810311	
			EXEC('UPDATE SYS_UserActionType SET Id_WithoutIdentity = Id;');

			ALTER TABLE SYS_UserActionType DROP CONSTRAINT PK_SYS_UserActionType;   

			ALTER TABLE SYS_UserActionType DROP COLUMN Id;

			ALTER TABLE SYS_UserActionType ALTER COLUMN Id_WithoutIdentity SMALLINT NOT NULL;

			EXEC sp_rename 'dbo.SYS_UserActionType.Id_WithoutIdentity', 'Id', 'COLUMN';

			ALTER TABLE SYS_UserActionType ADD CONSTRAINT PK_SYS_UserActionType  PRIMARY KEY  (Id);
  Commit transaction
End try
Begin catch
  Rollback transaction
  print('Transaction rollbacked');
  throw;
End catch
 