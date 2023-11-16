Select distinct locationid,editionid,sectionid,pagename,mastercopyseparationset,pageindex,copyseparationset,pressid,pressrunid from pagetable (NOLOCK)
Where active = 1  and (datepart(day,pubdate) = 2 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2014) and publicationid = 7 and uniquepage = 1 
and mastercopyseparationset < 50000
Order by locationid,pressid,editionid,sectionid,pageindex
