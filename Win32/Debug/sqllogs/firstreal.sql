Select min(EventTime) from Log (NOLOCK) , PageTable p (NOLOCK) 
where  p.productionid > -99  and p.publicationid = 16 and (datepart(day,p.pubdate) = 2 and datepart(month,p.pubdate) = 1 and datepart(year,p.pubdate) = 2016)
and Log.Separation = p.Separation and Log.Event = 80
And p.pagetype <> 3
