/* Clear from database all triggers */
SELECT "DROP TRIGGER " + name 
  FROM sysobjects
  WHERE type = "TR"
PRINT "GO"
GO
