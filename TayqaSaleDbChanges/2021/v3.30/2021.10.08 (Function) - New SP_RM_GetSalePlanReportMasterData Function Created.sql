/****** Object:  UserDefinedFunction [dbo].[F_RM_ItemGroupPlans]    Script Date: 10/8/2021 3:21:14 PM ******/
create FUNCTION [dbo].[F_RM_ItemGroupPlans](@firm SMALLINT= NULL,
                                                                @users NVARCHAR(MAX) = NULL,
                                                                 @itemGroups NVARCHAR(MAX) = NULL,
                                                                 @years NVARCHAR(MAX) = NULL,
                                                                 @months NVARCHAR(MAX) = NULL,
                                                                 @currwntUser SMALLINT =NULL,
                                                                 @planType SMALLINT= NULL)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT
                itemGroup.Id AS GroupId,
                itemGroup.Name AS GroupName,
                SUM(CASE @planType
                when 1 then itemGroupPlanForUser.Quantity
                when 2 then itemGroupPlanForUser.Amount
                end) [Plan]
                FROM MD_ItemGroup itemGroup
                JOIN MD_ItemGroupPlanForUser itemGroupPlanForUser ON itemGroupPlanForUser.ItemGroupId = itemGroup.Id 
                JOIN F_GetPermittedUsers(@currwntUser) permittedUser ON itemGroupPlanForUser.UserId = permittedUser.UserId
                WHERE (@firm IS NULL OR Firm=@firm)
                AND (@users IS NULL OR itemGroupPlanForUser.UserId IN (SELECT [Value] FROM F_SplitList(@users, ', ')))
                AND (@itemGroups IS NULL OR itemGroup.Id IN (SELECT [Value] FROM F_SplitList(@itemGroups, ', ')))
                AND (@years IS NULL OR itemGroupPlanForUser.[Year] IN (SELECT [Value] FROM F_SplitList(@years, ', ')))
                AND (@months IS NULL OR itemGroupPlanForUser.[Month] IN (SELECT [Value] FROM F_SplitList(@months, ', ')))
                GROUP BY itemGroup.Id, itemGroup.Name
            )
