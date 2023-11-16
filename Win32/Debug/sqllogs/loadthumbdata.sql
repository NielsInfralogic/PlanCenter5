select p1.pagetype,p1.locationid,p1.productionid,p1.publicationid,p1.issueid,p1.editionid,p1.sectionid,p1.pagination,p1.mastercopyseparationset,
p1.pagename,p1.approved,p1.version,p1.PlanPageName,
p1.colorid,p1.pubdate,p1.mastercopyseparationset,p1.uniquepage,p1.status,p1.active,p1.proofstatus,p1.hold,p1.pageindex,p1.FileServer,p1.externalstatus,p1.comment,p1.presssectionnumber,p1.pressid
,p1.Pagination,p1.active,p1.OutputPriority,P1.FileName
,p1.PdfMaster,p1.PageFormatID
from pagetable p1 (NOLOCK)
where p1.separation > -99 and p1.pagetype < 2  and p1.locationid = 1 and p1.publicationid = 32 and (datepart(day,p1.pubdate) = 10 and datepart(month,p1.pubdate) = 3 and datepart(year,p1.pubdate) = 2016) and p1.copynumber = 1 
and P1.dirty = 0
Order by p1.publicationid,p1.editionid,p1.sectionid,p1.pageindex,p1.locationid,p1.presssectionnumber,p1.pressid,p1.pagination,p1.pagename,p1.mastercopyseparationset,p1.colorid
