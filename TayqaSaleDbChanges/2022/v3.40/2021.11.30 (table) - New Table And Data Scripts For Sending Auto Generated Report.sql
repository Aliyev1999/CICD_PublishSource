
-- Tables Scripts

-- MSG_AutoGeneratingReport

CREATE TABLE [dbo].[MSG_AutoGeneratingReport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportId] [smallint] NOT NULL,
	[UserId] [int] NULL,
	[Email] [nvarchar](50) NULL,
	[FilterData] [nvarchar](max) NULL,
	[LastModificationTime] [datetime] NULL,
	[LastModifierUserId] [bigint] NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorUserId] [bigint] NOT NULL,
	[IntervalType] [tinyint] NOT NULL,
	[SendingSchedule] [nvarchar](max) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[EmailSubject] [nvarchar](max) NULL,
	[EmailBody] [nvarchar](max) NULL,
	[SendingType] [tinyint] NOT NULL,
 CONSTRAINT [PK__OP_AutoG__3214EC0798CA995B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MSG_AutoGeneratingReport] ADD  CONSTRAINT [DF__OP_AutoGe__Creat__4749DEC4]  DEFAULT (getdate()) FOR [CreationTime]
GO


-- MSG_ReportFilter

CREATE TABLE [dbo].[MSG_ReportFilter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[UIElement] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- MSG_ReportFilterMapping

CREATE TABLE [dbo].[MSG_ReportFilterMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FilterId] [int] NOT NULL,
	[ReportId] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[LineNr] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- MSG_ReportForAutoGenerating

CREATE TABLE [dbo].[MSG_ReportForAutoGenerating](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Module] [tinyint] NOT NULL,
	[DefaultFilterJson] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


-- MSG_ReportUrlMapping

CREATE TABLE [dbo].[MSG_ReportUrlMapping](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[ReportId] [smallint] NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[HTTPRequestType] [tinyint] NOT NULL,
	[SendingType] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


-- MSG_UIElement

CREATE TABLE [dbo].[MSG_UIElement](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



-- Data Scripts

-- MSG_UIElement Table Data Scripts

SET IDENTITY_INSERT [dbo].[MSG_UIElement] ON 

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (1, N'firm-combo', N'Single Selected Permitted Firms Combo');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (2, N'multi-permitted-users', N'Multi Selected Combobox For Permitted Users');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (3, N'multi-item-groups', N'Multi Selected Combobox For Item Groups');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (4, N'bulk-paste', N'Text Area For Paste Text');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (5, N'multi-years-combo', N'Multi selected Combobox For selecting Years');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (6, N'multi-months-combo', N'Multi Selected Combobox For Selecting Months');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (7, N'checkbox', N'Checkbox Element');

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (8, N'planning-type', NULL);

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (9, N'date-range', NULL);

INSERT INTO MSG_UIElement (Id, [Name], [Description]) VALUES (10, N'multi-selected-combo-all-items-of-firm', N'Multi Selected Combobox For Showing All Items Of Firm');

SET IDENTITY_INSERT [dbo].[MSG_UIElement] OFF

-- MSG_ReportForAutoGenerating Table Data Scripts

INSERT INTO MSG_ReportForAutoGenerating ([Name], [Module], DefaultFilterJson) VALUES (N'SaleAnalysisForItemGroups', 7, N'{"CurrentUserId":null,"ForSendingWithEmail":true,"ColumnVisibleIndexes":[],"Firm":null,"Years":[],"Months":[],"Users":[],"ForAmount":false,"ItemGroups":[],"ClientCodes":null,"ItemCodes":null,"Sorting":"ItemGroupName ASC","SkipCount":0,"MaxResultCount":10}');

INSERT INTO MSG_ReportForAutoGenerating ([Name], [Module], DefaultFilterJson) VALUES (N'ReturningItems', 7, N'{"DateRange":null,"CurrentUserId":null,"ForSendingWithEmail":true,"ColumnVisibleIndexes":[],"StartDate":null,"EndDate":null,"UserIds":[],"Firm":null,"warehouses":[],"TigerIds":null,"Sorting":"ReturnAmountSum DESC","SkipCount":0,"MaxResultCount":10}');

INSERT INTO MSG_ReportForAutoGenerating ([Name], [Module], DefaultFilterJson) VALUES (N'CashPlanAnalysis', 7, N'{"{"CurrentUserId":null,"ForSendingWithEmail":true,"ColumnVisibleIndexes":[],"Firm":null,"UsersList":[],"ClientCodes":null,"Years":[],"Months":[],"Sorting":"ReturnAmountSum DESC","SkipCount":0,"MaxResultCount":10}');


-- MSG_ReportUrlMapping Table Data Scripts

DECLARE @reportId SMALLINT = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'SaleAnalysisForItemGroups');

INSERT INTO MSG_ReportUrlMapping (ReportId, [Url], HTTPRequestType, SendingType) VALUES (@reportId, N'services/app/SaleAnalysisReport/RetrieveSaleAnalysisReportExcel', 2, 1);

SET @reportId = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'ReturningItems');

INSERT INTO MSG_ReportUrlMapping (ReportId, [Url], HTTPRequestType, SendingType) VALUES (@reportId, N'services/app/ReturningItemReport/RetrieveReturningItemsReportExcel', 2, 1);

SET @reportId = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'CashPlanAnalysis');

