CREATE DATABASE SCOPED CREDENTIAL sqlmsi  WITH IDENTITY = 'Managed Service Identity'

CREATE EXTERNAL DATA SOURCE AzureDataLakeStore
WITH
  ( LOCATION = 'abfss://piawareadlssynapse.azuredatalakestore.net' ,
    CREDENTIAL = sqlmsi ,
    TYPE = HADOOP
  ) ;

DROP   EXTERNAL FILE FORMAT [HiveFileFormat_01] 

CREATE EXTERNAL FILE FORMAT [HiveFileFormat_01] 
WITH (
FORMAT_TYPE = DELIMITEDTEXT,
FORMAT_OPTIONS 
   (
	FIELD_TERMINATOR = '0x01', 
	FIRST_ROW=1,
	USE_TYPE_DEFAULT = False)
	)


CREATE EXTERNAL TABLE [dbo].[zzextDimProductSubcategory]
(
	[ProductSubcategoryKey] [int] ,
	[ProductSubcategoryAlternateKey] [int] ,
	[EnglishProductSubcategoryName] [nvarchar](50) ,
	[SpanishProductSubcategoryName] [nvarchar](50) ,
	[FrenchProductSubcategoryName] [nvarchar](50) ,
	[ProductCategoryKey] [int] 
)
WITH (DATA_SOURCE = AzureDataLakeStore,LOCATION = N'/primarycontainer/bcp/DimProductSubcategory.txt',FILE_FORMAT = [HiveFileFormat_01],REJECT_TYPE = VALUE,REJECT_VALUE = 0)
GO
