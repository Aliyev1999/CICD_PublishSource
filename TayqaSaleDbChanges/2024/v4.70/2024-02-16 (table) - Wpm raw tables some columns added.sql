

  ALTER TABLE WPM_Task_Raw ADD CategoryReason int Not null default 0
  ALTER TABLE WPM_Task_Raw ADD SubcategoryReason int Not null default 0
  ALTER TABLE WPM_Task_Raw ADD GroupReason int Not null default 0

  GO

  CREATE TABLE [dbo].[WPM_Task_Raw_Reference](
	[ReferenceType] [tinyint] NULL,
	[ReferenceId] [int] NULL
  ) ON [PRIMARY]
  
  GO

  ALTER TABLE WPM_TaskAction_Raw ADD Specode nvarchar(100)

  GO

