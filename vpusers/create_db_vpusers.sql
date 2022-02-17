-- Creating Database vpusers
CREATE DATABASE vpusers ON
VpDatabases= 1024
,
VpUserDetails= 1024
		LOG ON 
VpDatabases_log= 100
GO

sp_dboption vpusers,"abort tran on log full",TRUE
GO

use vpusers
GO

sp_changedbowner vpusr, TRUE
checkpoint
GO
sp_modifylogin vpusr, defdb, vpusers
GO
