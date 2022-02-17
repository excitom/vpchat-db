/* Clear from database all tables and data */
SELECT "DROP TABLE " + name 
  FROM sysobjects
  WHERE type = "U"
PRINT "GO"
GO
