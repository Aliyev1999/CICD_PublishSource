CREATE  PROCEDURE [dbo].[SP_CHL_GetAllNormativesForClient](@firm SMALLINT,
                                                         @status BIT,
                                                         @normativeNameOrCode NVARCHAR(500),
                                                         @questionNameOrCode NVARCHAR(500),
                                                         @clientNameCodeOrEdino NVARCHAR(500),
                                                         @clientGroupNameOrCode NVARCHAR(500),
                                                         @clientGroupType SMALLINT,
                                                         @searchByCreationTime BIT,
                                                         @startDate DATETIME,
                                                         @endDate DATETIME)
AS
BEGIN
    DECLARE @Query NVARCHAR(MAX);

    SET @Query =
            '
			select distinct Client.TigerId  as ClientOrGroupId,
					Client.Code		        as ClientOrGroupCode,
		            Client.Name             as ClientOrGroupName,
				    Normative.Code          as NormativeCode,
                    Normative.Name          as NormativeName,
                    NormativeClient.Minimum as Minimum,
                    NormativeClient.Maximum as Maximum,
                    Normative.StartDate     as StartDate,
                    Normative.EndDate       as EndDate,
                    Normative.Type          as NormativeType,
                    NormativeClient.Number  as Number,
                    NormativeClient.Point   as Point,
                    NormativeClient.Status  as Status,
                    NormativeClient.Text    as Text
           from CHL_NormativeForClient NormativeClient with (nolock)
		        join MD_Client Client with(nolock) on Client.TigerId = NormativeClient.ClientId and Client.Firm = NormativeClient.Firm 
				          and Client.[Status]=0 
                join CHL_Normative Normative with (nolock) on NormativeClient.NormativeId = Normative.Id and Normative.Firm = NormativeClient.Firm
				left join CHL_QuestionNormativeMapping QuestionMapping with(nolock) on QuestionMapping.NormativeId = Normative.Id
                left join CHL_Question Question with(nolock) on QuestionMapping.QuestionId = Question.Id and Question.Firm=Normative.Firm
			    left join MD_ClientGroupData GroupData with(nolock) on GroupData.ClientId = Client.TigerId and Client.Firm=GroupData.Firm
				left join MD_ClientGroupInfo ClientGroup with (nolock)
                     on GroupData.GroupId = ClientGroup.GroupId and ClientGroup.Firm = GroupData.Firm and ClientGroup.IsDeleted = 0 and
					 GroupData.GroupType=ClientGroup.GroupType 
			where NormativeClient.Firm=@Firm'

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