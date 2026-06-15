create procedure [dbo].[SP_PN_GetSaleDistributionItemGroup] @currentUserId int,
                                                            @year smallint,
                                                            @month tinyint,
                                                            @clientGroupTypeForDistribution int,
                                                            @itemGroupTypeForDistribution int
as
SELECT SpecialCode,
       SpecialCode2,
       SpecialCode3,
       ItemGroupId,
       ItemGroupName,
       ItemGroupCode,
       Target,
       Result
FROM F_GetSaleDistributionItemGroup(@year, @month, @clientGroupTypeForDistribution, @itemGroupTypeForDistribution, @currentUserId);
 