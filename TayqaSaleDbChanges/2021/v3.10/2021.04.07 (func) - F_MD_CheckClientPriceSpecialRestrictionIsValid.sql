ALTER function [dbo].[F_MD_CheckClientPriceSpecialRestrictionIsValid](
@firm smallint, 
@tigerClientId int,
@requestId int,
@operationId tinyint,
@totalPrice float)
returns 
@T table
( 
HasRestriction bit NOT NULL,
IsValid bit NOT NULL,
Code nvarchar(50),
[Description] nvarchar(50)
)
as 
begin
declare @hasRestriction bit, @isValid bit;

SELECT  
@isValid = case   
			when @totalPrice>100  then 0 
			else 1
	       end 
from MD_Client with (NOLOCK) where Firm = @firm and TigerId = @tigerClientId and Code like '%1'

INSERT INTO @T VALUES(0,COALESCE(@isValid,1),'ClientSpecialPriceRestriction','Test');
return;
end