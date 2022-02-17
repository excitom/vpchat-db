DECLARE @name varchar(200)
DECLARE @timeString varchar(100)
DECLARE @now smalldatetime
SELECT @now = getdate()
SELECT @timeString = ltrim(rtrim(str(datepart( year, @now ))))
SELECT @timeString = @timeString + "-" + ltrim(rtrim(str(datepart( month, @now ))))
SELECT @timeString = @timeString + "-" + ltrim(rtrim(str(datepart( day, @now ))))
SELECT @timeString = @timeString + "-" + ltrim(rtrim(str(datepart( hour, @now ))))
SELECT @timeString = @timeString + "." + ltrim(rtrim(str(datepart( minute, @now ))))
SELECT @name = "/u/vplaces/s/sybase/db/backup/vpplaces.tx.backupSet0."
SELECT @name = @name + @timeString
DUMP TRANSACTION vpplaces TO @name
GO
