create or alter function [dbo].[F_MGM_GetUserUnReadNotificationList] (@userId bigint)
    returns table
        as
        return(select notification.Id,
                      notification.Name         as Header,
                      notification.Content      as Description,
                      notification.CreationTime as DateTime,
                      notification.Type,
                      @userId                   as RelatedUser,
                      isnull(client.Name, '')   as RelatedClient,
                      client.TigerId            as ClientId,
                      case
                          when notificationClient.ClientId is null then
                              case when userReadLog.UserId is null then 0 else 1 end
                          when clientReadLog.ClientId is null then 0
                          else 1
                          end                   as IsRead
               from MSG_Notification notification
                        join MSG_NotificationUser notificationUser
                             on notification.Id = notificationUser.NotificationId
                        left join MSG_NotificationClient notificationClient
                                  on notification.Id = notificationClient.NotificationId
                        left join MD_Client client
                                  on client.TigerId = notificationClient.ClientId
                                      and client.Firm = notification.Firm
                        left join MSG_NotificationUserReadLog userReadLog
                                  on notificationUser.UserId = userReadLog.UserId
                                      and notificationUser.NotificationId = userReadLog.NotificationId
                        left join MSG_NotificationClientReadLog clientReadLog
                                  on notificationUser.UserId = clientReadLog.UserId
                                      and notificationClient.ClientId = clientReadLog.ClientId
                                      and notificationClient.NotificationId = clientReadLog.NotificationId
                        left join MSG_NotificationClientDeleteLog clientDeleteLog
                                  on notificationUser.UserId = clientDeleteLog.UserId
                                      and notificationClient.ClientId = clientDeleteLog.ClientId
                                      and notification.Id = clientDeleteLog.NotificationId
               where notificationUser.UserId = @userId
                 and notificationUser.IsActive = 1
                 and notification.IsActive = 1
                 and notification.StartDate <= getdate()
                 and clientDeleteLog.Id is null
                 and (notificationClient.Id is null or notificationClient.IsActive = 1)
                 and (
                   (notificationClient.ClientId is null and userReadLog.UserId is null)
                       or (notificationClient.ClientId is not null and clientReadLog.ClientId is null)
                   ));
