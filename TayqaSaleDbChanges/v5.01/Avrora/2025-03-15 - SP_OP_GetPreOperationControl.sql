ALTER proc [dbo].[SP_OP_GetPreOperationControl](
    @userId int,
    @firm smallint,
    @clientId int,
    @docType tinyint,
    @userActionType smallint, -- See: SYS_UserActionType table  
    @latitude float =null,
    @longitude float= null,
    @referenceId int = null
)
as
begin
    if @docType = 0 and @userActionType < 30
        begin
            declare @OperationCount int = (select count(*)
                                           from OP_IncomingLog with (nolock)
                                           where ClientId = @clientId
                                             and UserId = @userId
                                             and Firm = @firm
                                             and DocType = @docType
                                             and ProcessDate = cast(getdate() as date))
            if @OperationCount > 0
                select 'IgnoreGPSRestriction' as [Key],
                       cast(1 as bit)         as Value,
                       null                   as LinkType,
                       null                   as Link
        end;


    IF @userActionType = 1
        and @userId in (SELECT Id
                        FROM AbpUsers
                        WHERE Code IN (SELECT DISTINCT CAST(SalesmanId AS NVARCHAR(50))
                                       FROM MD_SalesmanClientMapping
                                       WHERE EXISTS (SELECT 1
                                                     FROM MD_Client
                                                     WHERE MD_Client.TigerId = MD_SalesmanClientMapping.ClientId
                                                       AND RIGHT(MD_Client.Code, 3) IN ('B01', 'B02')))
                          AND IsDeleted = 0
                          AND IsActive = 1 --B01 və B02 carilərinə bağlı istifadəçilər
        )
        and @clientId in (SELECT TigerId FROM MD_Client with (nolock) WHERE RIGHT(Code, 3) IN ('B01', 'B02'))
        and not EXISTS (SELECT Id
                        FROM OP_ClientVisitLog with (nolock)
                        WHERE CAST(CreatedDate AS DATE) = CAST(GETDATE() AS DATE)
                          and CreatedUserId = @userId
                          AND ClientId = @clientId)
        BEGIN

            SELECT N'Err1'                                    AS [Key],
                   N'Ziyarət əməliyyatında şəkil çəkilməyib.' AS Value,
                   null                                       as LinkType,
                   null                                       as Link
        END;

		--IF @userActionType < = 31 
		--	AND @UserId IN (SELECT Id 
		--					FROM AbpUsers  WITH(NOLOCK)
		--					WHERE 1 = 1 
		--					AND AbpUsers.IsDeleted = 0 
		--					AND AbpUsers.IsActive = 1
		--					AND (EXISTS (
		--									SELECT 1
		--									FROM MD_SalesmanClientMapping  WITH(NOLOCK)
		--									WHERE MD_SalesmanClientMapping.SalesmanId = TRY_CAST(TRIM(AbpUsers.Code) AS INT)
		--									AND EXISTS (
		--												SELECT 1 
		--												FROM MD_Client  WITH(NOLOCK)
		--												WHERE MD_Client.TigerId = MD_SalesmanClientMapping.ClientId
		--												AND LEFT(MD_Client.Code,1) = '1' --Bakı Cariləri
		--												))
		--								)
		--					AND NOT EXISTS (
		--									SELECT 1
		--									FROM MD_SalesmanClientMapping  WITH(NOLOCK)
		--									WHERE MD_SalesmanClientMapping.SalesmanId = TRY_CAST(TRIM(AbpUsers.Code) AS INT)
		--									AND EXISTS (
		--												SELECT 1 
		--												FROM MD_Client  WITH(NOLOCK)
		--												WHERE MD_Client.TigerId = MD_SalesmanClientMapping.ClientId
		--												AND SpecialCode4 = '50' --HOREKA Cariləri
		--												)
		--								)
		--					AND NOT EXISTS (
		--								SELECT 1
		--								FROM MD_SalesmanClientMapping  WITH(NOLOCK)
		--								WHERE MD_SalesmanClientMapping.SalesmanId = TRY_CAST(TRIM(AbpUsers.Code) AS INT)
		--								AND EXISTS (
		--											SELECT 1 
		--											FROM MD_Client  WITH(NOLOCK)
		--											WHERE MD_Client.TigerId = MD_SalesmanClientMapping.ClientId
		--											AND RIGHT(Code , 3) = 'O09' --Xırdalan Cariləri
		--											)
		--								))
							
		--	AND NOT EXISTS (
		--					SELECT 1
		--					FROM WPM_TaskTicket TaskTicket WITH(NOLOCK)
		--					INNER JOIN WPM_TaskTicketAction TaskTicketAction  ON TaskTicket.Id = TaskTicketAction.TaskTicketId
		--					WHERE UserId = @UserId
		--					AND TaskTicket.TaskId = 5469  --giriş çıxış tapşırıq id
		--					AND TaskTicketAction.ActionId = 6592  --giriş əməliyyatı id
		--					AND CAST(TaskTicketAction.CreatedDate AS DATE) = CAST(GETDATE() AS DATE)) 

		--	BEGIN 
		--		SELECT N'Err1'                                    AS [Key],
  --                 N'İlkin olaraq Giriş-Çıxış tapşırığını başlatmaq lazımdır!' AS Value,
  --                 null                                       as LinkType,
  --                 null                                       as Link
		--	END ;
end
