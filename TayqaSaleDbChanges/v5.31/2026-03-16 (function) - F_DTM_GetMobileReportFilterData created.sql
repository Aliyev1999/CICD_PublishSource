CREATE OR ALTER FUNCTION [dbo].[F_DTM_GetMobileReportFilterData](@reportId int)
    RETURNS TABLE AS RETURN
        select FieldName,
               cast(case
                        when FieldName = 'StandardDataTimeRangeFilter' then 3
                        when FilterMask like '1%' then 1
                        when FilterMask like '2%' then 2
                        else 1 end as tinyint) as Type,
               IsCascade,
               Label
        from DTM_MobileReportFilterMask
        where ReportId = @reportId
go