INSERT INTO MSG_ReportUrlMapping (ReportId, [Url], HTTPRequestType, SendingType) VALUES (@reportId, N'services/app/CashPlanAnalysisReport/ExportCashPlanAnalysisReportToExcel', 2, 1);

GO

-- MSG_ReportFilter Table Data Scripts

SET IDENTITY_INSERT [dbo].[MSG_ReportFilter] ON 

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (1, N'Firm', N'Firm', 1)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (2, N'Users', N'Users', 2)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (3, N'ItemGroups', N'ItemGroups', 3)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (4, N'ItemCodes', N'Items', 4)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (5, N'ClientCodes', N'Clients', 4)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (6, N'Years', N'Year', 5)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (7, N'Months', N'Month', 6)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (8, N'ForAmount', N'ForAmountOrQuantity', 7)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (9, N'planningType', N'PlanningType', 8)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (10, N'DateRange', N'DateRange', 9)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (11, N'itemsList', N'Items', 10)

INSERT [dbo].[MSG_ReportFilter] ([Id], [FieldName], [DisplayName], [UIElement]) VALUES (12, N'warehouses', N'Warehouses', 11)

SET IDENTITY_INSERT [dbo].[MSG_ReportFilter] OFF

GO

-- MSG_ReportFilterMapping Table Data Scripts

DECLARE @reportId SMALLINT = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'SaleAnalysisForItemGroups');

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (1, @reportId, 0, 1)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (2, @reportId, 0, 2)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (3, @reportId, 0, 3)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (4, @reportId, 0, 4)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (5, @reportId, 0, 5)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (6, @reportId, 0, 6)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (7, @reportId, 0, 7)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (8, @reportId, 0, 8)


SET @reportId = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'ReturningItems');

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (1, @reportId, 0, 2)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (2, @reportId, 0, 4)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (12, @reportId, 0, 5)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (10, @reportId, 0, 1)


SET @reportId = (SELECT Id FROM MSG_ReportForAutoGenerating WHERE [Name] = 'CashPlanAnalysis');

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (1, @reportId, 0, 1)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (2, @reportId, 0, 2)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (5, @reportId, 0, 3)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (7, @reportId, 0, 4)

INSERT [dbo].[MSG_ReportFilterMapping] ([FilterId], [ReportId], [IsRequired], [LineNr]) VALUES (6, @reportId, 0, 5)

GO
