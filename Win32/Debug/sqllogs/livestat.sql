SELECT p.Pubdate,p.Publicationid,p.Editionid,p.Sectionid,p.Locationid,p.Pressid,p.Pagename,p.UniquePage,p.CopyNumber,p.Colorid,p.Status,p.Approved,p.Hold,
p.Inputtime,p.Approvetime,p.Outputtime,p.Deviceid,p.Deadline,p.Comment,p.Pageindex,p.Separation,p.Flatseparation,p.MasterCopySeparationSet,p.PressRunID,p.ProductionID
from pagetable p WITH (NOLOCK) 
where p.dirty <> 1 and p.active = 1 and p.pagetype < 2  and p.locationid = 1and p.publicationid = 16 and (datepart(day,p.pubdate) = 2 and datepart(month,p.pubdate) = 1 and datepart(year,p.pubdate) = 2016)
order by p.Inputtime,p.Approvetime,p.Outputtime,p.MasterCopySeparationSet
