Select distinct p1.mastercopyseparationset,p1.locationid,p1.version,C.ColorName from pagetable p1, colornames c 
where (P1.publicationid = 2
and (datepart(day,P1.pubdate) = 31 and datepart(month,P1.pubdate) = 1 and datepart(year,P1.pubdate) = 2014)
and p1.inputtime > :inputtime
and p1.colorid = c.colorid
and p1.mastercopyseparationset = p1.copyseparationset)
and p1.locationid = 1
and not exists(select p2.mastercopyseparationset from pagetable p2
where p2.locationid <> 1
and p1.mastercopyseparationset = p2.mastercopyseparationset)
order by p1.mastercopyseparationset
