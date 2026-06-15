create procedure [dbo].[SP_PN_GetSaleDistributionClientGroup] @currentUserId int,
                                                              @year smallint,
                                                              @month tinyint,
                                                              @clientGroupTypeForDistribution int,
                                                              @itemGroupTypeForDistribution int,
                                                              @itemGroupId int
as
SELECT ClientGroupId,
       ClientGroupName,
       ClientGroupCode,
       Target,
       Result
FROM F_GetSaleDistributionClientGroup(@year, @month, @clientGroupTypeForDistribution, @itemGroupTypeForDistribution, @itemGroupId, @currentUserId);