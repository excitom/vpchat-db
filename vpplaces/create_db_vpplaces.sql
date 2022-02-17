-- Creating Database vpplaces
CREATE DATABASE vpplaces ON
VpDatabases= 500
		LOG ON 
VpDatabases_log= 50
GO

sp_dboption vpplaces,"abort tran on log full",TRUE
GO

use vpplaces
GO

sp_changedbowner vpplaces, TRUE
checkpoint
GO
sp_modifylogin vpplaces, defdb, vpplaces
GO
