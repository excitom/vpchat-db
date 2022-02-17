-- Creating Database audset
CREATE DATABASE audset ON
VpDatabases= 25
		LOG ON 
VpDatabases_log= 10
GO

sp_dboption audset,"abort tran on log full",TRUE
GO

use audset
GO

sp_changedbowner vpplaces, TRUE
checkpoint
GO
sp_modifylogin vpplaces, defdb, audset
GO
