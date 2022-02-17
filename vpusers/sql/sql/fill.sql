/* fill data into Privilege Types table and Penalty Types table */
DECLARE @advisor int
DECLARE @host int
DECLARE @usersService int
DECLARE @questionMgr int
DECLARE @peopleMonitor int
DECLARE @logger int
DECLARE @rating int
DECLARE @objectMgr int
DECLARE @buddyList int
DECLARE @supervisor int
DECLARE @audsetMgr int
DECLARE @audsetService int
DECLARE @privMgr int
DECLARE @audsetSetup int
DECLARE @avatarAuthenticate int
DECLARE @gamesService int
DECLARE @advertiseService int
DECLARE @buddyInviteService int
DECLARE @netTraceService int
DECLARE @companionService int
DECLARE @conferenceService int

SELECT @advisor       = 272
SELECT @host          = 273
SELECT @usersService  = 289
SELECT @avatarAuthenticate = 290
SELECT @questionMgr   = 321
SELECT @audsetService = @questionMgr
SELECT @peopleMonitor = 322
SELECT @logger        = 323
SELECT @rating        = 324
SELECT @objectMgr     = 326
SELECT @buddyList     = 327
SELECT @gamesService  = 328
SELECT @advertiseService   = 329
SELECT @buddyInviteService = 330
SELECT @netTraceService    = 332
SELECT @companionService   = 333
SELECT @conferenceService    = 334
SELECT @supervisor       = 400
SELECT @audsetMgr     = 500
SELECT @audsetSetup   = 501
SELECT @privMgr       = 502

INSERT INTO privilegeTypes VALUES ( @advisor, "CrowdControl" )
INSERT INTO privilegeTypes VALUES ( @host, "Hosting" )
INSERT INTO privilegeTypes VALUES ( @peopleMonitor, "People Monitor" )
INSERT INTO privilegeTypes VALUES ( @logger, "Transcript Logger" )
INSERT INTO privilegeTypes VALUES ( @rating, "Rating" )
INSERT INTO privilegeTypes VALUES ( 325, "RatingMgr" )
INSERT INTO privilegeTypes VALUES ( @objectMgr, "ObjectMgr" )
INSERT INTO privilegeTypes VALUES ( @avatarAuthenticate, "Avatar Authentication" )
INSERT INTO privilegeTypes VALUES ( @buddyList, "BuddyListMgr" )
INSERT INTO privilegeTypes VALUES ( @supervisor, "Supervisor" )
INSERT INTO privilegeTypes VALUES ( @audsetMgr, "AudsetMgr" )
INSERT INTO privilegeTypes VALUES ( @audsetSetup, "AuditoriumSetup" )
INSERT INTO privilegeTypes VALUES ( @audsetService, "Auditorium Service" )
INSERT INTO privilegeTypes VALUES ( @privMgr, "CommunityMgmt" )
INSERT INTO privilegeTypes VALUES ( @gamesService, "Games Service" )
INSERT INTO privilegeTypes VALUES ( @advertiseService, "Advertise Service" )
INSERT INTO privilegeTypes VALUES ( @buddyInviteService, "Buddy Invite Service" )
INSERT INTO privilegeTypes VALUES ( @netTraceService, "Net Trace Service" )
INSERT INTO privilegeTypes VALUES ( @companionService, "Companion Service" )
INSERT INTO privilegeTypes VALUES ( @conferenceService, "Conference Service" )

INSERT INTO penaltyTypes VALUES ( 0, "Kick" )
INSERT INTO penaltyTypes VALUES ( 1, "Gag" )
INSERT INTO penaltyTypes VALUES ( 2, "Ban Av." )

INSERT INTO bannedNames VALUES ( "__", 1, 1 )

EXEC registerNewUser vpmanager,vpmanager,GZs14LWV
EXEC addPrivilege vpmanager,2,@privMgr
EXEC addPrivilege vpmanager,2,@advisor

/* insert service into registration database */
EXEC registerNewService "VpPlacesSrv","a1b3fg2",@rating
EXEC registerNewService "AuditoriumAdmin","AudAdmin",@audsetService
EXEC registerNewService "buddylist","vroomfondle",@buddyList
EXEC registerNewService "Authenticate","sign23786",@avatarAuthenticate
EXEC registerNewService "objects","jkdfgh78eyt",@objectMgr
EXEC registerNewService "vpgames","87c47948uy",@gamesService
EXEC registerNewService "advservice","3874t6y7u",@advertiseService
EXEC registerNewService "invitebuddies","InvBud",@buddyInviteService
EXEC registerNewService "vpnettrace","nettrace",@netTraceService
EXEC registerNewService "companionsrv","slartibartfast",@companionService
EXEC registerNewService "vpconference","ahEw72vx",@conferenceService

