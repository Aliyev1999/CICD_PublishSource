
/****** Object:  StoredProcedure [dbo].[SP_RP_DynamicAggregationForMap]    Script Date: 12/15/2022 5:19:16 PM ******/

CREATE OR ALTER procedure [dbo].[SP_RP_DynamicAggregationForMap] @Query nvarchar(max), @LatitudeField nvarchar(500), @LongitudeField nvarchar(500),
                                                     @ValueField nvarchar(500), @AggregateType nvarchar(100),
                                                     @DisplayLabelField nvarchar(500), @Search nvarchar(500)
as
begin

    declare @SQL nvarchar(max) = concat('select ' ,
	
	@DisplayLabelField, ' as DisplayLabel,', @LatitudeField, ' as Latitude,', @LongitudeField, ' as Longitude from (', @Query, ') T ')
	
	--concat(', @LatitudeField, ',', ''', '',', @LongitudeField, ') as Coordinate',
 --                                       ' from (', @Query, ') T ')

    if @Search is not null set @SQL = concat(@SQL, ' where ', @DisplayLabelField, ' like ''%', @Search, '%''')

    set @SQL =
            concat(@SQL, ' group by ', @DisplayLabelField, ', ',  @LatitudeField, ', ', @LongitudeField)

    --print @SQL

    exec sp_executesql @SQL, N'@Query nvarchar(max), @LatitudeField nvarchar(500), @LongitudeField nvarchar(500),
                                                    @ValueField nvarchar(500), @AggregateType nvarchar(100),
                                                    @DisplayLabelField nvarchar(500), @Search nvarchar(500)',
         @Query = @Query,
         @LatitudeField = @LatitudeField,
         @LongitudeField = @LongitudeField,
         @ValueField = @ValueField,
         @AggregateType = @AggregateType,
         @Search = @Search,
         @DisplayLabelField = @DisplayLabelField

end
