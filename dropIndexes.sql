/* Clear from database all indexes */
SELECT  "DROP INDEX " + n.name + "." + i.name 
  FROM sysindexes i, sysobjects n
  WHERE n.type = "U" AND
        i.id = n.id
PRINT "GO"
GO
