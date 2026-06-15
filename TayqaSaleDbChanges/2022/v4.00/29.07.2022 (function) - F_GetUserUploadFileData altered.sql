ALTER FUNCTION [dbo].[F_GetUserUploadFileData](@userId bigint, @firm smallint, @beginDate datetime,
                                                @endDate datetime,
                                                @clientId int)
    Returns Table
        AS
        RETURN
            (
                SELECT fileLog.Note,
                       fileLog.UploadedUserName AS UserName,
                       u.Name,
                       u.Surname,
                       fileLog.FileCreatedDate  AS Date,
                       fileLog.FilePath,
                       reason.Name              AS Reason
                FROM OP_FileUploadLog fileLog
                         LEFT JOIN F_UIM_GetOrganizationTreeUsers(@userId) users ON users.UserId = fileLog.UploadedUserId
                         LEFT JOIN AbpUsers u on u.Id = users.UserId or u.Id = UploadedUserId
                         LEFT JOIN MD_StopReason reason ON reason.Id = fileLog.ReasonId
                WHERE fileLog.Firm = @firm
                  and fileLog.ContentType = 1
                  and fileLog.FileCreatedDate > @beginDate
                  and fileLog.FileCreatedDate < @endDate
                  and fileLog.ClientId = @clientId
                  and (fileLog.UploadedUserId = @userId or users.UserId is not null)
            )