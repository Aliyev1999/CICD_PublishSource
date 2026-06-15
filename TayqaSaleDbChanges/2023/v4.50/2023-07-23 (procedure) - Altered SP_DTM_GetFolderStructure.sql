Alter PROCEDURE [dbo].[SP_DTM_GetFolderStructure] @nameOrCode nvarchar(50) = null,
                                                   @moduleId smallint = null,
                                                   @type nvarchar(50) = null,
												   @toolType tinyint=null,
                                                   @skip int = null,
                                                   @take int = null,
                                                   @sort nvarchar(50) = null
												   
AS
BEGIN  

    declare @Query nvarchar(max)
    set @Query = '
                    
                   with CountData as (
				   
									   select SubFolder as Id, COUNT(Report.Id) as ScreenCount
                                       from SYS_FolderStructure Structure
                                                join SYS_SpecialReport Report on Report.SubFolder = Structure.Id
                                       group by SubFolder

                                       union

                                       select Folder as Id, COUNT(Report.Id) as ScreenCount
                                       from SYS_FolderStructure Structure
                                                join SYS_SpecialReport Report on Report.Folder = Structure.Id
                                       group by Folder

                                       union

                                       select SubFolder as Id, COUNT(Report.Id) as ScreenCount
                                       from SYS_FolderStructure Structure
                                                join DTM_WebScreen Report on Report.SubFolder = Structure.Id
                                       group by SubFolder

                                       union

                                       select Folder as Id, COUNT(Report.Id) as ScreenCount
                                       from SYS_FolderStructure Structure
                                                join DTM_WebScreen Report on Report.Folder = Structure.Id
                                       group by Folder


                                       )
                    select FolderStructure.Id                                               as Id,
                           Module.Name                                                      as ModuleName,
                           FolderStructure.Code                                             as Code,
                           FolderStructure.Name                                             as Name,
                           iif(ParentStructure.Id is not null, ''SubFolder'', ''ParentFolder'') as Type,
                           isnull(CountData.ScreenCount, 0)                                 as ScreenCount,
                           count(FolderStructure.Id) over()                                as TotalCount
                    from SYS_FolderStructure FolderStructure with (nolock)
                             join SYS_Module Module with (nolock) on FolderStructure.ModuleId = Module.Id
                             left join SYS_FolderStructure ParentStructure with (nolock) on FolderStructure.ParentId = ParentStructure.Id
                             left join CountData with (nolock) on CountData.Id = FolderStructure.Id
                    where 1 = 1
                      and FolderStructure.IsDeleted = 0'

    if @nameOrCode is not null
        set @Query = concat(@Query, ' and (FolderStructure.Code like ''%''+@nameOrCode+''%'' or FolderStructure.Name like ''%''+@nameOrCode+''%'')')
    if @moduleId is not null set @Query = concat(@Query, ' and (Module.Id = @moduleId)')
    if @type is not null set @Query = concat(@Query, ' and (iif(ParentStructure.Id is not null, ''SubFolder'', ''ParentFolder'') = @type)')
	if @tooltype is not null set @Query=concat(@Query,' and (@toolType=FolderStructure.Type)')
    if @sort is not null set @Query = concat(@Query, 'order by ' + @sort + '  offset @skip rows fetch next @take rows only')

    exec sp_executesql @Query, N'
                                    @nameOrCode nvarchar(50) = null,
                                    @moduleId smallint = null,
                                    @type nvarchar(50) = null,
                                    @skip int = null,
                                    @take int = null,
                                    @sort nvarchar(50) = null,
									@toolType tinyint=null',
         @nameOrCode = @nameOrCode,
         @moduleId = @moduleId,
         @type = @type,
         @skip = @skip,
         @take = @take,
         @sort = @sort,
		 @toolType=@toolType
END

go