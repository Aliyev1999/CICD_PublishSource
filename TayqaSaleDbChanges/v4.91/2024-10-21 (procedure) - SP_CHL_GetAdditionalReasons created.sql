CREATE procedure [dbo].[SP_CHL_GetAdditionalReasons]
as
begin
    -- to be written custom for client
    select 1                  as Id,
           'Name'             as Name,
           cast(2 as tinyint) as MandatoryType,
           cast(2 as tinyint) as CustomReasonInputType,
           'AnswerText'       as AnswerText,
           cast(1 as tinyint) as ReasonType
end
go