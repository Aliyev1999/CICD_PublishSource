DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Reports.General')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Reports.General.ItemProfit', '', 2, GETDATE(), 6, 'Sale');

GO

DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Sale')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Sale.Weight', '', 2, GETDATE(), 5, 'Sale');

GO


DECLARE @maxId int = (select max(Id) from UIM_Permission)
DECLARE @parentId INT = (SELECT Id FROM dbo.UIM_Permission WHERE ObjectName = 'Visit')

INSERT INTO dbo.UIM_Permission(Id, ParentId, ObjectName, Description, CreatedUserId, CreatedDate, LicenseUserType, Module)
VALUES (@maxId + 1, @parentId, N'Visit.Statements', '', 2, GETDATE(), 5, 'Sale');

GO


insert into SYS_MethodPermission (MethodId, PermissionId, PermissionValue, Description, CreatedDate) 
values(530, 67, 1, 'Get Item Profit Report', getdate())

Go

CREATE   FUNCTION [dbo].[F_CHL_QuestionNormativeMappingReport](@userId int)
    Returns Table
        AS
        RETURN
            (
                select Mapping.Id, Mapping.QuestionId, NormativeId
                from CHL_QuestionNormativeMapping Mapping with (nolock)
                         join CHL_Normative Normatives with (nolock)
                              on Normatives.Id = Mapping.NormativeId and Normatives.Status = 0
                         join CHL_SurveyQuestion SurveyQuestion with (nolocK)
                              on Mapping.QuestionId = SurveyQuestion.QuestionId
                         join CHL_SurveyUser SurveyUsers with (nolock) on SurveyUsers.SurveyId = SurveyQuestion.SurveyId
                         join CHL_Survey Surveys with (nolock)
                              on Surveys.Id = SurveyQuestion.SurveyId and Surveys.Firm = Normatives.Firm and
                                 Surveys.IsDeleted = 0 and Surveys.Status = 0
                where SurveyUsers.UserId = @userId
                  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
                  and (Surveys.StartDate <= cast(getdate() as date) and Surveys.EndDate >= cast(getdate() as date))
            )
GO

CREATE   FUNCTION [dbo].[F_CHL_QuestionNormativeMapping](@userId int)
    Returns Table
        AS
        RETURN
            (
                select Mapping.Id, Mapping.QuestionId, NormativeId
                from CHL_QuestionNormativeMapping Mapping with (nolock)
                         join CHL_Normative Normatives with (nolock)
                              on Normatives.Id = Mapping.NormativeId and Normatives.Status = 0
                         join CHL_SurveyQuestion SurveyQuestion with (nolocK)
                              on Mapping.QuestionId = SurveyQuestion.QuestionId
                         join CHL_SurveyUser SurveyUsers with (nolock) on SurveyUsers.SurveyId = SurveyQuestion.SurveyId
                         join CHL_Survey Surveys with (nolock)
                              on Surveys.Id = SurveyQuestion.SurveyId and Surveys.Firm = Normatives.Firm and
                                 Surveys.IsDeleted = 0 and Surveys.Status = 0
                where SurveyUsers.UserId = @userId
                  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))
                  and (Surveys.StartDate <= cast(getdate() as date) and Surveys.EndDate >= cast(getdate() as date))
            )