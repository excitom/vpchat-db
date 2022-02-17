/* upon adding a record of total usage to PTGlist,
   copy it to totalUsage table */
/*
NOTE : Because most of the time PTGlist records
       are only updated, except for the one time
       when a record with the matching serial
       number is created, only an UPDATE trigger
       will be created
*/
CREATE TRIGGER addDailyUsageRecord
  ON totalUsage
  FOR INSERT
AS
BEGIN
  DECLARE @lastError int
  DECLARE @diffFromGMT int
  DECLARE @currentTime VpTime
  DECLARE @localTime VpTime
  DECLARE @yesterdayStartLocalTime VpTime
  DECLARE @yesterdayEndLocalTime VpTime
  
  DECLARE @minuteTotalRecordsForDay int
  DECLARE @dailyTotalRecordsForDay int
  DECLARE @dayToSummarize VpTime
  DECLARE @yesterdayStartGMT VpTime
  DECLARE @yesterdayEndGMT VpTime
  DECLARE @doDailySummary bit
  
  DECLARE @minAll INTEGER, @maxAll INTEGER, @avgAll INTEGER
  DECLARE @minChat INTEGER, @maxChat INTEGER, @avgChat INTEGER
  DECLARE @minBl INTEGER, @maxBl INTEGER, @avgBl INTEGER
  
  SELECT @diffFromGMT = gmt
    FROM vpusers..getGMT
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  IF @diffFromGMT IS NULL
    SELECT @diffFromGMT = 0
  
  SELECT @localTime = time
    FROM inserted
  SELECT @currentTime = @localTime

  /* get convert from GMT to local time */
  SELECT @localTime = dateadd( hour, @diffFromGMT, @localTime )
  
  SELECT @yesterdayStartLocalTime = dateadd( day, -1, @localTime )
  SELECT @yesterdayStartLocalTime = dateadd( hour, 
                                             0 - datepart( hour, @yesterdayStartLocalTime ), 
                                             @yesterdayStartLocalTime )
  SELECT @yesterdayStartLocalTime = dateadd( minute, 
                                             0 - datepart( minute, @yesterdayStartLocalTime ), 
                                             @yesterdayStartLocalTime )
  SELECT @yesterdayEndLocalTime = dateadd( day, 1, @yesterdayStartLocalTime )
  SELECT @yesterdayEndLocalTime = dateadd( minute, -1, @yesterdayEndLocalTime )

  SELECT @yesterdayStartGMT = dateadd( hour, -1 * @diffFromGMT, @yesterdayStartLocalTime )
  SELECT @yesterdayEndGMT = dateadd( hour, -1 * @diffFromGMT, @yesterdayEndLocalTime )
  
  /* do summary for previous day only if there are no records in the
     dailyUsage table for this day, but records in totalUsage for 
     this day exist.
  */
  /* note: summaries for day are done by local time, so 
     "Day" will match the time when the local day starts and ends.
     The summaries are kept in dailyUsage in local time values, too,
     Therefore @yestardayStartLocalTime and @yesterdayEndLocalTime
     are used here.
  */
  

  SELECT @doDailySummary = 0
  SELECT @dailyTotalRecordsForDay = 0
  SELECT @dailyTotalRecordsForDay = count(*)
    FROM dailyUsage
    WHERE ( time BETWEEN @yesterdayStartLocalTime AND @yesterdayEndLocalTime )

  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRIGGER
  END
  
  IF ( @dailyTotalRecordsForDay IS NULL )
    SELECT @dailyTotalRecordsForDay = 0
  IF ( @dailyTotalRecordsForDay <= 0 )
  BEGIN
    SELECT @minuteTotalRecordsForDay = 0
    SELECT @minuteTotalRecordsForDay = count(*)
      FROM totalUsage
      WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF @minuteTotalRecordsForDay > 0
    BEGIN
      SELECT @doDailySummary = 1
    END
    ELSE
      SELECT @doDailySummary = 0
    END
  ELSE
  BEGIN
    SELECT @doDailySummary = 0
  END

  IF ( @doDailySummary = 1 )
  BEGIN
    /* do summary for the preceding day */
    SELECT 
           @minAll = min(totalUsage),
           @maxAll = max(totalUsage),
           @avgAll = avg(totalUsage),
           @minChat = min(roomUsage+corrUsage),
           @maxChat = max(roomUsage+corrUsage),
           @avgChat = avg(roomUsage+corrUsage),
           @minBl = min(BLUsage),
           @maxBl = max(BLUsage),
           @avgBl = avg(BLUsage)
      FROM totalUsage
        WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 0, 0, @avgAll )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minAll = @maxAll )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 1, @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 2, @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minAll != @maxAll */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 0, 1, @minAll
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( totalUsage = @minAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 0, 2, @maxAll
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( totalUsage = @maxAll )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 1, 0, @avgChat )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minChat = @maxChat )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 1, @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 0, 2, @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minChat != @maxChat */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 1, 1, @minChat
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( roomUsage+corrUsage = @minChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 1, 2, @maxChat
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( roomUsage+corrUsage = @maxChat )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    
    INSERT dailyUsage
      VALUES ( @yesterdayStartLocalTime, 2, 0, @avgBl )
    
    SELECT @lastError = @@error
    IF @lastError != 0
    BEGIN
      ROLLBACK TRIGGER
    END
    
    IF ( @minBl = @maxBl )
    BEGIN
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 2, 1, @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        VALUES ( @yesterdayStartLocalTime, 2, 2, @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
    ELSE /* @minBl != @maxBl */
    BEGIN
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 2, 1, @minBl
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( BLUsage = @minBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
      
      INSERT dailyUsage
        SELECT dateadd( hour, @diffFromGMT,time ), 2, 2, @maxBl
          FROM totalUsage
          WHERE ( time BETWEEN @yesterdayStartGMT AND @yesterdayEndGMT ) AND
                ( BLUsage = @maxBl )
      
      SELECT @lastError = @@error
      IF @lastError != 0
      BEGIN
        ROLLBACK TRIGGER
      END
    END
  END /* IF ( @doDailySummary = 1 ) */
    
END
GO
