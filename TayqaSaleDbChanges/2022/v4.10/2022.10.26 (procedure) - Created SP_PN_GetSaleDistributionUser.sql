CREATE   procedure [dbo].[SP_PN_GetSaleDistributionUser] 
@currentUserId int,
@year smallint,
@month tinyint,
@clientGroupTypeForDistribution int,
@itemGroupTypeForDistribution int
AS
SELECT UserId, 
       UserName, 
       UserFullName, 
       Target, 
       Result
  FROM F_GetSaleDistributionUser(@year, @month, @currentUserId, @clientGroupTypeForDistribution, @itemGroupTypeForDistribution)
GO


