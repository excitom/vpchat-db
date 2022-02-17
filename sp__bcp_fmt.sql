sp__bcp_fmt

use sybsystemprocs
go
dump tran sybsystemprocs with truncate_only
go
if exists
(select name from sysobjects
where name = 'sp__bcp_fmt' and type = 'P')
DROP proc sp__bcp_fmt
go
create procedure sp__bcp_fmt
@bcptable varchar(32)
, @bcpversion char(4)='10.0'
, @bcplength varchar(3)=null
, @bcpseparator varchar(10)=null
as


/* Proprietary and Confidential Information of
**
** E. I. du Pont & Company, Inc.
**
**
**
** Protected by the Copyright Laws as an Unpublished
Work **
** All rights reserved.
**
**
*/
/*
Date Who What
01/22/02 W. Kraatz Added options for nullable columns
02/22/02 W. Kraatz Added check/msg for table existance
11/09/04 W. Kraatz added date and time datatypes
*/

set nocount on
declare @dbname varchar(30)
select @dbname = db_name()
if not exists (select * from sysobjects
where name = @bcptable and
( type = 'U' or type = 'V'))
begin
print "Table/view %1! does not exist in database %2!",
@bcptable, @dbname
return 1
end
select @bcplength = upper(@bcplength)
if @bcplength is null and @bcpseparator is null
select @bcplength = 'YES'

select c.colid,
Storage_type = st.name,
Prefix = convert(int,'0'),
Length = convert(int,c.length),
Name = c.name,
Separator = '"' + @bcpseparator + '" ' ,
Digits = c.prec,
NULLIND = c.status & 8
into #bcpdata1
from systypes s, systypes st, syscolumns c
where s.type = st.type
and st.name not in ("sysname", "nchar", "nvarchar")
and st.usertype < 100
and c.usertype = s.usertype
and id = object_id(@bcptable)

-- select @bcpseparator
-- select @bcplength

update #bcpdata1 set Length = 12 where Storage_type = 'int'
update #bcpdata1 set Length = 12 where Storage_type = 'intn'
update #bcpdata1 set Length = 6 where Storage_type =
'smallint'
update #bcpdata1 set Length = 3 where Storage_type =
'tinyint'
update #bcpdata1 set Length = 25 where Storage_type =
'float'
update #bcpdata1 set Length = 25 where Storage_type =
'floatn'
update #bcpdata1 set Length = 25 where Storage_type = 'real'
update #bcpdata1 set Length = 24 where Storage_type =
'money'
update #bcpdata1 set Length = 24 where Storage_type =
'moneyn'
update #bcpdata1 set Length = 24 where Storage_type =
'smallmoney'
update #bcpdata1 set Length = 1 where Storage_type = 'bit'
update #bcpdata1 set Length = 26 where Storage_type =
'datetime'
update #bcpdata1 set Length = 26 where Storage_type =
'datetimn'
update #bcpdata1 set Length = 26 where Storage_type =
'smalldatetime'
update #bcpdata1 set Length = 11 where Storage_type = 'date'
update #bcpdata1 set Length = 11 where Storage_type =
'daten'
update #bcpdata1 set Length = 14 where Storage_type = 'time'
update #bcpdata1 set Length = 14 where Storage_type =
'timen'

/* for decimal, numeric, and float with length provide
for sign, number of digits, decimal point */

update #bcpdata1 set Length = Digits + 2 where Storage_type
= 'decimal'
update #bcpdata1 set Length = Digits + 2 where Storage_type
= 'decimaln'
update #bcpdata1 set Length = Digits + 2 where Storage_type
= 'numeric'
update #bcpdata1 set Length = Digits + 2 where Storage_type
= 'numericn'
update #bcpdata1 set Length = Digits + 2 where Storage_type
= 'float' and Digits is not null
update #bcpdata1 set Length = -1, Prefix = 4 where
Storage_type = 'text'
update #bcpdata1 set Length = -1, Prefix = 4 where
Storage_type = 'image'
update #bcpdata1 set Length = -1, Prefix = 2 where
Storage_type = 'binary'
update #bcpdata1 set Length = -1, Prefix = 2 where
Storage_type = 'varybinary'
update #bcpdata1 set Length = -1, Prefix = 2 where
Storage_type = 'timestamp'

update #bcpdata1 set Prefix = 1
where NULLIND = 8 and @bcplength = 'YES' and Prefix = 0

update #bcpdata1 set Separator = '"\n"' where colid =
(select max(colid) from #bcpdata1)

create table #bcpdata2 (bcp_line varchar(80), line_ct int)
insert #bcpdata2
select ltrim(rtrim(convert(char(4),colid)) ) +
char(9) + 'SYBCHAR' + char(9) +
ltrim(rtrim(str(Prefix,1,0))) + char(9) +
ltrim(rtrim(str( Length,5,0))) + char(9) +
ltrim(rtrim(Separator)) + char(9) +
ltrim(rtrim(convert(char(4),colid))) + char(9) +
rtrim(Name), colid + 2
from #bcpdata1
/* insert #bcpdata2 select @bcpversion, 1 */
insert #bcpdata2 select '10.0', 1
insert #bcpdata2
select rtrim(ltrim(convert(char(3), max(colid)))), 2
from #bcpdata1
declare XYZ cursor for
select bcp_line
from #bcpdata2
order by line_ct
open XYZ
declare @outline varchar(72)
fetch XYZ into @outline
while (@@sqlstatus = 0)
begin
print @outline
fetch XYZ into @outline
end
go
if exists (select * from sysobjects
where name ='sp__bcp_fmt' and type = 'P')
begin
declare @msg varchar(200)
select @msg="stored procedure sp__bcp_fmt was
created in the "
+db_name()+" db."
print @msg
end
go
grant execute on sp__bcp_fmt to public
go