/* configuration keys defaults */

/* --- users service --- */

/* boolean values */
EXEC addConfigKey @keyName = "somGUEST", @belongsTo = @usersService, 
 @type = 1, @keyID = 1, @intValue = 1
EXEC addConfigKey @keyName = "somDB", @belongsTo = @usersService, 
 @type = 1, @keyID = 2, @intValue = 0
EXEC addConfigKey @keyName = "auxDbAllowed", @belongsTo = @usersService, 
 @type = 1, @keyID = 3, @intValue = 0
EXEC addConfigKey @keyName = "replicationOn", @belongsTo = @usersService, 
 @type = 1, @keyID = 4, @intValue = 1
EXEC addConfigKey @keyName = "guestCanEnterRoom", @belongsTo = @usersService, 
 @type = 1, @keyID = 5, @intValue = 1
EXEC addConfigKey @keyName = "guestCanCreateGroup", @belongsTo = @usersService, 
 @type = 1, @keyID = 6, @intValue = 1
EXEC addConfigKey @keyName = "guestCanUseAvatar", @belongsTo = @usersService, 
 @type = 1, @keyID = 7, @intValue = 1
EXEC addConfigKey @keyName = "AuthenticateAvatars", @belongsTo = @usersService, 
 @type = 1, @keyID = 8, @intValue = 0
EXEC addConfigKey @keyName = "showFullName", @belongsTo = @usersService, 
 @type = 1, @keyID = 9, @intValue = 0
EXEC addConfigKey @keyName = "javaGuestAllowed", @belongsTo = @usersService, 
 @type = 1, @keyID = 10, @intValue = 1
EXEC addConfigKey @keyName = "preferSecondInstance", @belongsTo = @usersService, 
 @type = 1, @keyID = 11, @intValue = 0
EXEC addConfigKey @keyName = "blRequiresEmail", @belongsTo = @usersService, 
 @type = 1, @keyID = 12, @intValue = 1


/* string values */
EXEC addConfigKey @keyName = "auxDbAddress", @belongsTo = @usersService, 
 @type = 2, @keyID = 1, @strValue = ""
EXEC addConfigKey @keyName = "communityName", @belongsTo = @usersService, 
 @type = 2, @keyID = 2, @strValue = ""
EXEC addConfigKey @keyName = "hallTitle", @belongsTo = @usersService, 
 @type = 2, @keyID = 3, @strValue = ""
EXEC addConfigKey @keyName = "registrationUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 4, @strValue = ""
EXEC addConfigKey @keyName = "PTG_Community", @belongsTo = @usersService, 
 @type = 2, @keyID = 5, @strValue = ""
EXEC addConfigKey @keyName = "PTG_Places", @belongsTo = @usersService, 
 @type = 2, @keyID = 6, @strValue = ""
EXEC addConfigKey @keyName = "HelpURL", @belongsTo = @usersService, 
 @type = 2, @keyID = 7, @strValue = ""
EXEC addConfigKey @keyName = "ReleaseNotes", @belongsTo = @usersService, 
 @type = 2, @keyID = 8, @strValue = ""
EXEC addConfigKey @keyName = "HomePage", @belongsTo = @usersService, 
 @type = 2, @keyID = 9, @strValue = ""
EXEC addConfigKey @keyName = "advertisement", @belongsTo = @usersService, 
 @type = 2, @keyID = 10, @strValue = ""
EXEC addConfigKey @keyName = "misbehavior", @belongsTo = @usersService, 
 @type = 2, @keyID = 11, @strValue = ""
EXEC addConfigKey @keyName = "signOnUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 12, @strValue = ""
EXEC addConfigKey @keyName = "animationUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 13, @strValue = ""
EXEC addConfigKey @keyName = "coolPlacesListUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 14, @strValue = ""
EXEC addConfigKey @keyName = "eventsListUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 15, @strValue = ""
EXEC addConfigKey @keyName = "userNameCharacters", @belongsTo = @usersService, 
 @type = 2, @keyID = 16, @strValue = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!_- "
EXEC addConfigKey @keyName = "PubPTG_Places", @belongsTo = @usersService, 
 @type = 2, @keyID = 17, @strValue = ""
