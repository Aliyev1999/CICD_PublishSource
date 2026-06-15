
ALTER TABLE MD_DocumentCountRestriction
ADD RestrictionTargetType tinyint null
GO
UPDATE MD_DocumentCountRestriction SET RestrictionTargetType = 1 where RestrictionType = 1
