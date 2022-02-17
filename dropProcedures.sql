/* Clear from database all tables and data */
SELECT "DROP PROC " + name 
  FROM sysobjects
  WHERE ( type = "P" ) AND
        ( name != "autobackup" )
PRINT "GO"
GO
