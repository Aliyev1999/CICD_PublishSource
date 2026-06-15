declare  @maxId smallint = (select top(1) Id from SYS_PushMethod order by Id desc)+1;
insert into SYS_PushMethod values ('ImWarehouseTransferApproved',
                                'Inventory Warehouse Transfer Approved',
                                null,
                                null,
                                1,
                                3,
                                1,
                                null,
                                null,
                                2,
                                getdate(),
                                 @maxId)

SET  @maxId = (select top(1) Id from SYS_PushMethod order by Id desc)+1;
insert into SYS_PushMethod values ('ImWarehouseTransferInventoryOperationCompleted',
                                'Inventory Warehouse Transfer Inventory Operation Completed',
                                null,
                                null,
                                1,
                                3,
                                1,
                                null,
                                null,
                                2,
                                getdate(),
                                 @maxId)