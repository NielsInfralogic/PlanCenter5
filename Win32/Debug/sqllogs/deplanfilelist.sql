Select distinct p1.FlatSeparationSet,p1.locationid,p1.version,C.ColorName,p1.flatseparation from pagetable p1, colornames c 
where P1.publicationid = 2
and (datepart(day,P1.pubdate) = 31 and datepart(month,P1.pubdate) = 1 and datepart(year,P1.pubdate) = 2014)
and p1.inputtime > :inputtime
and p1.status > 30
and p1.colorid = c.colorid
and p1.locationid = 1
order by p1.FlatSeparationSet
