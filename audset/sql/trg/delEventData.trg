/* delete all data related to an event 
   after that event was deleted */
CREATE TRIGGER delEventData
  ON events
  FOR DELETE
AS
BEGIN
  /* delete related interaction types */
  DELETE interactionsAllowed
  FROM interactionsAllowed, deleted
  WHERE interactionsAllowed.eventID = deleted.eventID

  /* delete related interactions */
  DELETE eventInteractions
  FROM eventInteractions, deleted
  WHERE eventInteractions.eventID = deleted.eventID

  /* delete related hosts */
  DELETE hosts
  FROM hosts, deleted
  WHERE hosts.eventID = deleted.eventID

  /* delete related invitees */
  DELETE eventInvitees
  FROM eventInvitees, deleted
  WHERE eventInvitees.eventID = deleted.eventID

  /* delete related event states */
  DELETE eventState
  FROM eventState, deleted
  WHERE eventState.eventID = deleted.eventID

END
GO
