/* CREATE DATA DEVICES */
DISK INIT     name = "VpDatabases",
	  physname = "/u/vplaces/s/sybase/db/VpDatabases.dat",
            vdevno = 2,
              size = 851500
GO
DISK INIT     name = "VpDatabases_log",
	  physname = "/u/vplaces/s/sybase/db/VpDatabases.log",
            vdevno = 3,
              size = 88000
GO
DISK INIT     name = "VpUserDetails",
	  physname = "/u/vplaces/s/sybase/db/VpUserDetails.dat",
            vdevno = 4,
              size = 563000
GO
