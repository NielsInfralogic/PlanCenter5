Select TOP 1 mastercopyseparationset,priority,colorid,pagename,pageindex,active from pagetable p1 (NOLOCK)
where p1.separation > -99 and p1.pagetype < 2  and p1.locationid = 1 and p1.publicationid = 6 and (datepart(day,p1.pubdate) = 11 and datepart(month,p1.pubdate) = 10 and datepart(year,p1.pubdate) = 2014) and p1.copynumber = 1 
And active = 1
and proofstatus > 0
and status >= 10
and pageindex > 1
and not exists(
Select P2.mastercopyseparationset from pagetable p2 (NOLOCK)
Where p1.mastercopyseparationset = p2.mastercopyseparationset
and (p2.status < 10 or p2.proofstatus = 0)
and p2.active = 1)
order by p1.pageindex
