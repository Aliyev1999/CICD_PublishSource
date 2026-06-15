CREATE OR ALTER procedure [dbo].[SP_MGM_GetUserMainScreenPendingData] @userId bigint
as
begin
    declare @pendingList table
                         (
                             Header  nvarchar(255),
                             LinkKey nvarchar(100)
                         )
    declare @NoFeedackImageCountToday int, 
            @NoFeedackImageCountLast30Days int, 
            @OfflineUsers int,
            @RiskLimitRequestCount int,
            @InventoryRequestCount int,
            @OperationApprovalCount int
            
    declare
        @PhotoBeginDateToday datetime = cast(cast(getdate() as date) as datetime),
        @PhotoEndDate datetime = getdate(),
        @OfflineDate datetime = dateadd(hour, -24, getdate())
    
    -- Tree Users table 
    declare @TreeUsers table(UserId int);
    insert into @TreeUsers (UserId)
    select UserId
    from F_UIM_GetOrganizationTreeUsers(@userId);
        
    -- Existing metrics
    set @NoFeedackImageCountToday = nullif((select pending
                                            from FN_MGM_GetDashboardData(@UserId, @PhotoBeginDateToday, @PhotoEndDate)), 0)
    set @NoFeedackImageCountLast30Days = nullif((select pending
                                                 from FN_MGM_GetDashboardData(@UserId, dateadd(day, -30, @PhotoBeginDateToday), @PhotoEndDate)), 0)
    set @OfflineUsers = (select count(distinct UserId)
                         from (select Data.UserId, max(GpsDate) Date
                               from OP_UserGpsData Data with (nolock)
                                        join F_GetPermittedUsers(@userId) Permitted on Permitted.UserId = Data.UserId
                               where GpsDate >= @OfflineDate
                               group by Data.UserId) t
                         where Date <= dateadd(minute, -30, getdate()))
    
    -- Risk Limit Request Count 
    set @RiskLimitRequestCount = (
        select count(distinct request.Id)
        from OP_RiskLimitRequest Request with (nolock)
        join OP_RiskLimitClient Client with (nolock) on Request.Id = Client.RequestId
        join @TreeUsers treeusers on Treeusers.UserId = Request.CreatedUserId
        where Request.Status = 0
    )
    
    -- Inventory Request Count 
    set @InventoryRequestCount = (
        select count(*)
        from IM_InventoryDemand Demand with (nolock)
        join @TreeUsers Treeusers on Treeusers.UserId = Demand.CreatorUserId
        where Demand.DemandStatus = 0
    )
    
    -- Operation Approval Count
    set @OperationApprovalCount = (
        select count(*)
        from OP_ThirdPartyRequestQueue Queue with (nolock)
        join @TreeUsers Treeusers on Treeusers.UserId = Queue.UserId
        where --Queue.step in (5, 8)
         -- and
		  Queue.ProcessDate = cast(getdate() as date)
    )
    
    -- Insert to table with dynamic counts
    insert into @pendingList (Header, LinkKey)
    select concat(N'Bu gün çəkilmiş rəy verilməli {{', @NoFeedackImageCountToday, N'}} şəkil var') as Header, 'gallery' as LinkKey
    where @NoFeedackImageCountToday > 0
    union
    select concat(N'Son yarım saatda {{', @OfflineUsers, N'}} əməkdaş oflayn olub'), 'tracking'
    where @OfflineUsers > 0
    union
    select concat(N'Son 30 gün ərzində rəy verilməmiş {{', @NoFeedackImageCountLast30Days, N'}} şəkil qalıb'), 'gallery'
    where @NoFeedackImageCountLast30Days > 0
    union
    select concat(N'Gözləmədə olan {{', @RiskLimitRequestCount, N'}} risk limit tələbi var'), 'RiskLimitRequest'
    where @RiskLimitRequestCount > 0
    union
    select concat(N'Rəy verilməli {{', @InventoryRequestCount, N'}} inventar tələbi mövcuddur'), 'InventoryRequest'
    where @InventoryRequestCount > 0
    union
    select concat(N'{{', @OperationApprovalCount, N'}} əməliyyat təsdiq gözləməsindədir'), 'OperationApproval'
    where @OperationApprovalCount > 0
    
    -- Static entries
    insert into @pendingList (Header, LinkKey) values (N'Musteri Borclari', 'StandardReports.ClientDebt');
    insert into @pendingList (Header, LinkKey) values (N'Kassa qaliqlari', 'StandardReports.CashAccountBalance');
    insert into @pendingList (Header, LinkKey) values (N'Rut Statistikasi', 'StandardReports.RouteStatistics');
    insert into @pendingList (Header, LinkKey) values (N'Musteri Ziyaretleri', 'StandardReports.ClientVisits');
    
    select *
    from @pendingList;
end