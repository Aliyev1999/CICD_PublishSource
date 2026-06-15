CREATE PROCEDURE [dbo].[SP_MIP_GetMipDashboardMemberActivities](
    @date Datetime,
    @actions nvarchar(5),
	@UserId bigint)
AS
BEGIN
  CREATE TABLE #TempDocTypes (
        RowNum INT IDENTITY(1,1),
        DocType INT
    );

    -- Insert values into the temporary table
    INSERT INTO #TempDocTypes (DocType)
    SELECT value
    FROM F_SplitList(@actions, ',')
    ORDER BY (SELECT NULL);

DECLARE @sql nvarchar(max);
    SET @sql = '
 with  AllVisits AS (
    SELECT
        Ticket.Firm,
        Ticket.ClientId,
        Ticket.UserId
    FROM  WPM_TaskTicket Ticket WITH (NOLOCK)'

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ticket.UserId = otu.UserId')
        END

    set @sql = concat(@sql, ' WHERE CAST(Ticket.CreatedDate AS DATE) > CAST(@date AS DATE)

    UNION

    SELECT
        Firm,
        ClientId,
        CreatedUserId AS UserId
    FROM OP_ClientVisitLog Visit WITH(NOLOCK)')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Visit.CreatedUserId = otu.UserId')
        END
    set @sql = concat(@sql, '
    WHERE CAST(Date AS DATE) > CAST(@Date AS DATE)

    UNION

    SELECT
        Firm,
        ClientId,
        Ilog.UserId
    FROM OP_IncomingLog Ilog WITH (NOLOCK)')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ilog.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '

WHERE cast(DocCreatedTime as date) > cast(@date as date)
),

Operations AS (
    SELECT
        Firm,
        ClientId,
        Ilog.UserId,
        DocCreatedTime,
		DocType
    FROM OP_IncomingLog Ilog WITH (NOLOCK)
        JOIN OP_GeneralLog Glog WITH (NOLOCK) ON Ilog.Id = Glog.RequestId AND Glog.ImportResult = 0')

    IF (dbo.FN_UIM_CheckUserIsAdmin(@userId) = 0)
        BEGIN
            SET @sql =
                    CONCAT(@sql, ' join F_UIM_GetOrganizationTreeUsers(@userId) otu ON Ilog.UserId = otu.UserId');
        END
    set @sql = concat(@sql, '
   WHERE cast(DocCreatedTime as date) > cast(@date as date)
)

    select Users.Id                                                                                    as UserId,
           concat(Users.Name, '' '', Users.Surname)                                                      as [User],
           Users.ProfilePictureId                                                                      as ProfilePictureId,
           Users.Point                                                                                 as UserExpertLevel,
           isnull(COUNT(DISTINCT Operations.ClientId),0)                                                         AS TotalCount,
           isnull(COUNT(DISTINCT AllVisits.ClientId) ,0)                                                         AS VisitCount,
           isnull(COUNT(DISTINCT CASE WHEN RowNum=1 THEN Operations.DocCreatedTime END),0) AS Count1,
           isnull(COUNT(DISTINCT CASE WHEN RowNum=2 THEN Operations.DocCreatedTime END),0) AS Count2
    from AllVisits
             join AbpUsers Users with (nolock) on AllVisits.UserId = Users.Id
             left join Operations on AllVisits.UserId = Operations.UserId
			 left join  #TempDocTypes temp on Operations.DocType=temp.DocType

 GROUP BY Users.Id, CONCAT(Users.Name, '' '', Users.Surname), Users.ProfilePictureId, Users.Point')
 print @sql
    execute sp_executesql @sql,
            N' @userId bigint,
			   @date Datetime,
               @actions nvarchar(5)',
            @userId=@userId,
			@date=@date,
			@actions=@actions


END