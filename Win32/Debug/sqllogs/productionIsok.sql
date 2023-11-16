Select TOP 1 p1.publicationid,p1.pubdate,p1.pressrunid,p2.publicationid,p2.pubdate, p2.pressrunid from pagetable p1 WITH (NOLOCK), pagetable p2 WITH (NOLOCK) where
(p1.flatseparation = p2.flatseparation or p1.copyseparationset = p2.copyseparationset) and
(p1.pressrunid <> p2.pressrunid or p1.productionid <> p2.productionid)
and p1.productionid =  28
and p1.pressrunid =  55
and p1.publicationid =  4
 and (datepart(day,p1.pubdate) = 1 and datepart(month,p1.pubdate) = 11 and datepart(year,p1.pubdate) = 2017)
