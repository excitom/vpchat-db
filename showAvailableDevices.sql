DECLARE @devNum int
DECLARE @maxDevice int
DECLARE @matchCount int
SELECT @devNum = 0
SELECT @matchCount = 0
select @maxDevice = value - 1 from syscurconfigs where config=116
BEGIN
  WHILE ( @devNum < @maxDevice )
  BEGIN
    IF ( @devNum NOT IN 
         ( SELECT DISTINCT low/16777216
             FROM sysdevices ) )
    BEGIN
      SELECT @devNum, "is free"
      SELECT @matchCount = @matchCount + 1
    END
    SELECT @devNum = @devNum + 1
  END
END
GO         
