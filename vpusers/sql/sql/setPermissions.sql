EXEC sp_adduser vpplaces, vpplaces
EXEC sp_adduser audset, audset
GRANT SELECT ON getGMT TO PUBLIC 
GRANT SELECT ON configurationKeys TO PUBLIC 
GRANT EXECUTE ON getConfiguration TO PUBLIC 
GRANT EXECUTE ON isRegistered TO PUBLIC 
GRANT EXECUTE ON isPrivileged TO PUBLIC 
GRANT SELECT ON users TO audset 
GRANT SELECT ON userAccounts TO audset
GRANT SELECT ON registration TO audset
GRANT SELECT ON userPoints TO audset
GRANT INSERT ON userPoints TO audset
GRANT UPDATE ON userPoints TO audset
GO
