CREATE OR ALTER FUNCTION [dbo].[F_GetClientsForWebOrder](
    @userId BIGINT,
    @firm SMALLINT,
    @clientCodeOrNameOrPhone NVARCHAR(200)
    )
    RETURNS @Clients TABLE
                     (
                         Id       INT,
                         Code     NVARCHAR(50),
                         Name     NVARCHAR(100),
                         Phone    NVARCHAR(20),
                         Address  NVARCHAR(200),
                         Note     NVARCHAR(500),
                         Location NVARCHAR(100)
                     )
    AS
    BEGIN
        -- Insert query result into the @Clients table with filter applied
        INSERT INTO @Clients (Id, Code, Name, Phone, Address, Note, Location)
        SELECT TigerId    AS Id,
               Code,
               Name,
               Telephone  AS Phone,
               Address,
               'Note'     AS Note,
               'Location' AS Location
        FROM F_GetAllPermittedUsersPermittedClients(@userId) AS PermittedClient
                 JOIN MD_Client AS Client ON Client.TigerId = PermittedClient.ClientId AND Client.Firm = PermittedClient.Firm
        WHERE Client.Firm = @firm
          AND Client.Status = 0
          AND (
            @clientCodeOrNameOrPhone IS NULL OR
            Client.Code LIKE '%' + @clientCodeOrNameOrPhone + '%' OR
            Client.Name LIKE '%' + @clientCodeOrNameOrPhone + '%' OR
            Client.Telephone LIKE '%' + @clientCodeOrNameOrPhone + '%'
            );

        RETURN;
    END