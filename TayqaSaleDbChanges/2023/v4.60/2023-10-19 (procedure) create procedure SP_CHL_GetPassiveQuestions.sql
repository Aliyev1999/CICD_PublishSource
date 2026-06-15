

create procedure SP_CHL_GetPassiveQuestions
(
	@surveyId int
)
as
begin
	
	select sq.QuestionId,
		(case 
			when q.Status = 1 then 0
			when sq.Status = 1 then 1 end) as Type
		from CHL_Question q
		left join CHL_SurveyQuestion sq on q.Id = sq.QuestionId 
		where sq.SurveyId = @surveyId and (q.Status = 1 or sq.Status = 1)
end