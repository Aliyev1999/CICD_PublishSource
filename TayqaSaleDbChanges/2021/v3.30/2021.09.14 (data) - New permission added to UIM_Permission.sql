declare @parentId int = (select Id from UIM_Permission where ObjectName = 'Reports.Client')
declare @id int = (select MAX(Id) + 1  from UIM_Permission)

insert into UIM_Permission([ParentId], [ObjectName], [Description], [CreatedUserId],  [CreatedDate],  [LicenseUserType], [Module], [OrderNo], [Id])
values(@parentId, 'Reports.Client.ContractTerms','Reports Client ContractTerms', 2, GETDATE(), 3, 'Sale', 0, @id)