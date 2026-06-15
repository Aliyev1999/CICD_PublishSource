if not exists (select *
               from sys.objects
               where object_id = object_id(N'[dbo].[F_CheckIsRouteExists]')
                 and type = N'FN')
    begin
        -- If the function does not exist, create it in a new batch
        exec ('
        create function [dbo].[F_CheckIsRouteExists](@Firm smallint, @UserId int, @ClientId bigint, @Date date)
            returns bit as
        begin
            declare @IsRoute bit = 0
            if exists(select Firm from MD_Route with (nolock) where Firm = @Firm and UserId = @UserId and TigerClientId = @ClientId and Date = @Date)
                set @IsRoute = 1
            return @IsRoute
        end
    ')
    end
