/* 
   Add a history record when a new account is first activated, which is
   defined by receiving payment. Free trial accounts are tracked separately.
*/
CREATE TRIGGER firstPayment
  ON payments
  FOR INSERT
AS
IF @@rowCount = 1
BEGIN
  IF (SELECT COUNT(*)
       FROM payments,inserted
       WHERE payments.accountID = inserted.accountID
       AND   payments.amount > 0) > 0
  BEGIN
    IF (SELECT COUNT(*)
          FROM accountHistory,inserted
          WHERE accountHistory.accountID = inserted.accountID
          AND   (reason = 10 OR reason = 15)) = 0
    BEGIN
      DECLARE @aid userIdentifier
      SELECT @aid = accountID FROM inserted
      EXEC addAcctHistory @aid, 15, 0
    END
  END
END
GO
