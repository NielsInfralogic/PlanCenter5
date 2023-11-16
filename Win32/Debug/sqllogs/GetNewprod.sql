select p1.locationid,p1.pressid,p1.pubdate,p1.productionid,p1.publicationid,
p1.editionid,p1.sectionid,p1.separationset,p1.flatseparation,p1.uniquepage,
p1.copynumber,p1.pressrunid,pr.comment,pr.inkcomment,pr.ordernumber,p1.hold,p1.status,
p1.PressSectionNumber,p1.deviceid,p1.mastercopyseparationset,p1.approved,p1.priority,p1.pagetype,p1.presstime,p1.presstower
,pr.comment2,pr.miscint1
,p1.DeviceGroupID
,p1.pageformatid
,PublicationNames.Name
from pagetable p1 (NOLOCK)
Inner join PublicationNames ON p1.PublicationID = PublicationNames.PublicationID
,pressrunid pr (NOLOCK)
where p1.active = 1  and p1.pagetype < 3  and p1.pressid IN (1) and p1.publicationid = 4 and (datepart(day,p1.pubdate) = 1 and datepart(month,p1.pubdate) = 11 and datepart(year,p1.pubdate) = 2017)
 and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)
and p1.pressrunid = pr.pressrunid

order by p1.locationid,p1.pressid,p1.pubdate, Name, p1.publicationid,p1.PressSectionNumber,p1.pressrunid,p1.copynumber,p1.flatseparation,p1.separationset
