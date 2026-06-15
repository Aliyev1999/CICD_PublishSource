create table OP_RequestQueueCommonLineSerialNumberExtension(
	Id int not null,
	ItemId int not null,
	PartNo tinyint not null,
	IsPromo bit null,
	SerialNumber nvarchar(255)null
)

create table OP_IncomingLogCommonLineSerialNumberExtension(
	Id int not null,
	ItemId int not null,
	PartNo tinyint not null,
	IsPromo bit null,
	SerialNumber nvarchar(255)null
)


create table OP_RequestQueueWarehouseOperationLineSerialNumberExtension(
	Id int not null,
	ItemId int not null,
	PartNo tinyint not null,
	IsPromo bit null,
	SerialNumber nvarchar(255)null
)

create table OP_IncomingLogWarehouseOperationLineSerialNumberExtension(
	Id int not null,
	ItemId int not null,
	PartNo tinyint not null,
	IsPromo bit null,
	SerialNumber nvarchar(255)null
)