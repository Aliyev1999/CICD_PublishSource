create or alter Function FN_TS_ConvertToDateTime(@date datetime, @hour smallint, @min smallint, @sec smallint)
RETURNS datetime
AS 
BEGIN
RETURN (select DATEADD(DAY,DATEDIFF(DAY, 0, @date),CAST(CONCAT(@hour,':', @min,':',@sec) AS DATETIME)))
END