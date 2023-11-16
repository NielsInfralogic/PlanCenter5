select distinct pre.MasterCopySeparationSet,pre.ProcessType,pre.Event,pre.Message,pre.EventTime,p1.mastercopyseparationset from PrepollPageTable pre (NOLOCK) , pagetable p1 (NOLOCK)
where p1.separation > -99 and p1.pagetype < 2  and p1.locationid = 1 and p1.publicationid = 32 and (datepart(day,p1.pubdate) = 10 and datepart(month,p1.pubdate) = 3 and datepart(year,p1.pubdate) = 2016) and p1.copynumber = 1 
And pre.mastercopyseparationset = p1.mastercopyseparationset
order by pre.eventtime
