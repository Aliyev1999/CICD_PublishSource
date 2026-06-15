ALTER FUNCTION [dbo].[F_CHL_ClientRelationStructure](
    @firm smallint,
    @year int,
    @month int,
    @surveyType int,
    @clientNameCodeOrEdino nvarchar(100),
    @saleChannel nvarchar(100),
    @salesmanCodeOrFinOrName nvarchar(100),
    @marketingManagerNameOrFin nvarchar(100),
    @marketingDeputyDirectorNameOrFin nvarchar(100),
    @marketingDirectorNameOrFin nvarchar(100),
    @saleManagerNameOrFin nvarchar(100),
    @saleDirectorDeputyNameOrFin nvarchar(100),
    @saleDeputyManagerNameOrFin nvarchar(100),
    @marketingMerchandiserNameOrFin nvarchar(100),
    @saleMerchandiserNameOrFin nvarchar(100)
    )
returns table as
    return
        (
            select CRS.Id          as Id,
                   CRS.Month       as Month,
                   CRS.Year        as Year,
                   MSR.Name        as PackageType,
                   C.Code          as ClientCode,
                   C.Name          as ClientName,
				   C.Edino		   as Edino,
                   CRS.SaleChannel as SaleChannel,
                   MS.Code         as SalesManCode,
                   MS.Name         as SalesManName,
                   MS.FinCode      as SalesManFin,
                   MS.OfficialName as SalesmanOfficialName,
                   MPM.Name        as PackageMarketingManagerName,
                   MPM.FinCode     as PackageMarketingManagerFin,
                   DMD.Name        as DeputyMarketingDirectorName,
                   DMD.FinCode     as DeputyMarketingDirectorFin,
                   MD.Name         as MarketingDirectorName,
                   MD.FinCode      as MarketingDirectorFin,
                   LM.Name         as LocationManagerName,
                   LM.FinCode      as LocationManagerFin,
                   SDeputy.Name    as SaleDeputyName,
                   SDeputy.FinCode as SaleDeputyFin,
                   SDirect.Name    as SaleDirectorName,
                   SDirect.FinCode as SaleDirectorFin,
                   MMM.Name        as MarketingMerchandiserName,
                   MMM.FinCode     as MarketingMerchandiserFin,
                   SMM.Name        as SaleMerchandiserName,
                   SMM.FinCode     as SaleMerchandiserFin,
                   MF.Name         as Firm
            from CHL_ClientRelationStructure CRS
                     left join MD_Client C on CRS.ClientId = c.TigerId and CRS.FirmNr = C.Firm
                     left join MD_Salesman MS on CRS.SalesmanId = MS.TigerId and CRS.FirmNr = MS.Firm and Ms.PositionId=1
                     left join MD_Firm MF on CRS.FirmNr = MF.Nr
                     left join MD_StopReason MSR on crs.PackageType = MSR.Id
                     left join MD_Salesman MPM on CRS.PackageMarketingManagerId = MPM.TigerId and MPM.PositionId = 6
                     left join MD_Salesman DMD on CRS.DeputyMarketingDirectorId = DMD.TigerId and DMD.PositionId = 7
                     left join MD_Salesman MD on CRS.MarketingDirectorId = MD.TigerId and MD.PositionId = 8
                     left join MD_Salesman LM on CRS.LocationManagerId = LM.TigerId and LM.PositionId = 13
                     left join MD_Salesman SDeputy on CRS.SaleDeputyId = SDeputy.TigerId and SDeputy.PositionId = 9
                     left join MD_Salesman SDirect on CRS.SaleDirectorId = SDirect.TigerId and SDirect.PositionId = 10
                     left join MD_Salesman MMM on CRS.MarketingMerchandiserId = MMM.TigerId and MMM.PositionId = 11
                     left join MD_Salesman SMM on CRS.SaleMerchandiserId = SMM.TigerId and SMM.PositionId = 12
            WHERE (@firm <= 0 or CRS.FirmNr = @firm)
              and (@year <= 0 or CRS.Year = @year)
              and (@month <= 0 or CRS.Month = @month)
              and (@clientNameCodeOrEdino IS NULL or
                   (C.Name LIKE '%' + @clientNameCodeOrEdino + '%' OR C.Code LIKE '%' + @clientNameCodeOrEdino + '%' OR C.Edino LIKE '%' + @clientNameCodeOrEdino + '%'))
          and(@surveyType <= 0 or CRS.PackageType=@surveyType)
          and(@salesmanCodeOrFinOrName is null or
              (MS.Code like '%' + @salesmanCodeOrFinOrName + '%' or MS.Name like '%' + @salesmanCodeOrFinOrName + '%' or MS.FinCode like '%'+ @salesmanCodeOrFinOrName + '%'))
          and (@saleChannel is null or CRS.SaleChannel=@saleChannel)
          and (@marketingDeputyDirectorNameOrFin is null or (DMD.Name like '%'+ @marketingDeputyDirectorNameOrFin +'%' or DMD.FinCode like '%' + @marketingDeputyDirectorNameOrFin + '%') )
          and (@marketingDirectorNameOrFin is null or (MD.Name like '%' + @marketingDirectorNameOrFin + '%' or MD.FinCode like '%' + @marketingDirectorNameOrFin + '%') )
          and (@marketingManagerNameOrFin is null or (MPM.Name like '%' + @marketingManagerNameOrFin + '%' or MPM.FinCode like '%' + @marketingManagerNameOrFin + '%'))
          and (@marketingMerchandiserNameOrFin is null or (MMM.Name like '%' + @marketingMerchandiserNameOrFin + '%' or MMM.FinCode like '%' + @marketingMerchandiserNameOrFin + '%' ))
          and (@saleMerchandiserNameOrFin is null or (SMM.Name like '%' + @saleMerchandiserNameOrFin + '%' or SMM.FinCode like '%' + @saleMerchandiserNameOrFin + '%'))
          and (@saleDirectorDeputyNameOrFin is null or (SDirect.Name like '%' + @saleDirectorDeputyNameOrFin + '%' or SDirect.FinCode like '%' + @saleDirectorDeputyNameOrFin + '%'))
          and (@saleDeputyManagerNameOrFin is null or (SDeputy.Name like '%' + @saleDeputyManagerNameOrFin + '%' or SDeputy.FinCode like '%' + @saleDirectorDeputyNameOrFin + '%'))
          and (@saleManagerNameOrFin is null or (LM.Name like '%' + @saleManagerNameOrFin + '%' or LM.FinCode like '%' + @saleManagerNameOrFin + '%'))
        )
        