/* Clear from database all tables and data */
SELECT "DROP VIEW " + name 
  FROM sysobjects
  WHERE type = "V"
PRINT "GO"
GO
