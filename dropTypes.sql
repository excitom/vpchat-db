/* Clear from database all tables and data */
SELECT "EXEC sp_droptype " + name 
  FROM systypes
  WHERE usertype >= 100
PRINT "GO"
GO
