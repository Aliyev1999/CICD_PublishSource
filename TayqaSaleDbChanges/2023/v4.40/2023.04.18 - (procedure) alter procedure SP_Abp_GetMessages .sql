
create or alter  proc [dbo].[SP_Abp_GetMessages] @skipCount int, @fetchCount int, @userId int as
begin
    -- target user = alan
-- user = gonderen

    with a as (select m.CreationTime, 0 as UserId,m.Message,null as UserName, m.MessageType as MessageType, ca.SecureUrl as SecureUrl
               from AppChatMessages m
               join AbpUsers u on m.TargetUserId=u.Id
			   left join AppChatAttachmets ca on ca.ReferenceId=m.Id
               where TargetUserId = @userId
                 and Side = 2
               union all
               select m.CreationTime, m.TargetUserId as UserId,Message, u.UserName, m.MessageType, ca.SecureUrl as SecureUrl
               from AppChatMessages m
               join AbpUsers u on m.TargetUserId=u.Id
			   left join AppChatAttachmets ca on ca.ReferenceId=m.Id
               where UserId = @userId
                 and Side = 2)
    select *
    from a
    order by CreationTime desc
    offset @skipCount rows fetch next @fetchCount rows only

end
GO


