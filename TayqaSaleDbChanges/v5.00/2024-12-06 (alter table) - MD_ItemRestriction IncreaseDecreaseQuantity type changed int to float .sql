declare @ConstraintName nvarchar(100) = (select top 1 Constraints.name
                                         from sys.default_constraints Constraints
                                                  inner join sys.columns Columns on Constraints.parent_object_id = Columns.object_id
                                                  inner join sys.tables Tables on Constraints.parent_object_id = Tables.object_id
                                         where Tables.name = 'MD_ItemRestriction'
                                           and Columns.name = 'IncreaseDecreaseQuantity'
                                           and Columns.column_id = Constraints.parent_column_id)

exec('ALTER TABLE MD_ItemRestriction DROP CONSTRAINT ' + @ConstraintName)
go
ALTER TABLE MD_ItemRestriction
ALTER COLUMN IncreaseDecreaseQuantity float;
go
ALTER TABLE MD_ItemRestriction
ADD CONSTRAINT DF__MD_ItemRestriction__IncreaseDecreaseQuantity__DefaultZero DEFAULT 0 FOR IncreaseDecreaseQuantity;