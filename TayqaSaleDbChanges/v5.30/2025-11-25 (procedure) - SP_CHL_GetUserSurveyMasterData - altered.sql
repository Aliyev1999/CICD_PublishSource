CREATE OR ALTER procedure [dbo].[SP_CHL_GetUserSurveyMasterData] @userId int, @notConsiderPassiveSurveysDate datetime, @clientId int
as
BEGIN



	with PermittedClients as (
        select ClientId 
        from dbo.F_GetPermittedClient(@userId)),

		 ActiveSurveys as (select distinct Survey.Id as SurveyId
                           from CHL_Survey Survey with (nolock)
                                    join CHL_SurveyClient Client with (nolock) on Client.SurveyId = Survey.Id
									join PermittedClients pc with (nolock) on pc.ClientId = Client.ReferenceId 
                           where Survey.IsDeleted = 0
                             and Survey.StartDate <= getdate()
                             and Survey.EndDate >= getdate()
                             and Survey.Status = 0
                             and (@clientId = 0 or (Client.ReferenceId = @clientId and Client.Type = 1))
                           union all
                           select SurveyId
                           from CHL_SurveyClient SurveyClient with (nolock)
                                    join CHL_Survey Survey with (nolock) on Survey.Id = SurveyClient.SurveyId
                                    join MD_ClientGroupData ClientGroup with (nolock) on SurveyClient.ReferenceId = ClientGroup.GroupId and SurveyClient.Type = 2 and
                                                                                         ClientGroup.GroupType = 5
									join PermittedClients pc with (nolock) on pc.ClientId = ClientGroup.ClientId
                           where Survey.IsDeleted = 0
                             and Survey.StartDate <= getdate()
                             and Survey.EndDate >= getdate()
                             and Survey.Status = 0
                             and (@clientId = 0 or (SurveyClient.Type = 2 and ClientGroup.ClientId = @clientId))),

         UserSurveys as (select Id as SurveyUserId, List.SurveyId
                         from CHL_SurveyUser List with (nolock)
                                  join ActiveSurveys on ActiveSurveys.SurveyId = List.SurveyId
                         where UserId = @userId
                         union
                         select Id as SurveyUserId, List.SurveyId
                         from CHL_SurveyUserGroups List with (nolock)
                                  join ActiveSurveys on ActiveSurveys.SurveyId = List.SurveyId
                         where UserGroupId in (select Mapping.GroupId
                                               from MD_UserGroupMapping Mapping with (nolock)
                                                        join MD_UserGroupInfo Info with (nolock) on Info.Id = Mapping.GroupId
                                               where Mapping.UserId = @userId
                                                 and Info.IsDeleted = 0
                                                 and Info.IsActive = 1))


    select UserSurveys.SurveyUserId as SurveyUserId,
           Survey.Id                as SurveyId,
           Survey.Code              as SurveyCode,
           Survey.Name              as SurveyName,
           Survey.Description       as SurveyDescription,
           Survey.Status            as Status,
           Survey.Type              as SurveyType,
           Survey.StartDate         as StartDate,
           Survey.EndDate           as EndDate,
           Survey.StartTime         as StartTime,
           Survey.EndTime           as EndTime,
           null                     as SalesmanCode,     
           null                     as MerchandiserCode,
           Survey.Firm              as Firm,
           Survey.PeriodicalType    as PeriodicalType,
           Survey.CreatedDate       as CreatedDate,
           Survey.ModifiedDate      as ModifiedDate,
           Attachment.Id            as SurveyAttachmentId,
           Attachment.Url           as SurveyAttachmentUrl,
           Attachment.SecureUrl     as SurveySecureUrl,
           null                     as SurveyTagId,      
           null                     as SurveyTag         

    from CHL_Survey Survey with (nolock)
             join UserSurveys on UserSurveys.SurveyId = Survey.Id
             left join CHL_Attachment Attachment on Attachment.Type = 1 and Attachment.ReferenceId = 1

end

