CREATE function [dbo].[FN_TS_SpecSaleFunctionality_ShouldCheckRiskLimit_XXX](@clientId int)
returns bit as
begin 
declare @shouldCheck bit=1;
declare @combinedClient tinyint=0;

select @combinedClient=count(*) 
FROM LG_XXX_CLCARD WITH (NOLOCK) 
WHERE LOGICALREF=@clientId AND SPECODE5 like 'AU0%'

-- Ozel kodu AU0 ile olan carilerin risk limiti kontrol olunmur
if (@combinedClient=1)
set @shouldCheck=0;

return @shouldCheck;
end
