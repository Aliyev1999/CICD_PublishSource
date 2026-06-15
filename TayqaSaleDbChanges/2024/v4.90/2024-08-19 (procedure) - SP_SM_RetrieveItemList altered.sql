ALTER PROCEDURE [dbo].[SP_SM_RetrieveItemList] @firmId SMALLINT, @clientId BIGINT, @docType TINYINT, @userId int
AS
BEGIN

    declare @List table
                  (
                      ItemId            int,
                      OrderNo           int,
                      SuggestedQuantity float,
                      Note              nvarchar(100)
                  )

END