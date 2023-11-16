Select distinct sectionid,pagename,pageindex,mastercopyseparationset,uniquepage,locationid,copyseparationset,pressrunid,pressid,productionid from pagetable (NOLOCK)
Where locationid = 1 and (datepart(day,pubdate) = 2 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2014) and publicationid = 7 and editionid = 5 and copynumber = 1 and pagetype < 3
Order by pressrunid,sectionid,pageindex
