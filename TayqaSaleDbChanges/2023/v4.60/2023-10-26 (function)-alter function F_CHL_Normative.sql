ALTER FUNCTION [dbo].[F_CHL_Normative](@userId int)   
Returns Table  
AS  
RETURN(  
select distinct Normatives.Id,  
                Firm,  
                Normatives.StartDate,  
                Normatives.EndDate,  
                Text as Text  
from CHL_Normative Normatives with (nolock)
         join CHL_QuestionNormativeMapping Mapping with (nolock) on Mapping.NormativeId = Normatives.Id  
         join CHL_SurveyQuestion SurveyQuestion with (nolock) on SurveyQuestion.QuestionId = Mapping.QuestionId  
         join CHL_SurveyUser Users with (nolock) on Users.UserId = @userId  
where Normatives.Status = 0  
  and (Normatives.StartDate <= cast(getdate() as date) and Normatives.EndDate >= cast(getdate() as date))  
)