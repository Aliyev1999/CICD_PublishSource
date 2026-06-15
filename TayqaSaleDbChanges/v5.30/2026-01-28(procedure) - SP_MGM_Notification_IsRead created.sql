CREATE OR ALTER  PROCEDURE [dbo].[SP_MGM_Notification_IsDeleted] 
    @JSONBody NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

	  INSERT INTO Notifications (Message)
    VALUES ('New notification added from API');
    
END;