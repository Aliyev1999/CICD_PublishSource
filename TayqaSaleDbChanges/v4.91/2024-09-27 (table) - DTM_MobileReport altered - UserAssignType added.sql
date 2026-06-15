
ALTER TABLE DTM_MobileReport
ADD UserAssignType bit not null
constraint DTN_MobileReport_UserAssignType_Default default 1
with values