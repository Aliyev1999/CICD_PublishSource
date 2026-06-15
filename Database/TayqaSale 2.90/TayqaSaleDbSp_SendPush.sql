SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		TayqaTech
-- Create date: 2018-09-22
-- Description:	Stored Procedure to send adminitrative pushes
-- =============================================
CREATE PROCEDURE dbo.SendAdministrativeNotifications WITH ENCRYPTION	
AS
BEGIN	
	SET NOCOUNT ON;    

	Declare @PushMethodId Int = 0
	-- get push methods to send
	Declare PushMethods Cursor For
		Select P.Id
		From SYS_PushMethod P
		Inner Join OP_PushSchedule S On P.Id = S.PushMethodId
		Where IsNull(P.Status, 0) = 1 And DateDiff(MI, S.LastPushSendTime, GetDate()) >= S.Period
	Open PushMethods 
	Fetch Next From PushMethods
	Into @PushMethodId
	While @@FETCH_STATUS = 0
	Begin

		-- insert push related data into queue
		Insert Into OP_AdministrativePushQueue
		(PushMethodId, Message, Status, PushToken, UserId, CreatedDate, RegisteredUserId)
		Select @PushMethodId, '', 0, D.PushToken, U.Id, GetDate(), 1
		From AbpUsers U
		Inner Join UIM_UserTypeUserMapping M On U.Id = M.UserId
		Inner Join UIM_UserType T On M.UserTypeId = T.Id
		Inner Join UIM_UserAuthToken A On A.UserId = U.Id 
		Inner Join UIM_Device D On D.Id = A.DeviceId And IsNull(D.PushToken, '') > ''
		Where U.IsDeleted = 0 And IsActive = 1 And T.Type In ('SalePerson', 'Audit', 'Hybrid')

		-- set last send time
		Update OP_PushSchedule
		Set LastPushSendTime = GetDate()
		Where PushMethodId = @PushMethodId

		Fetch Next From PushMethods
		Into @PushMethodId
	End
	Close PushMethods
	Deallocate PushMethods

END
GO
