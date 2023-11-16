Select distinct pr.Event,pr.MasterCopySeparationSet,p1.MasterCopySeparationSet,p1.status,p1.PressRunID,pr.EventTime,p1.pressid from PrepollPageTable pr WITH (NOLOCK), pagetable p1 WITH (NOLOCK) WHERE
p1.MasterCopySeparationSet = pr.MasterCopySeparationSet AND DATEPART(year,p1.PubDate) < 2100
and (p1.pressid IN (5))
 and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)
order by p1.pressrunid,p1.MasterCopySeparationSet,pr.EventTime,pr.event,p1.pressid
