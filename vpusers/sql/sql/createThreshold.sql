DECLARE @thresholdLevel int
DECLARE @doAdd bit
SELECT @doAdd = 1
SELECT @thresholdLevel = t.free_space 
  FROM systhresholds t, syssegments s 
  WHERE ( t.segment=s.segment ) AND
        ( s.name="logsegment" ) AND
        ( t.proc_name="autobackup" )
IF @thresholdLevel IS NOT NULL
BEGIN
  IF ( @thresholdLevel != 2500 )
  BEGIN
    EXEC sp_dropthreshold vpusers, logsegment, @thresholdLevel
  END
  ELSE
    SELECT @doAdd = 0
END
IF @doAdd = 1
  EXEC sp_addthreshold vpusers,logsegment,2500,autobackup
GO
