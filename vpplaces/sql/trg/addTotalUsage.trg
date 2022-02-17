/* upon adding a record of total usage to PTGlist,
   copy it to totalUsage table */
/*
NOTE : Because most of the time PTGlist records
       are only updated, except for the one time
       when a record with the matching serial
       number is created, only an UPDATE trigger
       will be created
*/
CREATE TRIGGER addTotalUsageRecord
  ON PTGlist
  FOR UPDATE
AS
BEGIN
  DECLARE @lastError int
  DECLARE @totalUsage int
  DECLARE @roomUsage int
  DECLARE @corrUsage int
  DECLARE @BLUsage int
  DECLARE @diffFromGMT int
  DECLARE @currentTime VpTime
  DECLARE @localTime VpTime
  DECLARE @deleteTime VpTime
  
  SELECT @roomUsage = roomUsage,
         @corrUsage = corrUsage
    FROM inserted
    WHERE inserted.serialNumber = -1
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  ELSE
  BEGIN
    IF ( @roomUsage IS NOT NULL )
    BEGIN
      /* insert record to totalUsage table */
      SELECT @totalUsage = @roomUsage + @corrUsage
      
      SELECT @diffFromGMT = gmt
        FROM vpusers..getGMT
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      IF @diffFromGMT IS NULL
        SELECT @diffFromGMT = 0
  
      SELECT @localTime = getdate()
      SELECT @currentTime = dateadd( hour, (-1) * @diffFromGMT, @localTime )
      SELECT @deleteTime = dateadd( day, (-1) * 180, @currentTime )
            
      DELETE totalUsage
        WHERE time < @deleteTime
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      SELECT @BLUsage = sum(corrUsage)
      FROM PTGlist
      WHERE ( PTGlist.URL LIKE "%vpbuddy://%" )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      IF @BLUsage IS NULL
        SELECT @BLUsage = 0
      
      INSERT totalUsage
        VALUES ( @currentTime, @totalUsage, @roomUsage, @corrUsage-@BLUsage, @BLUsage )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
    END /* IF ( @roomUsage IS NOT NULL ) */
  END
    
END
GO
