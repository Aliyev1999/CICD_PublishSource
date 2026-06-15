
create function [dbo].[F_DTM_GetSubQueryCardItems] (@subQueryId int, @toolType tinyint)  
    returns table  
        as  
        return  
            (  
			  SELECT   COALESCE(m.ColorStyle, mr.ColorStyle) ColorStyle,  
                       COALESCE(m.ColorHex,mr.ColorHex) ColorHex,  
                       COALESCE(m.FontSize,mr.FontSize)   FontSize,
                       COALESCE(m.FontStyle,  mr.FontStyle) FontStyle,
                       COALESCE(m.ItemKey,  mr.ItemKey) ItemKey,
                       COALESCE(m.Label, mr.Label) Label, 
                       COALESCE(m.PositionHorizontal,  mr.PositionHorizontal) PositionHorizontal,
                       COALESCE(m.PositionVertical,  mr.PositionVertical) PositionVertical,
                       COALESCE( m.ShowLabel,  mr.ShowLabel) ShowLabel,
                       COALESCE( m.AggregationType,  mr.AggregationType) AggregationType,
                       t.system_type_name AS DataType,  
                       null               AS Condition,  
                       null               AS ConditionalFontColorHex  
                FROM DTM_SubQuery sq WITH (NOLOCK)  
                         left JOIN DTM_MobileScreenCardProperty m with (nolock) on sq.Id = m.SubQueryId  and @toolType=4
                         left JOIN DTM_MobileReportCardProperty mr with (nolock) on sq.Id = mr.SubQueryId  and @toolType=1
                         left JOIN DTM_MobileScreenIcon icon with (nolock)  
                                   on sq.IconId = icon.Id and ToolType = @toolType  
                         CROSS APPLY (SELECT t.system_type_name  
                                      FROM sys.dm_exec_describe_first_result_set(  
                                                   sq.SqlQuery COLLATE SQL_Latin1_General_CP1_CI_AS,  
                                                   NULL,  
                                                   0  
                                               ) AS t  
                                      WHERE t.name COLLATE SQL_Latin1_General_CP1_CI_AS =  
                                            COALESCE(m.ItemKey,mr.ItemKey) COLLATE SQL_Latin1_General_CP1_CI_AS) t  
                WHERE sq.Id = @subQueryId   
            )


go



create function [dbo].[F_DTM_GetMobileScreenSubQueryCardItems] (@mobileScreenId int)
    returns table
        as
        return
            (
                SELECT null            AS ColorStyle,
                       null            AS ColorHex,
                       null            AS FontSize,
                       null            AS FontStyle,
                       null            AS ItemKey,
                       null            AS Label,
                       null            AS PositionHorizontal,
                       null            AS PositionVertical,
                       null            AS ShowLabel,
                       null            AS AggregationType,
                       null            AS Condition,
                       null            AS ConditionalFontColorHex,
                       null            AS DataType,
                       sq.Id           AS SubqueryId,
                       icon.Url        As Icon,
                       sq.DisplayLabel As DisplayLabel,
                       sq.QueryType    As QueryType
                FROM DTM_SubQuery sq WITH (NOLOCK)
                         left JOIN DTM_MobileScreenIcon icon with (nolock) on sq.IconId = icon.Id and ToolType = 4
                         left JOIN DTM_MobileScreenCardProperty m with (nolock) on sq.Id = m.SubQueryId
                WHERE sq.ParentId = @mobileScreenId
                  and sq.ToolType = 4
                  and m.Id is null

                union

                SELECT m.ColorStyle,
                       m.ColorHex,
                       m.FontSize,
                       m.FontStyle,
                       m.ItemKey,
                       m.Label,
                       m.PositionHorizontal,
                       m.PositionVertical,
                       m.ShowLabel,
                       m.AggregationType,
                       c.Formula          AS Condition,
                       c.FontColor        AS ConditionalFontColorHex,
                       t.system_type_name AS DataType,
                       sq.Id              AS SubqueryId,
                       icon.Url           As Icon,
                       sq.DisplayLabel    As DisplayLabel,
                       sq.QueryType       As QueryType
                FROM DTM_SubQuery sq WITH (NOLOCK)
                         left JOIN DTM_MobileScreenCardProperty m with (nolock) on sq.Id = m.SubQueryId
                         left JOIN DTM_MobileScreenConditionalFormatting c
                                   ON m.ItemKey = c.FieldName COLLATE SQL_Latin1_General_CP1_CI_AS AND
                                      c.MobileScreenId = m.MobileScreenId
                         left JOIN DTM_MobileScreenIcon icon with (nolock) on sq.IconId = icon.Id and ToolType = 4
                         CROSS APPLY (SELECT t.system_type_name
                                      FROM sys.dm_exec_describe_first_result_set(
                                                   sq.SqlQuery COLLATE SQL_Latin1_General_CP1_CI_AS,
                                                   NULL,
                                                   0
                                               ) AS t
                                      WHERE t.name COLLATE SQL_Latin1_General_CP1_CI_AS =
                                            m.ItemKey COLLATE SQL_Latin1_General_CP1_CI_AS) t
                WHERE sq.ParentId = @mobileScreenId
                  and sq.ToolType = 4
            )

go



create function [dbo].[F_DTM_GetMobileScreenCardItems](@mobileScreenId int)
    returns table
        as
        return
            (
                SELECT m.ColorStyle,
                       m.ColorHex,
                       m.FontSize,
                       m.FontStyle,
                       m.ItemKey,
                       m.Label,
                       m.PositionHorizontal,
                       m.PositionVertical,
                       m.ShowLabel,
                       m.AggregationType,
                       c.Formula          AS Condition,
                       c.FontColor        AS ConditionalFontColorHex,
                       t.system_type_name AS DataType
                FROM DTM_MobileScreenCardProperty m WITH (NOLOCK)
                         LEFT JOIN DTM_MobileScreenConditionalFormatting c
                                   ON m.ItemKey = c.FieldName COLLATE SQL_Latin1_General_CP1_CI_AS AND
                                      c.MobileScreenId = m.MobileScreenId
                         CROSS APPLY (SELECT t.system_type_name
                                      FROM sys.dm_exec_describe_first_result_set(
                                                   (SELECT s.SqlQuery
                                                    FROM DTM_MobileScreen s
                                                    WHERE s.Id = @mobileScreenId) COLLATE SQL_Latin1_General_CP1_CI_AS,
                                                   NULL,
                                                   0
                                               ) AS t
                                      WHERE t.name COLLATE SQL_Latin1_General_CP1_CI_AS =
                                            m.ItemKey COLLATE SQL_Latin1_General_CP1_CI_AS) t

                WHERE m.MobileScreenId = @mobileScreenId
            )