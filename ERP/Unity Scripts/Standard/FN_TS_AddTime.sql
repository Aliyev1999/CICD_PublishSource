create Function [dbo].[FN_TS_AddTime](@date datetime, @time int)
RETURNS datetime
AS 
BEGIN
declare @hour int = (@time - (@time % 65536)) / 65536 / 256;
declare @minute int = ((@time - (@time % 65536)) / 65536 - ((@time - (@time % 65536)) / 65536 / 256) * 256);
declare @second int =(((@time % 65536) - ((@time % 65536) % 256)) / 256);
RETURN (DateAdd(hour, @hour, DateAdd(minute, @minute, DateAdd(second, @second, @date))))
END

GO
