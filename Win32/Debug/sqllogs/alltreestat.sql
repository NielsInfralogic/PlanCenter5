Select distinct p1.pressrunid,p1.status,p1.uniquepage,p1.approved,max(ISNULL(PRE.Event,0)),p1.pressid,p1.outputversion from pagetable p1 (NOLOCK)
LEFT OUTER JOIN PrepollPageTable PRE WITH (NOLOCK) ON
P1.MasterCopySeparationSet=PRE.MasterCopySeparationSet AND PRE.Event IN (116,126,136,216)
Where p1.active = 1 and p1.pagetype < 3 and p1.dirty = 0 and DATEPART(year,p1.PubDate) < 2100


and (p1.pressid IN (5))
 and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)
GROUP BY p1.pressrunid,p1.status,p1.uniquepage,p1.approved,p1.pressid,p1.outputversion
ORDER BY P1.pressrunid
