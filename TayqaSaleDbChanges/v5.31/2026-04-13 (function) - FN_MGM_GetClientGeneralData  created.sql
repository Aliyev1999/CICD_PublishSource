
CREATE OR ALTER function [dbo].[FN_MGM_GetClientGeneralData] (@Firm     smallint,
                                                              @ClientId bigint
                                                             )
returns table as return
(
    select
        Client.Taxno                 as TaxId,
        Client.IdentityNo            as IdentityNo,
        Client.SpecialCode           as SpeCode1,
        Client.SpecialCodeDesc       as Specode1Desc,
        Client.SpecialCode2          as SpeCode2,
        Client.SpecialCode2Desc      as Specode2Desc,
        Client.SpecialCode3          as SpeCode3,
        Client.SpecialCode3Desc      as Specode3Desc,
        Client.SpecialCode4          as SpeCode4,
        Client.SpecialCode4Desc      as Specode4Desc,
        Client.SpecialCode5          as SpeCode5,
        Client.SpecialCode5Desc      as Specode5Desc,
        Client.AuthorizationCode     as AuthCode,
        Client.AuthorizationCodeDesc as AuthCodeDesc,
        Client.TradingGroupCode      as TradeGroup,
        Client.Name2                 as Name2,
        Client.Address               as Address,
        Client.AddressExtension      as AddressExtension,
        Client.City                  as City,
        Client.Town                  as Region,
        Client.InCharge              as PersonInCharge,
        Client.Telephone             as PhoneNumber
    from MD_Client Client with (nolock)
    where Client.Firm     = @Firm
      and Client.TigerId  = @ClientId
      and Client.IsDeleted = 0
);


