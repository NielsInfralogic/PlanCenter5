select Count(distinct  p.FlatSeparation) from PageTable p (NOLOCK) 
where  p.productionid > -99  and p.publicationid = 16 and (datepart(day,p.pubdate) = 2 and datepart(month,p.pubdate) = 1 and datepart(year,p.pubdate) = 2016)
And p.pagetype <> 3 and p.UniquePage <> 0 and p.Active = 1 and p.status < 50 
