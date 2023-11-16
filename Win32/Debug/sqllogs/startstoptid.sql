select MIN(p.OutputTime),MAX(p.OutputTime) from pagetable p (NOLOCK) 
where  p.productionid > -99  and p.publicationid = 16 and (datepart(day,p.pubdate) = 2 and datepart(month,p.pubdate) = 1 and datepart(year,p.pubdate) = 2016) and p.status >= 45 and p.OutputTime  > '2000-1-1'
 
and deviceid IN (-99)
And p.pagetype <> 3
