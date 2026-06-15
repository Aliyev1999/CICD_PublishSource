create procedure [dbo].[SP_MD_GetPermittedParametersByUser](
    @userId int,
    @appRelevant bit
)
as
begin

    declare @ConfigParams table
                          (
                              Firm           smallint,
                              OperationName  nvarchar(100),
                              ParameterName  nvarchar(200),
                              ValueFromTable bit,
                              ParameterValue nvarchar(200),
                              IsDefault      bit,
                              Description    nvarchar(500)
                          )

    declare @UserGroupId int = (select top 1 Mapping.GroupId
                                from MD_UserGroupMapping Mapping with (nolock)
                                         join MD_UserGroupInfo Groups with (nolock) on Groups.Id = Mapping.GroupId
                                where UserId = @userId
                                  and Groups.IsActive = 1
                                  and Groups.IsDeleted = 0
                                  and Mapping.IsActive = 1);

    with RawData as (Select UserParam.Firm                                             As Firm,
                            Operation.Name COLLATE SQL_Latin1_General_CP1_CI_AS        As OperationName,
                            Param.Name COLLATE SQL_Latin1_General_CP1_CI_AS            As ParameterName,
                            isnull(Param.ValueFromTable, 0)                            as ValueFromTable,
                            UserParam.ObjectValue COLLATE SQL_Latin1_General_CP1_CI_AS as ParameterValue,
                            isnull(UserParam.IsDefault, 0)                             As IsDefault,
                            ConfigValue.Description                                    As Description,
                            1                                                          as Source
                     From UIM_UserConfigParameter UserParam with (nolock)
                              join SYS_ConfigObject Param with (nolock) on UserParam.ObjectId = Param.Id
                              join SYS_SetOperation Operation with (nolock) on UserParam.OperationId = Operation.Id
                              left join SYS_ConfigObjectValue ConfigValue with (nolock) on UserParam.ObjectId = ConfigValue.ObjectId
                         And UserParam.OperationId = ConfigValue.OperationId
                         And UserParam.Objectvalue = ConfigValue.Value
                     Where UserParam.UserId = @userId
                       And isnull(Param.AppRelevant, 0) = @appRelevant

                     union

                     Select UserParam.Firm                  As Firm,
                            Operation.Name                  As OperationName,
                            Param.Name                      As ParameterName,
                            isnull(Param.ValueFromTable, 0) as ValueFromTable,
                            UserParam.ObjectValue           as ParameterValue,
                            isnull(UserParam.IsDefault, 0)  As IsDefault,
                            ConfigValue.Description         As Description,
                            2                               as Source
                     From UIM_UserGroupConfigParameter UserParam with (nolock)
                              join SYS_ConfigObject Param with (nolock) on UserParam.ObjectId = Param.Id
                              join SYS_SetOperation Operation with (nolock) on UserParam.OperationId = Operation.Id
                              left join SYS_ConfigObjectValue ConfigValue with (nolock) on UserParam.ObjectId = ConfigValue.ObjectId
                         And UserParam.OperationId = ConfigValue.OperationId
                         And UserParam.Objectvalue = ConfigValue.Value COLLATE SQL_Latin1_General_CP1_CI_AS
                     Where UserParam.GroupId = @UserGroupId
                       And isnull(Param.AppRelevant, 0) = @appRelevant),

         Combined as (select *,
                             dense_rank() over (partition by Firm, OperationName order by Source) as DenseRank

                      from RawData)
    insert
    into @ConfigParams (Firm, OperationName, ParameterName, ValueFromTable, ParameterValue, IsDefault, Description)
    select Firm,
           OperationName,
           ParameterName,
           ValueFromTable,
           ParameterValue,
           IsDefault,
           Description
    from Combined
    where DenseRank = 1;

    Select *
    from (select Firm                                         as Firm,
                 OperationName collate Azeri_Latin_100_CI_AS  as OperationName,
                 ParameterName collate Azeri_Latin_100_CI_AS  as ParameterName,
                 ValueFromTable                               as ValueFromTable,
                 ParameterValue collate Azeri_Latin_100_CI_AS as ParameterValue,
                 IsDefault                                    as IsDefault,
                 Description collate Azeri_Latin_100_CI_AS    as Description
          from @ConfigParams

          UNION
          Select Div.[Firm]                              As Firm,
                 Op.[Name]                               As OperationName,
                 'Division'                              As ParameterName,
                 1                                       As ValueFromTable,
                 Cast(Div.[TigerDivisionNr] As NVarChar) As ParameterValue,
                 IsNull(Div.[IsDefault], 0)              As IsDefault,
                 ''                                      As Description
          From [MD_PermittedDivision] Div
                   Inner Join [SYS_SetOperation] Op ON Div.[OperationId] = Op.[Id]
          Where Div.[UserId] = @userId
          UNION
          Select Dp.[Firm]                                As Firm,
                 Op.[Name]                                As OperationName,
                 'Department'                             As ParameterName,
                 1                                        As ValueFromTable,
                 Cast(Dp.[TigerDepartmentNr] As NVarChar) As ParameterValue,
                 IsNull(Dp.[IsDefault], 0)                As IsDefault,
                 ''                                       As Description
          From [MD_PermittedDepartment] Dp
                   Inner Join [SYS_SetOperation] Op ON Dp.[OperationId] = Op.[Id]
          Where Dp.[UserId] = @userId
          UNION
          Select Wh.[Firm]                               As Firm,
                 Op.[Name]                               As OperationName,
                 'Warehouse'                             As ParameterName,
                 1                                       As ValueFromTable,
                 Cast(Wh.[TigerWarehouseNr] As NVarChar) As ParameterValue,
                 IsNull(Wh.[IsDefault], 0)               As IsDefault,
                 ''                                      As Description
          From [MD_PermittedWarehouse] Wh
                   Inner Join [SYS_SetOperation] Op ON Wh.[OperationId] = Op.[Id]
          Where Wh.[UserId] = @userId
          UNION
          Select Fact.[Firm]                             As Firm,
                 Op.[Name]                               As OperationName,
                 'Factory'                               As ParameterName,
                 1                                       As ValueFromTable,
                 Cast(Fact.[TigerFactoryNr] As NVarChar) As ParameterValue,
                 IsNull(Fact.[IsDefault], 0)             As IsDefault,
                 ''                                      As Description
          From [MD_PermittedFactory] Fact
                   Inner Join [SYS_SetOperation] Op ON Fact.[OperationId] = Op.[Id]
          Where Fact.[UserId] = @userId
          UNION
          Select Tg.[Firm]                 As Firm,
                 Op.[Name]                 As OperationName,
                 'TradingGroup'            As ParameterName,
                 1                         As ValueFromTable,
                 TradGrpCode.[Code]        As ParameterValue,
                 IsNull(Tg.[IsDefault], 0) As IsDefault,
                 ''                        As Description
          From [MD_PermittedTradingGroup] Tg
                   Inner Join [SYS_SetOperation] Op ON Tg.[OperationId] = Op.[Id]
                   Inner Join [MD_TradingGroup] TradGrpCode On Tg.[TigerTradingGroupId] = TradGrpCode.[TigerId]
          Where Tg.[UserId] = @userId
          UNION
          Select CashCard.[Firm]                 As Firm,
                 Op.[Name]                       As OperationName,
                 'CashCardCode'                  As ParameterName,
                 1                               As ValueFromTable,
                 CashCardCode.[Code]             As ParameterValue,
                 IsNull(CashCard.[IsDefault], 0) As IsDefault,
                 ''                              As Description
          From [MD_PermittedCashCard] CashCard
                   Inner Join [SYS_SetOperation] Op ON CashCard.[OperationId] = Op.[Id]
                   Inner Join [MD_CashCard] CashCardCode ON CashCard.[TigerCashCardId] = CashCardCode.[TigerId] AND CashCard.Firm = CashCardCode.Firm
          Where CashCard.[UserId] = @userId
          UNION
          Select Currency.[Firm]                           As Firm,
                 Op.[Name]                                 As OperationName,
                 'Currency'                                As ParameterName,
                 1                                         As ValueFromTable,
                 Cast(Currency.[CurrencyType] As NVarChar) As ParameterValue,
                 IsNull(Currency.[IsDefault], 0)           As IsDefault,
                 ''                                        As Description
          From [MD_PermittedCurrency] Currency
                   Inner Join [SYS_SetOperation] Op ON Currency.[OperationId] = Op.[Id]
          Where Currency.[UserId] = @userId
          UNION
          Select BankAccount.[Firm]                 As Firm,
                 Op.[Name]                          As OperationName,
                 'BankAccount'                      As ParameterName,
                 1                                  As ValueFromTable,
                 BankAccountCode.[Code]             As ParameterValue,
                 IsNull(BankAccount.[IsDefault], 0) As IsDefault,
                 ''                                 As Description
          From [MD_PermittedBankAccount] BankAccount
                   Inner Join [SYS_SetOperation] Op ON BankAccount.[OperationId] = Op.[Id]
                   Inner Join [MD_BankAccount] BankAccountCode ON BankAccount.[TigerId] = BankAccountCode.[TigerId] AND BankAccountCode.Firm = BankAccount.Firm
          Where BankAccount.[UserId] = @userId
          UNION
          Select PaymentPlan.[Firm]                      As Firm,
                 Op.[Name]                               As OperationName,
                 'PaymentPlan'                           As ParameterName,
                 1                                       As ValueFromTable,
                 Cast(PaymentPlan.[TigerId] As NVarChar) As ParameterValue,
                 IsNull(PaymentPlan.[IsDefault], 0)      As IsDefault,
                 ''                                      As Description
          From [MD_PermittedPaymentPlan] PaymentPlan
                   Inner Join [SYS_SetOperation] Op On PaymentPlan.[OperationId] = Op.[Id]
          Where PaymentPlan.[UserId] = @userId) T
    Order By [OperationName], [Firm], [ParameterName]

END;
