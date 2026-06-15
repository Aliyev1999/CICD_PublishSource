
update UIM_Permission  set ObjectName='Inventory.Transfer.CreateEdit.ShouldTakePhoto' where ObjectName='Inventory.Transfer.ShouldTakePhoto'

update UIM_Permission  set ObjectName='Inventory.Transfer.CreateEdit.Warehouse' where ObjectName='Inventory.Transfer.Warehouse'

update UIM_Permission  set ObjectName='Inventory.Transfer.CreateEdit.Warehouse.Select' where ObjectName='Inventory.Transfer.Warehouse.Select'

update UIM_Permission  set ObjectName='Inventory.Transfer.CreateEdit.Division' where ObjectName='Inventory.Transfer.Division'

update UIM_Permission  set ObjectName='Inventory.Transfer.CreateEdit.Division.Select' where ObjectName='Inventory.Transfer.Division.Select'

update UIM_Permission  set ObjectName='Inventory.Transfer.Carrying' where ObjectName='Inventory.Transfer.Menu.Carrying'

update UIM_Permission  set ObjectName='Inventory.Transfer.Confirmation' where ObjectName='Inventory.Transfer.Menu.Confirmation'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer.CreateEdit') where ObjectName='Inventory.Transfer.CreateEdit.AllowManualInventorySelection'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer.CreateEdit') where ObjectName='Inventory.Transfer.CreateEdit.Division'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer.CreateEdit') where ObjectName='Inventory.Transfer.CreateEdit.ShouldTakePhoto'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer.CreateEdit') where ObjectName='Inventory.Transfer.CreateEdit.Warehouse'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer.CreateEdit') where ObjectName='Inventory.Transfer.CreateEdit.Warehouse'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer') where ObjectName='Inventory.Transfer.Carrying'

update UIM_Permission set ParentId= (select Id from UIM_Permission where ObjectName='Inventory.Transfer') where ObjectName='Inventory.Transfer.Confirmation'

delete from UIM_Permission where ObjectName='Inventory.Transfer.Menu'

delete from UIM_Permission where ObjectName='Inventory.Transfer.Menu.Request'




