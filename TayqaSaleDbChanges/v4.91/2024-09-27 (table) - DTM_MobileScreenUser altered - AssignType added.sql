
ALTER TABLE DTM_MobileScreen
ADD UserAssignType bit not null
constraint DTM_MobileScreen_UserAssignType_Default default 1
with values