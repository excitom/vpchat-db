/* delete all data related to an auditorium
   after that auditorium was deleted */
CREATE TRIGGER delAuditoriumData
  ON auditoriums
  FOR DELETE
AS
BEGIN
  DECLARE @lastError int
  
  /* delete related events */
  DELETE events
  FROM events, deleted
  WHERE events.auditorium = deleted.auditoriumID
  
  SELECT @lastError = @@error
  IF @lastError != 0
  BEGIN
    ROLLBACK TRAN
  END
  
  -- ****** hosts table is not in use ***
  -- /* delete related hosts */
  -- DELETE hosts
  -- FROM hosts, deleted
  -- WHERE hosts.auditoriumID = deleted.auditoriumID
  -- 
  -- SELECT @lastError = @@error
  -- IF @lastError != 0
  -- BEGIN
  --   ROLLBACK TRAN
  -- END
  
END
GO
