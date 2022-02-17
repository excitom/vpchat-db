sp_adduser vpusr
go
sp_adduser audset
go

GRANT EXECUTE ON getPPlacesChanges TO vpusr
go
GRANT EXECUTE ON getPPlaces TO vpusr
go
GRANT EXECUTE ON delPPlace TO vpusr
go
GRANT EXECUTE ON updatePPlace TO vpusr
go
GRANT EXECUTE ON updateUserPlace TO vpusr
go

GRANT EXECUTE ON addPersistentPlace TO audset
go
GRANT EXECUTE ON delPersistentPlace TO audset
go
GRANT EXECUTE ON persistentPlaceExists TO audset
go
