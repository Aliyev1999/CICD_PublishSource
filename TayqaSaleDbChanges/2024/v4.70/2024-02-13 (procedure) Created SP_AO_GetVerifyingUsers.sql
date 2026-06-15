CREATE proc [dbo].[SP_AO_GetVerifyingUsers] @clientId bigint, @controlDate datetime, @reasonId int
as
begin

select CONCAT(Name,' ',Surname, ' ','(',UserName,')') as Name, Id from AbpUsers a
join MD_PermittedClient b on a.Id=b.UserId
where TigerClientId=@clientId
end
go