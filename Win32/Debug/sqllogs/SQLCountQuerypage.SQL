Select Count(p1.separation) as tal from pagetable p1 (NOLOCK)
where p1.dirty = 0 
 and (datepart(day,p1.pubdate) = 1 and datepart(month,p1.pubdate) = 11 and datepart(year,p1.pubdate) = 2017)
 and p1.publicationid = 4
 and p1.pressid IN (1)
 and p1.pagetype <> 3 and p1.active = 1

