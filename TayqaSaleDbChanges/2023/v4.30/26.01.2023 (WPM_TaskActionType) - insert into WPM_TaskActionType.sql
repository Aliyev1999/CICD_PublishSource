declare @newTaskActionTypeId as smallint
select @newTaskActionTypeId= max(Id)+1
from [WPM_TaskActionType]

INSERT INTO WPM_TaskActionType (Id,Name, Description, CreatedDate,Template,IsActive)
VALUES (@newTaskActionTypeId,'DebtCheck','Debt check',getdate(),'{}',1);