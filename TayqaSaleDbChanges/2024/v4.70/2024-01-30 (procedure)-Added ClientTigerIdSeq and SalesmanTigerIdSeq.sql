CREATE PROCEDURE [dbo].[SP_MD_GetClientTigerIdSeq] (@TigerId bigint output) 
AS
BEGIN
	Declare  @SQL  Nvarchar(1000)
	Set @SQL  = 'SELECT @TigerId = NEXT VALUE FOR ClientTigerIdSeq'
	Exec sp_executesql @Sql,N'@TigerId bigint output',@TigerId output
END 

go

CREATE PROCEDURE [dbo].[SP_MD_GetSalesmanTigerIdSeq] (@TigerId bigint output) 
AS
BEGIN
	Declare  @SQL  Nvarchar(1000)
	Set @SQL  = 'SELECT @TigerId = NEXT VALUE FOR SalesmanTigerIdSeq'
	Exec sp_executesql @Sql,N'@TigerId bigint output',@TigerId output
END 