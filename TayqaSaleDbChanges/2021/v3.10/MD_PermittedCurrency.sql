declare
    @OperationId smallint = 1,
    @CurrencyType int = 162 -- burda valyutani hansi olmalidirsa onu yazmaq lazimdir (162 - AZN)

while @OperationId <= (select max(Id) from SYS_SetOperation)
    begin
        if @OperationId not in (6, 7)
            begin
                insert into MD_PermittedCurrency (Firm, UserId, CurrencyType, OperationId, IsDefault)
				select Firm, UserId, @CurrencyType, @OperationId, 1 from UIM_UserPermission
                where Firm in (select Nr from MD_Firm where IsActive = 1 and IsDefault = 1)
                  and PermissionId in (select Id
                                       from UIM_Permission
                                       where ObjectName = (select Name from SYS_SetOperation where Id = @OperationId))
                  and PermissionValue = 1
                  and UserId not in (select UserId from MD_PermittedCurrency where OperationId = @OperationId)
                set @OperationId += 1
            end
        set @OperationId += 1
    end