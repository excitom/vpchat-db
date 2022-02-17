/* incrementally fill data into database - from version 2.1.1.31g to 2.1.1.31j */

DECLARE @usersService int
DECLARE @netTraceService int
DECLARE @companionService int
DECLARE @conferenceService int
DECLARE @supervisor int

SELECT @usersService  = 289
SELECT @netTraceService    = 332
SELECT @companionService   = 333
SELECT @conferenceService    = 334
SELECT @supervisor       = 400

INSERT INTO privilegeTypes VALUES ( @netTraceService, "Net Trace Service" )
INSERT INTO privilegeTypes VALUES ( @companionService, "Companion Service" )
INSERT INTO privilegeTypes VALUES ( @conferenceService, "Conference Service" )

UPDATE privilegeTypes
SET description = "Supervisor"
WHERE privilegeType = @supervisor

EXEC registerNewService "vpnettrace","nettrace",@netTraceService
EXEC registerNewService "companionsrv","slartibartfast",@companionService
EXEC registerNewService "vpconference","ahEw72vx",@conferenceService

/* configuration keys defaults */

/* --- users service --- */

/* boolean values */
EXEC addConfigKey @keyName = "javaGuestAllowed", @belongsTo = @usersService, 
 @type = 1, @keyID = 10, @intValue = 1
EXEC addConfigKey @keyName = "preferSecondInstance", @belongsTo = @usersService, 
 @type = 1, @keyID = 11, @intValue = 0
EXEC addConfigKey @keyName = "blRequiresEmail", @belongsTo = @usersService, 
 @type = 1, @keyID = 12, @intValue = 1

/* string values */
EXEC addConfigKey @keyName = "forumsUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 24, @strValue = ""
EXEC addConfigKey @keyName = "communityCentreUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 25, @strValue = ""
EXEC addConfigKey @keyName = "buddyListRecommendUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 26, @strValue = ""
EXEC addConfigKey @keyName = "userProfileUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 27, @strValue = ""

/* number values */
EXEC addConfigKey @keyName = "defaultPlacesTab", @belongsTo = @usersService, 
 @type = 3, @keyID = 11, @intValue = 1


/* --- places service --- */

/* number values */

/* --- auditorium service --- */

/* number values */

/* string values */

GO
