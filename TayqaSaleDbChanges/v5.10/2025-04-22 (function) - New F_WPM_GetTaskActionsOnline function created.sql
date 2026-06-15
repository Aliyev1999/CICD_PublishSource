
/****** Object:  UserDefinedFunction [dbo].[F_WPM_GetTaskActionsOnline]    Script Date: 4/22/2025 1:50:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_WPM_GetTaskActionsOnline](@userId INT, @clientId INT, @taskId INT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT TOP 10 Id AS ActionId, TA.Params ActionParams FROM WPM_TaskAction TA WHERE TA.TaskId = @taskId

            )
GO
