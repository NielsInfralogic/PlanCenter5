Select distinct productionid from pagetable WITH (NOLOCK) 
where publicationid = 7
and pressid = 1
and (datepart(day,pagetable.pubdate) = 8 and datepart(month,pagetable.pubdate) = 10 and datepart(year,pagetable.pubdate) = 2014)
