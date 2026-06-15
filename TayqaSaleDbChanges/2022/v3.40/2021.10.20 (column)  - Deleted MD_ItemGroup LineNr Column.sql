BEGIN TRAN ItemGroupTransaction

INSERT INTO MD_ItemGroupPlanExtension (ItemGroupId, LineNr)
SELECT Id, LineNr FROM MD_ItemGroup

ALTER TABLE MD_ItemGroup
DROP COLUMN LineNr

COMMIT TRANSACTION ItemGroupTransaction