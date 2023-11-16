select p.outputVersion ,COUNT (distinct p.flatseparation ) from PageTable p (NOLOCK) 
where  p.productionid > -99  and p.publicationid = 16 and (datepart(day,p.pubdate) = 2 and datepart(month,p.pubdate) = 1 and datepart(year,p.pubdate) = 2016) and p.status >= 50 and p.Outputtime  > '2000-1-1'
And p.pagetype <> 3 and p.Active = 1
group by p.outputVersion
