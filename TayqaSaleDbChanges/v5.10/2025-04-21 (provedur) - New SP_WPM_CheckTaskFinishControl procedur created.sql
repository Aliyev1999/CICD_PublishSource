
/****** Object:  StoredProcedure [dbo].[SP_WPM_CheckTaskFinishControl]    Script Date: 4/21/2025 3:12:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SP_WPM_CheckTaskFinishControl] @taskTicketId int
as
begin

 declare  @CreatedDate datetime,
          @FinalizedDate datetime,
          @TimeDifference int;


    select @CreatedDate = CreatedDate 
    from WPM_TaskTicket with (nolock)
    where Id = @TaskTicketId;


    set @TimeDifference =datediff(second, @CreatedDate, getdate());
    
    
    if @TimeDifference < 60
    begin
        select N'Bitirə bilməzsən' as Subject, 
               N'Heç olmasa 2 dq işlə' as Detail, 
                cast(1 as smallint ) as LinkType, 
                N'.activity.RiskLimitsActivity' as LinkKey
        return;
    end

end

GO
