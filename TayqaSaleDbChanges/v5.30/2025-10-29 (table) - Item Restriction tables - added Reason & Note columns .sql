ALTER TABLE MD_ClientItemRestriction
ADD RestrictionReasonId INT NULL;

ALTER TABLE MD_ClientItemRestriction
ADD Note NVARCHAR(max) NULL;

ALTER TABLE MD_ClientGroupItemRestriction
ADD RestrictionReasonId INT NULL;


ALTER TABLE MD_ClientGroupItemRestriction
ADD Note NVARCHAR(max) NULL;


ALTER TABLE MD_ItemRestriction
ADD RestrictionReasonId INT NULL;


ALTER TABLE MD_ItemRestriction
ADD Note NVARCHAR(max) NULL;