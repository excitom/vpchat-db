SELECT tableName = o.name, indexName = i.name
FROM sysindexes i, sysobjects o
WHERE ( o.type = "U" ) AND
      ( i.id = o.id )
GO
