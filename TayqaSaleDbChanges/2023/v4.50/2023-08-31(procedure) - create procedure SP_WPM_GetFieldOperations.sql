
CREATE PROCEDURE [dbo].[SP_WPM_GetFieldOperations] @beginDate datetime,
                                                  @endDate datetime,
                                                  @userId int
AS
BEGIN
    with Data as (
--1,2,3,4,5,6,7,8,9,10,11 IncomingLog
        select TreeUsers.UserId                 as UserId,
               ClientId,
               Ilog.DocCreatedTime              as CreatedDate,
               Ilog.DocSavedTime                as FinalizedDate,
			   case when DocType =1 then 4
			   when DocType=2 then 5 
			   When DocType=3 then 2
			   when DocType =4 then 3 else
               DocType + 1                   end   as ActionTypeId,
               cast(RequestId as nvarchar(100)) as AttachmentReference
        from OP_IncomingLog Ilog with (nolock)
                 join OP_GeneralLog Glog with (nolock) on Glog.RequestId = Ilog.Id and Glog.ImportResult = 0
                 join F_UIM_GetOrganizationTreeUsers(1048) TreeUsers
                      on TreeUsers.UserId = Ilog.UserId
        where ProcessDate between @beginDate and @endDate
          and DocType < 20

        union
--12 Visit
        select TreeUsers.UserId                as UserId,
               Visit.ClientId                  as ClientId,
               Visit.Date                      as CreatedDate,
               Visit.CreatedDate               as FinalizedDate,
               12                              as ActionTypeId,
               cast(Visit.Id as nvarchar(100)) as AttachmentReference
        from OP_ClientVisitLog Visit with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = visit.CreatedUserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
        union
--13 Delivery
        select distinct TreeUsers.UserId     as UserId,
                        client.ClientTigerId as ClientId,
                        package.CreationTime as CreatedDate,
                        EndTime              as FinalizedDate,
                        13                   as ActionTypeId,
                        null                 as AttachmentReference
        from DM_TransportPackage package with (nolock)
                 join DM_TransportClient client with (nolock) on package.Id = client.TransportPackageId and package.Firm = client.ClientFirm
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = package.CreatorUserId
        where cast(package.CreationTime as date) between @BeginDate and @endDate

        union
--14 Survey
        select TreeUsers.UserId                   as UserId,
               Response.ClientId                  as ClientId,
               Response.CreatedDate               as CreatedDate,
               Response.SavedDate                 as FinalizedDate,
               14                                 as ActionTypeId,
               cast(Response.Id as nvarchar(100)) as AttachmentReference
        from CHL_UserSurveyResponse Response with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = Response.UserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
        union
--15 Task 18-WorkExecution
        select TreeUsers.UserId                     as UserId,
               TaskTicket.ClientId                  as ClientId,
               TaskTicket.CreatedDate               as CreatedDate,
               TaskTicket.FinalizedDate             as FinalizedDate,
               case
                   when Tasks.Type = 1 then 15
                   when Tasks.Type = 5 then 18 end  as ActionTypeId,
               cast(TaskTicket.Id as nvarchar(100)) as AttachmentReference
        from WPM_TaskTicket TaskTicket with (nolock)
                 join WPM_Task Tasks with (nolock) on TaskTicket.TaskId = Tasks.Id
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TaskTicket.UserId
        where Tasks.Type in (1, 5)
          and cast(TaskTicket.CreatedDate as date) between @BeginDate and @endDate
        union
--16 WorkPlanStart
        select TaskTicket.UserId as UserId,
               ClientId,
               CreatedDate       as CreatedDate,
               null              as FinalizedDate,
               16                as ActionTypeId,
               null              as AttachmentReference
        from WPM_TaskTicket TaskTicket with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TaskTicket.UserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
        union
--17 WorkPlan finish
        select TreeUsers.UserId as UserId,
               ClientId,
               FinalizedDate    as CreatedDate,
               null             as FinalizedDate,
               17               as ActionTypeId,
               null             as AttachmentReference
        from WPM_TaskTicket TaskTicket with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TaskTicket.UserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
          and FinalizedDate is not null
        union
-- 19 DebtControl
        select distinct TreeUsers.UserId                        as UserId,
                        ClientId,
                        cast(CreationTime as datetime)          as CreatedDate,
                        null                                    as FinalizedDate,
                        19                                      as ActionTypeId,
                        cast(AuditOperationId as nvarchar(max)) as ActionReference
        from AO_AuditOperationLine line with (nolock)
                 JOIN AO_AuditOperation operation with (nolock) on line.AuditOperationId = operation.Id and operation.IsDeleted = 0
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = operation.CreatedUserId
        where Cast(CreationTime as date) between @BeginDate and @endDate
        union
--20,21 Inventory Demand to Client
        select TreeUsers.UserId            as UserId,
               ClientTigerId               as ClientId,
               CreationTime                as CreatedDate,
               RegisteredDate              as FinalizedDate,
               iif(DemandType = 1, 20, 21) as ActionTypeId,
               null                        as AttachmentReference
        from IM_InventoryDemand Demand with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = Demand.CreatorUserId
        where cast(CreationTime as date) between @BeginDate and @endDate
        union
--22,23 Inventory demand reject
        select TreeUsers.UserId              as UserId,
               ClientTigerId                 as ClientId,
               CreationTime                  as CreatedDate,
               RegisteredDate                as FinalizedDate,
               iif(DemandStatus = 1, 22, 23) as ActionTypeId,
               null                          as AttachmentReference
        from IM_InventoryDemand Demand with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = Demand.CreatorUserId
        where cast(CreationTime as date) between @BeginDate and @endDate
          and DemandStatus in (1, 2)
        union
--24,25 Inventory state history
        select TreeUsers.UserId                  as UserId,
               ClientTigerId                     as ClientId,
               CreatedDate                       as CreatedDate,
               null                              as FinalizedDate,
               iif(StateHistoryType = 1, 25, 24) as ActionTypeId,
               cast(Id as nvarchar(100))         as AttachmnetReference
        from IM_InventoryStateHistory State with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = State.CreatorUserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
        union
--26 InventoryDelivery
        select TreeUsers.UserId     as UserId,
               demand.ClientTigerId as ClientId,
               package.CreationTime as CreatedDate,
               null                 as FinalizedDate,
               26                   as ActionTypeId,
               null                 as AttachmentReference
        from IM_InventoryTransportPackage package with (nolock)
                 join IM_TransportPackageTransferDemandMapping mapping with (nolock) on mapping.TransportPackageId = package.Id
                 join IM_InventoryDemand demand with (nolock) on mapping.TransferDemandId = demand.Id
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = package.DriverUserId
        where cast(package.CreationTime as date) between @BeginDate and @endDate

        union
--27 InventoryControl
        select TreeUsers.UserId as UserId,
               ClientTigerId    as ClientId,
               CreatedDate      as CreatedDate,
               null             as FinalizedDate,
               27               as ActionTypeId,
               null             as AttachmentReference
        from IM_InventoryCheckOnClientOperation CheckOn with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = CheckOn.CreatorUserId
        where cast(CreatedDate as date) between @BeginDate and @endDate
        union
--28 InventoryTransferDemand between clients
        select TreeUsers.UserId as UserId,
               FromClientId     as ClientId,
               CreationTime     as CreatedDate,
               null             as FinalizedDate,
               28               as ActionTypeId,
               null             as AttachmentReference
        from IM_TransferDemand TransferDemand with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TransferDemand.CreatorUserId
        where cast(CreationTime as date) between @BeginDate and @endDate
        union
--29 confirm 30 reject
        select TreeUsers.UserId        as UserId,
               FromClientId            as ClientId,
               CreationTime            as CreatedDate,
               null                    as FinalizedDate,
               iif(Status = 1, 29, 30) as ActionTypeId,
               null                    as AttachmentReference
        from IM_TransferDemand TransferDemand with (nolock)
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = TransferDemand.CreatorUserId
        where cast(CreationTime as date) between @BeginDate and @endDate
          and Status in (1, 2)

        union
--31 RiskLimitRequest
        select TreeUsers.UserId as UserId,
               ClientId,
               CreatedDate      as CreatedDate,
               null             as FinalizedDate,
               31               as ActionTypeId,
               null             as AttachmentReference
        from OP_RiskLimitRequest Request with (nolock)
                 join OP_RiskLimitClient Client with (nolock) on Request.Id = Client.RequestId
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = Request.CreatedUserId
        where cast(CreatedDate as date) between @BeginDate and @EndDate
        union
--32,33 Risk Limit Confirm-Reject
        select TreeUsers.UserId        as UserId,
               ClientId,
               ControlledDate          as CreatedDate,
               null                    as FinalizedDate,
               iif(Status = 1, 32, 33) as ActionTypeId,
               null                    as AttachmentReference
        from OP_RiskLimitRequest Request with (nolock)
                 join OP_RiskLimitClient Client with (nolock) on Request.Id = Client.RequestId
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = Request.CreatedUserId
        where cast(CreatedDate as date) between @BeginDate and @EndDate
          and Status in (1, 2)

-- 34,35,36,37,38,39
        union
        select TreeUsers.UserId                                                           as UserId,
               taskticket.ClientId                                                        as ClientId,
               ticketaction.CreatedDate                                                   as CreatedDate,
               ticketaction.FinalizedDate                                                 as FinalizedDate,
               case
                   when actiontype.Id = 1 then 34
                   when actiontype.Id = 2 then 35
                   when actiontype.Id = 3 then 36
                   when actiontype.Id = 4 then 37
                   when actiontype.Id = 5 then 38
                   when actiontype.Id = 6 then 39 end                                     as ActionTypeId,
               iif(actiontype.Id in (1, 2), cast(ticketaction.Id as nvarchar(100)), null) as AttachmentReference
        from WPM_TaskTicketAction ticketaction with (nolock)
                 join WPM_TaskAction action with (nolock) on ticketaction.ActionId = action.Id and action.Status = 0
                 join WPM_TaskActionType actiontype with (nolock) on actiontype.Id = action.ActionType and IsActive = 1
                 join WPM_TaskTicket taskticket with (nolock) on ticketaction.TaskTicketId = taskticket.Id and taskticket.TaskId = action.TaskId
                 join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                      on TreeUsers.UserId = taskticket.UserId
        where cast(ticketaction.CreatedDate as date) between @BeginDate and @endDate
          and ActionType in (1, 2, 3, 4, 5, 6)
        union
        --40 SendClient GPS data
        SELECT case
                   when ModifiedUserId is null then CreatedUserId
                   else ModifiedUserId end AS UserId,
               ClientId                    AS ClientId,
               case
                   when ModifiedDate is null then CreatedDate
                   else ModifiedDate end   AS CreatedDate,
               NULL                        AS FinalizedDate,
               40                          AS ActionTypeId,
               NULL                        AS AttachmentReference
        FROM MD_ClientGpsData GPS WITH (NOLOCK)
               JOIN F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                           ON (TreeUsers.UserId = GPS.ModifiedUserId OR TreeUsers.UserId = GPS.CreatedUserId)
        WHERE cast(coalesce(ModifiedDate, CreatedDate) as date)  BETWEEN @BeginDate AND @EndDate

    union
    --41 Penetration
--42 ProductAnalysis
    select TreeUsers.UserId as UserId,
           ClientId,
           RegisteredDate   as CreatedDate,
           null             as FinalizedDate,
           41               as ActionTypeId,
           null             as AttachmentReference
    from PN_AuditOperation Audit with (nolock)
             join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                  on TreeUsers.UserId = Audit.UserId
    where cast(RegisteredDate as date) between @BeginDate and @endDate
    union
--43,44,45,46 WarehouseStockDemand
    select TreeUsers.UserId                 as UserId,
           Case
               when DocType + 1 = 24 then WarehouseIn
               when DocType + 1 = 22 then WarehouseIn
               when DocType + 1 = 23 then WarehouseOut
               else WarehouseIn end         as ClientId,
           Ilog.DocCreatedTime              as CreatedDate,
           Ilog.DocSavedTime                as FinalizedDate,
           Case
               when DocType + 1 = 24 then 43
               when DocType + 1 = 22 then 45
               when DocType + 1 = 23 then 46
               else 44 end                  as ActionTypeId,
           cast(RequestId as nvarchar(100)) as AttachmentReference
    from OP_IncomingLog Ilog with (nolock)
             join OP_GeneralLog Glog with (nolock) on Glog.RequestId = Ilog.Id and Glog.ImportResult = 0
             join OP_IncomingLogWarehouseOperationExtension warehouse on warehouse.Id = Ilog.Id
             join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                  on TreeUsers.UserId = Ilog.UserId
    where ProcessDate between @BeginDate and @endDate
      and DocType in (21, 23, 22, 24)
    union
--47 ClientPhotoUploadLog
    select TreeUsers.UserId as UserId,
           ClientId         as ClientId,
           FileCreatedDate  as CreatedDate,
           null             as FinalizedDate,
           47               as ActionTypeId,
           null             as AttachmentReference
    from OP_FileUploadLog ULog with (nolock)
             join F_UIM_GetOrganizationTreeUsers(@UserId) TreeUsers
                  on TreeUsers.UserId = ULog.UploadedUserId
    where ContentType=1 and cast(FileCreatedDate as date) between @BeginDate and @endDate)
    Select UserName                               as UserName,
           concat(Users.Name, ' ', Users.Surname) as UserFullName,
           Users.Id                               as UserId,
           CreatedDate,
           FinalizedDate,
           isnull(Client.Code, warehouse.Nr)      as ClientCode,
           isnull(Client.Name, warehouse.Name)    as ClientName,
           cast(ActionTypeId as tinyint)          as ActionType,
           AttachmentReference                    as ActionReference
    from Data

             left join MD_Client Client with (nolock) on Client.TigerId = Data.ClientId and ActionTypeId not in (43, 44, 45, 46)
             join AbpUsers Users with (nolock) on Data.UserId = Users.Id
             left join MD_Warehouse warehouse with (nolock) on Data.ClientId = warehouse.Nr and ActionTypeId in (43, 44, 45, 46) and warehouse.Firm=Client.Firm
    order by CreatedDate desc


END
