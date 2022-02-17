/* delete all data related to an interaction
   after that event was deleted */
CREATE TRIGGER delVoteData
  ON eventVotes
  FOR DELETE
AS
BEGIN
  
  /* delete related user votes */
  DELETE userVotes
  FROM userVotes, deleted
  WHERE userVotes.voteID = deleted.voteID
  
  /* delete related vote options */
  DELETE voteOptions
  FROM voteOptions, deleted
  WHERE voteOptions.voteID = deleted.voteID
  
END
GO
