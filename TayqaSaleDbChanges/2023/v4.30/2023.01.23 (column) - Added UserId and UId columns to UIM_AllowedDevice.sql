DELETE UIM_AllowedDevice;

DROP INDEX IX_AllowedDevice_Imei ON UIM_AllowedDevice;

GO

ALTER TABLE UIM_AllowedDevice
DROP COLUMN Imei;

GO

ALTER TABLE UIM_AllowedDevice
ADD 
UserId bigint not null,
[UID] nvarchar(50) not null;
