SELECT 
    r.filename() as FileName,
    r.filepath() as FilePath,
    *
FROM 
    OPENROWSET
    (
        BULK 'https://piawareadlssynapse.dfs.core.windows.net/primarycontainer/bcp/DimProductSubcategory.txt',
        FORMAT='CSV',
        FIRSTROW=1,
        FIELDTERMINATOR ='0x01', 
        ROWTERMINATOR = '\n'
    ) 
    WITH 
    (
	[ProductSubcategoryKey] [int] ,
	[ProductSubcategoryAlternateKey] [int] ,
	[EnglishProductSubcategoryName] [nvarchar](50) ,
	[SpanishProductSubcategoryName] [nvarchar](50) ,
	[FrenchProductSubcategoryName] [nvarchar](50) ,
	[ProductCategoryKey] [int] 
    ) r
