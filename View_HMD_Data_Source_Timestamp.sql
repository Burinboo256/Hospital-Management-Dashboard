USE [SiIMC_MGHT]
GO

/****** Object:  View [da].[View_HMD_Data_Source_Timestamp]    Script Date: 11/3/2025 15:02:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [da].[View_HMD_Data_Source_Timestamp]
AS

SELECT [Table]
,[SubTable]
,[TableType]
,[DownStreamSchema] + '.' + [DownStreamTable] as [DownStreamTable]
,[DownStreamType]
,[modify_date]
FROM
(
	SELECT 
	a.SchemaName + '.' +a.ViewName as [Table]
	,a.TableSchema + '.'+a.TableName as [SubTable]
	,a.TableType
	,ISNULL(
		IIF(
			IIF(IIF( IIF(e.TableName is null,d.TableName,e.TableName) is null ,c.TableName,e.TableName) is null
				,d.TableName
				,IIF(IIF(e.TableName is null,d.TableName,e.TableName) is null,c.TableName,e.TableName)
				) is null 
			,b.TableName
			,IIF(IIF( IIF(e.TableName is null,d.TableName,e.TableName) is null ,c.TableName,e.TableName) is null
				,d.TableName
				,IIF(IIF(e.TableName is null,d.TableName,e.TableName) is null,c.TableName,e.TableName)
				)
			),a.TableName) as [DownStreamTable]

	,ISNULL(
		IIF(
			IIF(IIF( IIF(e.TableSchema is null,d.TableSchema,e.TableSchema) is null ,c.TableSchema,e.TableSchema) is null
				,d.TableSchema
				,IIF(IIF(e.TableSchema is null,d.TableSchema,e.TableSchema) is null,c.TableSchema,e.TableSchema)
				) is null 
			,b.TableSchema
			,IIF(IIF( IIF(e.TableSchema is null,d.TableSchema,e.TableSchema) is null ,c.TableSchema,e.TableSchema) is null
				,d.TableSchema
				,IIF(IIF(e.TableSchema is null,d.TableSchema,e.TableSchema) is null,c.TableSchema,e.TableSchema)
				)
			),a.TableSchema) as [DownStreamSchema]
	,ISNULL(
		IIF(
			IIF(IIF( IIF(e.TableType is null,d.TableType,e.TableType) is null ,c.TableType,e.TableType) is null
				,d.TableType
				,IIF(IIF(e.TableType is null,d.TableType,e.TableType) is null,c.TableType,e.TableType)
				) is null 
			,b.TableType
			,IIF(IIF( IIF(e.TableType is null,d.TableType,e.TableType) is null ,c.TableType,e.TableType) is null
				,d.TableType
				,IIF(IIF(e.TableType is null,d.TableType,e.TableType) is null,c.TableType,e.TableType)
				)
			),a.TableType) as [DownStreamType]


	FROM [SiIMC_MGHT].[da].[View_Table_Dependency_Log] a

	LEFT JOIN [SiIMC_MGHT].[da].[View_Table_Dependency_Log] b
	ON a.[TableName] = b.[ViewName]
	AND a.[TableSchema] = b.[SchemaName]

	LEFT JOIN [SiIMC_MGHT].[da].[View_Table_Dependency_Log] c
	ON b.[TableName] = c.[ViewName]
	AND b.[TableSchema] = c.[SchemaName]

	LEFT JOIN [SiIMC_MGHT].[da].[View_Table_Dependency_Log] d
	ON c.[TableName] = d.[ViewName]
	AND c.[TableSchema] = d.[SchemaName]

	LEFT JOIN [SiIMC_MGHT].[da].[View_Table_Dependency_Log] e
	ON d.[TableName] = e.[ViewName]
	AND d.[TableSchema] = e.[SchemaName]

	WHERE a.[ViewName] = 'View_HMD_Data_Source'
) a
LEFT JOIN [da].[View_Table_Last_Usage] b
ON a.[DownStreamTable] = b.[Table_Target]

GO


