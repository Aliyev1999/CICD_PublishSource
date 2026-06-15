
CREATE OR ALTER FUNCTION [dbo].[F_SM_GetOrderTemplates](
    @UserId INT,
    @OperationId Tinyint,
    @ClientId bigint
    )
    RETURNS @T TABLE
               (
                   TemplateId   int,
                   TemplateCode nvarchar(100),
                   TemplateName nvarchar(100),
				   TemplateGroupName nvarchar(100)
               )
    AS
    begin



	insert into @T(TemplateId, TemplateCode, TemplateName, TemplateGroupName)
	 select top 1 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Kopyala: ', convert(varchar(20), a.RegisteredDate, 120)),
			'Template Group Name 1'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id
		 --where UserId = @UserId and a.DocType = 0 and a.Id=2101060 --and ClientId = @ClientId
		 group by a.Id, a.RegisteredDate
		  

	union all

	 select top 2 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Kopyala: ', convert(varchar(20), a.RegisteredDate, 120)),
			'Template Group Name 1'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id
		 --where UserId = @UserId and a.DocType = 0 --and ClientId = @ClientId
		 and a.Id=2101120
		 group by a.Id, a.RegisteredDate
		 
	union all

	 select top 3 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Kopyala: ', convert(varchar(20), a.RegisteredDate, 120)),
			null --- 'Template Group Name 2'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id
		 --where UserId = @UserId and a.DocType = 0 --and ClientId = @ClientId
		 and a.Id=2101061
		 group by a.Id, a.RegisteredDate

   
    union all 

	  select top 4 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Sablon: ', convert(varchar(20), a.RegisteredDate, 120)),
			'Template Group Name 2'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id and a.Id=2101060
		 --where UserId = @UserId and a.DocType = 0 and a.Id=2101060 --and ClientId = @ClientId
		 group by a.Id, a.RegisteredDate

    union all 

	  select top 5 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Sablon: ', convert(varchar(20), a.RegisteredDate, 120)),
			'Template Group Name 2'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id  and a.Id=2101061
		 --where UserId = @UserId and a.DocType = 0 and a.Id=2101060 --and ClientId = @ClientId
		 group by a.Id, a.RegisteredDate

	union all 

	  select top 5 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Sablon: ', convert(varchar(20), a.RegisteredDate, 120)),
			'Template Group Name 2'

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id  and a.Id=2101058
		 --where UserId = @UserId and a.DocType = 0 and a.Id=2101060 --and ClientId = @ClientId
		 group by a.Id, a.RegisteredDate
  

  union all 

	  select top 5 a.Id, concat (N' Məbləğ: ', cast(sum(b.Amount * b.Price) as varchar(50)), ' ( ', a.Id, ' )') ,        
			concat( N'Sablon: ', convert(varchar(20), a.RegisteredDate, 120)),
			''

		 from OP_IncomingLog a
		 join OP_IncomingLogCommonLineExtension b on a.Id=b.Id  and a.Id=2101066
		 --where UserId = @UserId and a.DocType = 0 and a.Id=2101060 --and ClientId = @ClientId
		 group by a.Id, a.RegisteredDate



	 --insert into @T(TemplateId, TemplateCode, TemplateName)
  --      select temp.Id, temp.Code, temp.Name
  --      from OP_OnlineOfferTemplateUserMapping as map
  --               join OP_OnlineOfferTemplate as temp on map.TemplateId = temp.Id
  --      where map.UserId = @UserId
  --        and temp.IsActive = 1

--	declare @ClientCode NVARCHAR(100) = (select top 1 Code from MD_Client with(nolock) where IsDeleted=0 and Status=0 and Firm=9 and TigerId=@ClientId);
--WITH RankedVisits AS (
--    SELECT
--        AuditId,
--        SalesPointId,
--		CreatedDate,
--        ROW_NUMBER() OVER (PARTITION BY SalesPointId ORDER BY CreatedDate DESC) AS VisitRank
--    FROM
--        Spec_ExternalVisit
--		where @ClientCode = SalesPointId
--)
--	insert into @T (TemplateId, TemplateCode, TemplateName)
--	--select i.Id, i.Id, i.Id from OP_IncomingLog i 
--	--join OP_GeneralLog g on g.RequestId = i.Id 
--	--where i.ClientId = @ClientId and i.UserId = @UserId and i.DocType + 1 = @OperationId

--SELECT
--    AuditId,
--    AuditId,
--    AuditId
--FROM
--    RankedVisits
--WHERE
--    VisitRank = 1;
	return
	--declare @OrderNo int  
 --   select @OrderNo = OrderNo from  WPM_TaskTicketAction t
 --    join WPM_TaskAction a on t.ActionId = a.Id
	--  join WPM_TaskTicket tt on tt.Id = t.TaskTicketId
 --    where a.TaskId = 7311 and tt.ClientId = @ClientId and cast(tt.CreatedDate as date) = cast(getdate() as date)
	-- if @OrderNo is null
	-- begin
	--insert into @T (TemplateId,TemplateCode,TemplateName)
 --   select TemplateId,TemplateCode,TemplateName from SpecOrderTemplate	where TemplateId = 1
	--end
	--Else
	--	insert into @T (TemplateId,TemplateCode,TemplateName)
 --   select TemplateId,TemplateCode,TemplateName from SpecOrderTemplate	where TemplateId = @OrderNo +1
 --       return
    end

	--select * from  F_SM_GetOrderTemplates (15906,0,1232)
		
