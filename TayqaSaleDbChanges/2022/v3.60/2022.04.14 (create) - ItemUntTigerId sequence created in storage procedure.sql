CREATE PROCEDURE [dbo].[SP_MD_GetItemUnitTigerIdSeq] (@TigerId bigint output) 
AS
BEGIN
	Declare  @SQL  Nvarchar(1000)
	Set @SQL  = 'SELECT @TigerId = NEXT VALUE FOR ItemUnitTigerIdSeq'
	Exec sp_executesql @Sql,N'@TigerId bigint output',@TigerId output
END 
