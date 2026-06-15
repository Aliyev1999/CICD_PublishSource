create or alter PROCEDURE [dbo].[SP_OP_GetInfoOnStart] @firm SMALLINT,
                                             @userId INT,
                                             @clientId INT,
                                             @actionType INT
AS
BEGIN
    /*
     query below needs to return the following

     tinyint as Type
     nvarchar(100) as Subject
     nvarchar(255) as Detail
     */

    if 1 = 2
        SELECT 0   as Type,
               ''  as Subject,
               N'' as Detail


END;
