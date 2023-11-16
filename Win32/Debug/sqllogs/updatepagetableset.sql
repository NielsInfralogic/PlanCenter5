update pagetable set 
mastercopyseparationset = 2024,
dirty = 0,copyflatseparationset = 2039,
flatseparationset = (2039 * 100)+copynumber  ,
FlatSeparation = (((cast(2039 as bigint) * 100)+copynumber)*100)+cast( colorid as bigint)
,productionid = 28
,fileserver = ''
,Layer = 1
,templateid = 2
,pagesonplate = 2
,pressrunid = 55
,pageposition = 2
,pagepositions = '2'
,creep = :creep
,MarkGroups = ''
where copyseparationset = 2040
and colorid in (1,2,3,4)
and copynumber = 1
and pagename = '9'
