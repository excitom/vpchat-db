/* delete all data related to an interaction
   after that event was deleted */
CREATE TRIGGER delInteractionData
  ON eventInteractions
  FOR DELETE
AS
BEGIN
  
  /* delete related answers */
  DELETE answers
  FROM answers, deleted
  WHERE answers.interactionID = deleted.interactionID
  
END
GO
