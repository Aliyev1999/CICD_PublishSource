
Create Procedure SP_TDP_BulkPassiveOrActive @status bit, @tableName nvarchar(100), @query nvarchar(500)
as
begin
	declare @sqlTxt nvarchar(max) = N'update ' + @tableName + ' set Status = ' + Cast(@status as nvarchar(1)) + N' where ' + @query;

	execute(@sqlTxt)

end
