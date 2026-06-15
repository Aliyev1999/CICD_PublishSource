
CREATE function [dbo].[F_RM_RISK_LIMIT_GET_SPECODE](@clientId int, @Firm smallint, @UserId int)
    Returns table
        As
        return
            (
                select Distinct Salesman.Code as SpecialCode4
                from MD_Client Client
                         join MD_SalesmanClientMapping SalesmanClient
                              on SalesmanClient.ClientId = Client.TigerId and SalesmanClient.Firm = Client.Firm
                         join UIM_UserEmployeeMapping UserEmployee
                              on UserEmployee.EmployeeId = SalesmanClient.SalesmanId and
                                 UserEmployee.Firm = SalesmanClient.Firm
                         join MD_Salesman Salesman
                              on Salesman.Firm = SalesmanClient.Firm and Salesman.TigerId = UserEmployee.EmployeeId
                where Client.TigerId = @clientId
                  and Client.Firm = @Firm
                  and UserEmployee.UserId = @UserId
            )




