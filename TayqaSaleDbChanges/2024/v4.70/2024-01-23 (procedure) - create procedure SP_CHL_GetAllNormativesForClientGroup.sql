CREATE PROCEDURE [dbo].[SP_CHL_GetAllNormativesForClientGroup](@firm SMALLINT ,
																@status BIT ,
																@normativeNameOrCode NVARCHAR(500) ,
																@questionNameOrCode NVARCHAR(500) ,
																@clientNameCodeOrEdino NVARCHAR(500) ,
																@clientGroupNameOrCode NVARCHAR(500) ,
																@clientGroupType SMALLINT ,
																@searchByCreationTime BIT ,
																@startDate DATETIME ,
																@endDate DATETIME )
AS
BEGIN

    declare @Query nvarchar(max);

    set @Query =
            'select distinct ClientGroup.GroupId as ClientOrGroupId,
					ClientGroup.GroupCode		 as ClientOrGroupCode,
		            ClientGroup.GroupName        as ClientOrGroupName,
				    Normative.Code               as NormativeCode,
                    Normative.Name               as NormativeName,
                    NormativeClientGroup.Minimum as Minimum,
                    NormativeClientGroup.Maximum as Maximum,
                    Normative.StartDate          as StartDate,
                    Normative.EndDate            as EndDate,
                    Normative.Type               as NormativeType,
                    NormativeClientGroup.Number  as Number,
                    NormativeClientGroup.Point   as Point,
                    NormativeClientGroup.Status  as Status,
                    NormativeClientGroup.Text    as Text
           from CHL_NormativeForClientGroup NormativeClientGroup with (nolock)
                join MD_ClientGroupInfo ClientGroup with (nolock)
                     on NormativeClientGroup.GroupId = ClientGroup.GroupId and ClientGroup.Firm = NormativeClientGroup.Firm and ClientGroup.IsDeleted = 0
                join CHL_Normative Normative with (nolock) on NormativeClientGroup.NormativeId = Normative.Id and Normative.Firm = NormativeClientGroup.Firm
				left join CHL_QuestionNormativeMapping QuestionMapping with(nolock) on QuestionMapping.NormativeId = Normative.Id
                left join CHL_Question Question with(nolock) on QuestionMapping.QuestionId = Question.Id and Question.Firm=Normative.Firm
			    left join MD_ClientGroupData GroupData with(nolock) on GroupData.GroupId = ClientGroup.Id and GroupData.GroupType=ClientGroup.GroupType and ClientGroup.Firm=GroupData.Firm
			    left join MD_Client Client with(nolock) on Client.TigerId = GroupData.ClientId and Client.Firm = GroupData.Firm 
				          and Client.[Status]=0 and (Client.IsDeleted is null or Client.IsDeleted = 1)
		
			where NormativeClientGroup.Firm=@Firm '

	if @status is not null
		set @Query = concat(@Query, ' and Normative.[Status] = @status')
    
	if @startDate is not null and @endDate is not null and (@searchByCreationTime = 1)
		set @Query = concat(@Query, ' and (Normative.CreationTime between @startDate and @endDate)')

    if @clientGroupNameOrCode is not null
		set @Query = concat(@Query, ' and (ClientGroup.GroupName like ''%'+@clientGroupNameOrCode+'%'' or ClientGroup.GroupCode like ''%'+@clientGroupNameOrCode+'%'')')
   
    if @normativeNameOrCode is not null
		set @Query = concat(@Query, ' and (Normative.Name like ''%'+@normativeNameOrCode+'%'' or Normative.Code like ''%'+@normativeNameOrCode+'%'')')

	if @clientGroupType is not null
		set @Query = concat(@Query, ' and (ClientGroup.GroupType=@clientGroupType)')

    if @clientNameCodeOrEdino is not null
		set @Query = concat(@Query, ' and (Client.Name like ''%'+@clientNameCodeOrEdino+ '%'' or Client.Code like ''%'+@clientNameCodeOrEdino+'%'' or Client.Edino like ''%'+@clientNameCodeOrEdino+'%'')')

    if @questionNameOrCode is not null
		set @Query = concat(@Query, ' and (Question.Name like ''%'+@questionNameOrCode+'%'' or Question.Code like ''%'+@questionNameOrCode+'%'')')

    EXEC sp_executesql @Query, N'@firm SMALLINT NULL,
									@status BIT,
									@normativeNameOrCode NVARCHAR(500),
									@questionNameOrCode NVARCHAR(500),
									@clientNameCodeOrEdino NVARCHAR(500),
									@clientGroupNameOrCode NVARCHAR(500),
									@clientGroupType SMALLINT,
									@searchByCreationTime BIT,
									@startDate DATETIME,
									@endDate DATETIME',
									@firm=@firm,
									@status=@status,
									@normativeNameOrCode = @normativeNameOrCode,
									@questionNameOrCode = @questionNameOrCode,
									@clientNameCodeOrEdino = @clientNameCodeOrEdino,
									@clientGroupNameOrCode = @clientGroupNameOrCode,
									@clientGroupType = @clientGroupType,
									@searchByCreationTime = @searchByCreationTime,
									@startDate = @startDate,
									@endDate = @endDate
END