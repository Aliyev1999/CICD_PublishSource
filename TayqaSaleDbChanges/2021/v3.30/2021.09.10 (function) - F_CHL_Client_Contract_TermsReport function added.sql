create FUNCTION [dbo].[F_CHL_ClientContractTermsReport](@clientId int, @beginDate date, @endDate date)
    Returns Table
        AS
        RETURN
            (
                with cte as (select Normative.Id         as NormativeId,
                                    Normative.Code       as NormativeCode,
                                    Normative.Name       as NormativeName,
                                    Normative.StartDate  as BeginDate,
                                    Normative.EndDate    as EndDate,
                                    ClientNormative.Text as NormativeText,
                                    1                    as x
                             from CHL_Normative Normative
                                      left join CHL_NormativeForClient ClientNormative
                                                on Normative.Id = ClientNormative.NormativeId
                             where ClientNormative.ClientId = @clientId
                               and ((Normative.StartDate >= @beginDate and Normative.StartDate <= @endDate)
                                 or (Normative.EndDate <= @endDate and Normative.EndDate >= @beginDate))
                               and Normative.Status = 0
                               and ClientNormative.Status = 0
                               and Normative.Type = 1
                             union
                             select Normative.Id        as NormativeId,
                                    Normative.Code      as NormativeCode,
                                    Normative.Name      as NormativeName,
                                    Normative.StartDate as BeginDate,
                                    Normative.EndDate   as EndDate,
                                    GroupNormative.Text as NormativeText,
                                    2                   as x
                             from CHL_Normative Normative
                                      left join CHL_NormativeForClientGroup GroupNormative
                                                on Normative.Id = GroupNormative.NormativeId
                                      left join MD_ClientGroupData GroupData
                                                on GroupData.GroupId = GroupNormative.GroupId and
                                                   GroupData.Firm = Normative.Firm
                             where GroupData.ClientId = @clientId
                               and ((Normative.StartDate >= @beginDate and Normative.StartDate <= @endDate)
                                 or (Normative.EndDate <= @endDate and Normative.EndDate >= @beginDate))
                               and Normative.Status = 0
                               and Normative.Type = 1
                               and GroupNormative.Status = 0)
                select distinct NormativeId,
                                NormativeCode,
                                NormativeName,
                                BeginDate,
                                EndDate,
                                FIRST_VALUE(NormativeText) over (
                                    partition by NormativeId
                                    order by case x when 1 then 0 else 1 end range between unbounded preceding and unbounded following) as NormativeText
                from cte
            )