EXEC addConfigKey @keyName = "pubCoolPlacesListUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 18, @strValue = ""
EXEC addConfigKey @keyName = "pubEventsListUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 19, @strValue = ""
EXEC addConfigKey @keyName = "badAvatarMsg", @belongsTo = @usersService, 
 @type = 2, @keyID = 20, @strValue = ""
EXEC addConfigKey @keyName = "badTourAvatarMsg", @belongsTo = @usersService, 
 @type = 2, @keyID = 21, @strValue = ""
EXEC addConfigKey @keyName = "buddyListHelpUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 22, @strValue = ""
EXEC addConfigKey @keyName = "buddyListLocateUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 23, @strValue = ""
EXEC addConfigKey @keyName = "forumsUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 24, @strValue = ""
EXEC addConfigKey @keyName = "communityCentreUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 25, @strValue = ""
EXEC addConfigKey @keyName = "buddyListRecommendUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 26, @strValue = ""
EXEC addConfigKey @keyName = "userProfileUrl", @belongsTo = @usersService, 
 @type = 2, @keyID = 27, @strValue = ""

/* number values */
EXEC addConfigKey @keyName = "diffFromGMT", @belongsTo = @usersService, 
 @type = 3, @keyID = 1, @intValue = -6
EXEC addConfigKey @keyName = "maxCapacity", @belongsTo = @usersService, 
 @type = 3, @keyID = 2, @intValue = 10000
EXEC addConfigKey @keyName = "roomCapacity", @belongsTo = @usersService, 
 @type = 3, @keyID = 3, @intValue = 25
EXEC addConfigKey @keyName = "idleTimeout", @belongsTo = @usersService, 
 @type = 3, @keyID = 4, @intValue = 99
EXEC addConfigKey @keyName = "usersSampleRate", @belongsTo = @usersService, 
 @type = 3, @keyID = 5, @intValue = 60
EXEC addConfigKey @keyName = "neverEnteredUsersDeletedAfter", @belongsTo = @usersService, 
 @type = 3, @keyID = 6, @intValue = 14
EXEC addConfigKey @keyName = "nonActiveUsersDeletedAfter", @belongsTo = @usersService, 
 @type = 3, @keyID = 7, @intValue = 30
EXEC addConfigKey @keyName = "deletionGracePeriod", @belongsTo = @usersService, 
 @type = 3, @keyID = 8, @intValue = 180
EXEC addConfigKey @keyName = "maxAccountsPerEmail", @belongsTo = @usersService, 
 @type = 3, @keyID = 9, @intValue = 5
EXEC addConfigKey @keyName = "auxDbPort", @belongsTo = @usersService, 
 @type = 3, @keyID = 10, @intValue = 0
EXEC addConfigKey @keyName = "defaultPlacesTab", @belongsTo = @usersService, 
 @type = 3, @keyID = 11, @intValue = 1


/* --- places service --- */

/* number values */
EXEC addConfigKey @keyName = "placesSampleRate", @belongsTo = @rating, 
 @type = 3, @keyID = 1, @intValue = 60
EXEC addConfigKey @keyName = "placesHistoryUpdateInterval", @belongsTo = @rating, 
 @type = 3, @keyID = 2, @intValue = 300
EXEC addConfigKey @keyName = "dataKeepingPeriod", @belongsTo = @rating, 
 @type = 3, @keyID = 3, @intValue = 90
EXEC addConfigKey @keyName = "placesUpdateInterval", @belongsTo = @rating, 
 @type = 3, @keyID = 4, @intValue = 60
EXEC addConfigKey @keyName = "placesHistoryCleaningTime", @belongsTo = @rating, 
 @type = 3, @keyID = 5, @intValue = 3

/* --- auditorium service --- */

/* number values */
EXEC addConfigKey @keyName = "eventsKeepingPeriod", @belongsTo = @audsetService, 
 @type = 3, @keyID = 1, @intValue = 180
EXEC addConfigKey @keyName = "auditoriumSampleRate", @belongsTo = @audsetService, 
 @type = 3, @keyID = 2, @intValue = 60
EXEC addConfigKey @keyName = "eventsCleaningTime", @belongsTo = @audsetService, 
 @type = 3, @keyID = 3, @intValue = 3

/* string values */
EXEC addConfigKey @keyName = "eventHostToolUrl", @belongsTo = @audsetService, 
 @type = 2, @keyID = 1, @strValue = ""

GO
