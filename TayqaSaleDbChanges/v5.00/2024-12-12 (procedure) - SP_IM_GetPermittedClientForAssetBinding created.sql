CREATE OR ALTER procedure [dbo].[SP_IM_GetPermittedClientForAssetBinding](
    @filter nvarchar(100),
    @firm smallint,
    @currentUserId int,
    @sorting nvarchar(100),
    @maxResultCount int,
    @skipCount int,
    @totalCount int output
)
as
begin
    declare @query nvarchar(max);
    declare @totalCountQuery nvarchar(max);
set @query = ' 
select
		TigerId,
		Code,
		Name,
		Taxno,
		SpecialCode
from MD_Client client with(nolock)
join F_GetAllPermittedUsersPermittedClients(@currentUserId) pclient on client.TigerId=pclient.ClientId
where client.Firm=@firm '

    if (@filter is not null)
begin
    set @query = concat(@query, ' and (Code like ''%' + @filter + '%'' or Name like ''%' + @filter + '%'' or Taxno like ''%' + @filter + '%'' or SpecialCode like ''%' + @filter + '%'')');
end



    set @totalCountQuery = concat('select @totalCount = count(1) from (', @query, ' ) t');

    print (@totalCountQuery);

    execute sp_executesql @totalCountQuery,
            N'@filter nvarchar(100),
              @firm smallint,
              @currentUserId int,
              @totalCount int output',
            @filter= @filter,
            @firm =@firm,
            @currentUserId =@currentUserId,
            @totalCount =@totalCount out;

    set @query = concat(@query, ' order by  ' + @sorting + '  offset @skipCount rows fetch next @maxResultCount rows only')

    execute sp_executesql @query,
            N'@filter nvarchar(100),
              @firm smallint,
              @currentUserId int,
              @sorting nvarchar(100),
              @maxResultCount int,
              @skipCount int,
              @totalCount int output',
            @filter= @filter,
            @firm =@firm,
            @currentUserId =@currentUserId,
            @sorting=@sorting,
            @maxResultCount =@maxResultCount,
            @skipCount =@skipCount,
            @totalCount =@totalCount out;

end
