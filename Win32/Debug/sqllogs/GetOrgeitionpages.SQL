Select distinct editionid,mastercopyseparationset,uniquepage,locationid,pagename,sectionid,pressid from pagetable (NOLOCK)
Where active = 1  and (datepart(day,pubdate) = 2 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2014) and publicationid = 7 and uniquepage = 1 
Order by mastercopyseparationset
