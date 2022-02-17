/* Clear from database all users (except dbo) */
SELECT "EXEC sp_dropuser " + name
  FROM sysusers
  WHERE (suid>1) AND (uid>1)
PRINT "GO"
GO
