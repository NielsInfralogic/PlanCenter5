Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,0,P1.OutputVersion,PROD.PlanType,PREID.MiscInt2,PREID.PlanVersion from pagetable p1 (NOLOCK)
LEFT OUTER JOIN ProductionNames PROD WITH (NOLOCK) ON P1.ProductionID=PROD.ProductionID
LEFT OUTER JOIN PressRunID PREID WITH (NOLOCK) ON P1.PressRunID=PREID.PressRunID
Where p1.active = 1 and p1.pagetype < 3 and p1.dirty = 0 and DATEPART(year,p1.PubDate) < 2100
 and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)
and p1.pressid IN (5)
order by pressrunid
