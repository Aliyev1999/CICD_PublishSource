GO

declare @maxId int;
set @maxId = (select Max(Id) from WPM_TaskActionType);

insert into WPM_TaskActionType values (@maxId +1 , 'SimpleTask','Simple task', GETDATE(),'{"selectionType":1,"answers":["he","yox"]}',1)

GO