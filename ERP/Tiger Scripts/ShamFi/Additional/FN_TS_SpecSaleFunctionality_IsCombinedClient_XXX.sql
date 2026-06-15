CREATE   function [dbo].[FN_TS_SpecSaleFunctionality_IsCombinedClient_XXX](@clientId int)
returns bit as
begin 
declare @IsCombined bit=0;
declare @combinedClient tinyint=0;

select @combinedClient=count(*) 
FROM LG_XXX_CLCARD WITH (NOLOCK) 
WHERE LOGICALREF=@clientId AND  SubString(SPECODE5,1,2)='AU'

if (@combinedClient=1)
set @IsCombined=1;

return @IsCombined;
end