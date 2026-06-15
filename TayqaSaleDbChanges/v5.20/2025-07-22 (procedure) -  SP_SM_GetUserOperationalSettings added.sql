CREATE procedure [dbo].[SP_SM_GetUserOperationalSettings](
    @userId int
)
as
begin

    declare @ConfigParams table
                          (
                              ObjectId       smallint,
                              ParameterValue nvarchar(200),
                              IsDefault      bit,
                              Description    nvarchar(500)
                          );

    declare @UserGroupId int = (select top 1 Mapping.GroupId
                                from MD_UserGroupMapping Mapping with (nolock)
                                         join MD_UserGroupInfo Groups with (nolock) on Groups.Id = Mapping.GroupId
                                where UserId = @userId
                                  and Groups.IsActive = 1
                                  and Groups.IsDeleted = 0
                                  and Mapping.IsActive = 1);

    with RawData as (Select UserParam.ObjectId             as ObjectId,
                            UserParam.ObjectValue          as ParameterValue,
                            isnull(UserParam.IsDefault, 0) as IsDefault,
                            ConfigValue.Description        as Description,
                            1                              as Source
                     From UIM_UserConfigParameter UserParam with (nolock)
                              join SYS_ConfigObject Param with (nolock) on UserParam.ObjectId = Param.Id
                              join SYS_SetOperation Operation with (nolock) on UserParam.OperationId = Operation.Id
                              left join SYS_ConfigObjectValue ConfigValue with (nolock)
                                        on UserParam.ObjectId = ConfigValue.ObjectId
                                            And UserParam.OperationId = ConfigValue.OperationId
                                            And UserParam.Objectvalue = ConfigValue.Value
                     Where UserParam.UserId = @userId
                       AND UserParam.OperationId = 1
                       AND UserParam.ObjectId IN (1, 27)
                     union

                     Select UserParam.ObjectId             as ObjectId,
                            UserParam.ObjectValue          as ParameterValue,
                            isnull(UserParam.IsDefault, 0) as IsDefault,
                            ConfigValue.Description        as Description,
                            2                              as Source
                     From UIM_UserGroupConfigParameter UserParam with (nolock)
                              join SYS_ConfigObject Param with (nolock) on UserParam.ObjectId = Param.Id
                              join SYS_SetOperation Operation with (nolock) on UserParam.OperationId = Operation.Id
                              left join SYS_ConfigObjectValue ConfigValue with (nolock)
                                        on UserParam.ObjectId = ConfigValue.ObjectId
                                            And UserParam.OperationId = ConfigValue.OperationId
                                            And UserParam.Objectvalue = ConfigValue.Value
                     Where UserParam.GroupId = @UserGroupId
                       AND UserParam.OperationId = 1
                       AND UserParam.ObjectId IN (1, 27)),
         Combined as (select *,
                             dense_rank() over (partition by ObjectId order by Source) as DenseRank
                      from RawData)
    insert
    into @ConfigParams (ObjectId, ParameterValue, IsDefault, Description)
    select ObjectId,
           ParameterValue,
           iif(IsDefault = 1 and DenseRank = 1, 1, 0) as IsDefault,
           Description
    from Combined
    --where DenseRank = 1;

    select ObjectId                                     as ObjectId,
           ParameterValue collate Azeri_Latin_100_CI_AS as ParameterValue,
           IsDefault                                    as IsDefault,
           Description collate Azeri_Latin_100_CI_AS    as Description
    from @ConfigParams
    --order by [ObjectId];
end;
go

