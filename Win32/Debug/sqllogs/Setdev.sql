update pagetable
set miscint4=0,deviceid = 1
,DeviceGroupID=0
where pagetype <> 999
and locationid = 1
and productionid = 2
and copynumber in (-99,1)
and copyflatseparationset = 19


