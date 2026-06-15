create procedure SP_WPM_GetPhotoTaskMappingForPhotoGalleryReport @attachmentIds nvarchar(max)
as
begin

	IF OBJECT_ID('tempdb..#AttachmentIds') IS NOT NULL
        DROP TABLE #AttachmentIds;

    CREATE TABLE #AttachmentIds
    (
		AttachmentId INT
    );

	INSERT INTO #AttachmentIds (AttachmentId)
	SELECT DISTINCT CAST(Value as int) FROM F_SplitList(@attachmentIds,',')

    SELECT ptm.TaskId, ptm.AttachmentId FROM WPM_PhotoTaskMapping ptm with(nolock)
	JOIN #AttachmentIds attachmentId WITH(NOLOCK) ON ptm.AttachmentId = attachmentId.AttachmentId
	OPTION(RECOMPILE)
end