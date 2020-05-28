CREATE TABLE [dbo].[zzDimProductSubcategory]
(
	[ProductSubcategoryKey] [int] NULL,
	[ProductSubcategoryAlternateKey] [int] NULL,
	[EnglishProductSubcategoryName] [nvarchar](50) NULL,
	[SpanishProductSubcategoryName] [nvarchar](50) NULL,
	[FrenchProductSubcategoryName] [nvarchar](50) NULL,
	[ProductCategoryKey] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

COPY INTO [dbo].[zzDimProductSubcategory]
FROM 'https://piawareadlssynapse.dfs.core.windows.net/primarycontainer/bcp/DimProductSubcategory.txt'
WITH (
    FILE_TYPE = 'CSV',
    CREDENTIAL=(IDENTITY= 'Storage Account Key', SECRET=''),
    FIELDQUOTE = '"',
    FIELDTERMINATOR='0x01',
    ROWTERMINATOR='\n',
    ENCODING = 'UTF8',
    DATEFORMAT = 'ymd',
	MAXERRORS = 0,
	FIRSTROW = 1
)

SELECT * FROM [dbo].[zzDimProductSubcategory]
