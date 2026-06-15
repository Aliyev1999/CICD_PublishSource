create table DTM_WebScreenNotification
(
    Id                     int identity primary key,
    ReferenceId            int           not null,
    Message                NVARCHAR(200) not null,
    TransitionLocationType tinyint       not null,
    TransitionLocation     nvarchar(200) not null,
    UserType               tinyint       not null,
    ActionType             tinyint       not null,
    SqlQuery               nvarchar(max),
    TenantId               int           not null,
)
go
create table DTM_WebScreenNotificationUser
(
    Id                      int identity primary key,
    WebScreenNotificationId int     not null,
    UserId                  int     not null,
    ActionType              tinyint not null
)
go
create table DTM_MobileScreenNotification
(
    Id                     int identity primary key,
    ReferenceId            int           not null,
    Message                NVARCHAR(200) not null,
    TransitionLocationType tinyint       not null,
    TransitionLocation     nvarchar(200) not null,
    UserType               tinyint       not null,
    ActionType             tinyint       not null,
    SqlQuery               nvarchar(max),
    TenantId               int           not null,
)
go
create table DTM_MobileScreenNotificationUser
(
    Id                      int identity primary key,
    WebScreenNotificationId int     not null,
    UserId                  int     not null,
    ActionType              tinyint not null
)
go
create table SYS_AppActivities
(
    Id      int identity primary key,
    [Key]   nvarchar(300) not null,
    [Value] nvarchar(100) not null,
    Type    tinyint       not null
)
GO
INSERT INTO SYS_AppActivities
VALUES ('.warehouseoperation.screens.warehouses.ui.WarehousesActivity', 'WarehouseOperations', 1),
       ('.activity.TasksActivity', 'Notifications', 1),
       ('.activity.delivery.DeliveryActivity', 'DeliveryMain', 1),
       ('.activity.dynamic_screen.DynamicScreensActivity', 'DynamicScreensMain', 1),
       ('.checklist.catalog.ui.view.DynamicSurveyCatalogActivity', 'DynamicSurveySurveys', 1),
       ('.activity.MainActivity', 'MainPage', 1),
       ('.manager.bannedclient.ui.BannedClientActivity', 'ManagementBlockedCustomers', 1),
       ('.activity.manager.UserDailyActionsActivity', 'ManagementDailyOperation', 1),
       ('.activity.manager.SubordinateUserClientsActivity', 'ManagementCustomers', 1),
       ('.routeconfirmation.ui.RouteConfirmationActivity', 'ManagementRootApproval', 1),
       ('.activity.manager.ManagementWorkPlanTasksActivity', 'ManagementTasks', 1),
       ('.inventory.ui.screens.clients.warehousereport.WarehouseReportActivity', 'InventoryEquipmentInStock', 1),
       ('.inventory.stocktaking.ui.StocktakingStatementActivity', 'InventoryEquipmentListExtract', 1),
       ('.inventory.ui.screens.operationlog.OperationLogActivity', 'InventoryMovementHistory', 1),
       ('.inventory.ui.screens.inventories.InventoryListActivity', 'InventoryInventoryList', 1),
       ('.inventory.ui.screens.clients.InventoryClientsActivity', 'InventoryCustomers', 1),
       ('.inventory.missinginventory.ui.MissingInventoryActivity', 'InventoryNotFound', 1),
       ('.inventory.requestsupply.ui.RequestSupplyActivity', 'InventoryDemandFulfillment', 1),
       ('.inventory.ui.screens.clients.fieldreport.FieldReportActivity', 'InventoryRequirements', 1),
       ('.inventory.extraconfirmation.ui.ExtraConfirmationActivity', 'InventoryRequirementsFurtherConfirmation', 1),
       ('.inventory.ui.screens.inventoryrepair.InventoryRepairActivity', 'InventoryRepair', 1),
       ('.inventory.warehouseInventoryRepair.WarehouseInventoryRepairActivity', 'InventoryRepairInWarehouse', 1),
       ('.inventory.warehouseInventoryRepair.ui.WarehouseInventoryRepairTaskActivity', 'InventoryRepairTaskInWarehouse',
        1),
       ('.inventory.ui.screens.inventoryrepair.RepairTaskActivity', 'InventoryRepairTasks', 1),
       ('.inventory.ui.screens.inventoryTransfer.InventoryTransferActivity', 'InventoryTransfer', 1),
       ('.inventory.ui.screens.inventoryWarehouseTransfer.InventoryWarehouseTransferActivity',
        'InventoryWarehouseTransfer', 1),
       ('.inventory.ui.screens.inventoryTransfer.InventoryTransferDeliveryActivity', 'InventoryTransferDelivery', 1),
       ('.activity.workplan.WorkPlanActivity', 'WorkPlan', 1),
       ('.crm.ui.screens.CrmCustomersActivity', 'CustomerRelationshipMain', 1),
       ('.activity.ProfileActivity', 'Profile', 1),
       ('.activity.RiskLimitsActivity', 'RiskLimits', 1),
       ('.activity.StatementActivity', 'Sale', 1),
       ('.internalthirdparty.presentation.activity.DocumentConfirmationActivity', 'DocumentManagementMain', 1),
       ('.activity.OrderManagerActivity', 'OrderConfirmationMain', 1),
       ('.activity.manager.CreateQuickTaskActivity', 'CreateQuickTask', 1),
       ('.activity.helper.SettingsActivity', 'Settings', 1),
       ('.activity.VisitActivity', 'Visit', 1),
       ('salesmanDebt', 'SalesmanDebt', 2),
       ('userDebt', 'UserDebt', 2),
       ('saleActions', 'SaleActions', 2),
       ('itemStockWarehouses', 'ItemStockWarehouses', 2),
       ('itemList', 'ItemList', 2),
       ('itemPrice', 'ItemPrice', 2),
       ('dailySales', 'DailySales', 2),
       ('orderStatus', 'OrderStatus', 2),
       ('actionOrderItemDelivery', 'ActionOrderItemDelivery', 2),
       ('actionPlanFactReports', 'ActionPlanFactReports', 2),
       ('salesmanFinalizedItemCirculation', 'SalesmanFinalizedItemCirculation', 2),
       ('itemProfitReport', 'ItemProfitReport', 2),
       ('actionSaleDistributionItemGroup', 'ActionSaleDistributionItemGroup', 2),
       ('warehouseStockDemandWarehouses', 'WarehouseStockDemandWarehouses', 2),
       ('actionCashCardReport', 'ActionCashCardReport', 2),
       ('actionRouteStatistics', 'ActionRouteStatistics', 2),
       ('actionReportUsersAudit', 'ActionReportUsersAudit', 2),
       ('unpaidBill', 'UnpaidBill', 2),
       ('warehouseInOutWarehouses', 'WarehouseInOutWarehouses', 2),
       ('actionPhotoGallery', 'ActionPhotoGallery', 2),
       ('specialReportsAction', 'SpecialReportsAction', 2);
GO
DECLARE @maxId INT = (SELECT MAX(Id)
                      FROM SYS_PushMethod)

INSERT INTO SYS_PushMethod ([Name],
                            [Description],
                            DataTypeId,
                            PushTypeId,
                            [Status],
                            CreatedUserId,
                            CreatedDate,
                            Id)
VALUES ('DynamicNotification',
        'Dynamic notification',
        1,
        3,
        1,
        2,
        GETDATE(),
        @maxId + 1);