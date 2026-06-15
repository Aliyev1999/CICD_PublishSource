ALTER FUNCTION [dbo].[FN_CalculateDistance]
    (
        @SourceLatitude float null,
        @SourceLongitude float null,
        @DestinationLatitude float null,
        @DestinationLongitude float null
    )
    RETURNS float
    AS
    BEGIN
        RETURN (CASE
                    WHEN @SourceLatitude is null or @SourceLongitude is null or @DestinationLatitude is null or @DestinationLongitude is null or
                         @SourceLatitude = 0 or @SourceLongitude = 0 or @DestinationLatitude = 0 or @DestinationLongitude = 0 THEN -1
                    WHEN (@SourceLatitude = @DestinationLatitude AND @SourceLongitude = @DestinationLongitude)
                        THEN 0
                    ELSE ACOS(SIN(PI() * @SourceLatitude / 180.0) * SIN(PI() * @DestinationLatitude / 180.0) +
                              COS(PI() * @SourceLatitude / 180.0) * COS(PI() * @DestinationLatitude / 180.0) *
                              COS(PI() * @DestinationLongitude / 180.0 - PI() * @SourceLongitude / 180.0)) * 6371
                END);
    END
    GO
    