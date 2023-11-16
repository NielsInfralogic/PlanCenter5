Select distinct p1.pubdate,p1.publicationid,p1.editionid,p1.sectionid,pr.productionid,pr.plantype,'',p1.miscint2
, p2.ordernumber as pressrunordernumber,1,e1.name,pl.name,p2.pressrunid,p2.InkComment,p2.comment
, p2.TimedEditionTo,p2.TimedEditionFrom,p2.TimedEditionState
,0 as Prtid
,P1.Comment as Pcomment
,P2.PlanVersion as PRplanversion
from pagetable p1 (NOLOCK)
inner join productionnames pr (NOLOCK) on pr.productionid=p1.productionid
left outer join pressrunid p2 (NOLOCK) on p1.pressrunid=p2.pressrunid
inner join editionnames e1 (NOLOCK) on e1.editionid=p1.editionid
inner join PublicationNames PL (NOLOCK) on PL.publicationid=p1.publicationid
Where p1.pagetype < 3 and p1.active = 1 and p1.dirty = 0 AND DATEPART(year,p1.PubDate) < 2100


and p1.pressid IN (5)
 and (DATEDIFF(day,GETDATE(),p1.pubdate) >= 0)
order by  p1.pubdate,pl.name,p1.publicationid,e1.Name,p1.editionid,p1.sectionid,pr.productionid,pr.plantype,p1.miscint2 ,p2.ordernumber,p2.pressrunid,p2.InkComment,p2.comment , p2.TimedEditionTo,p2.TimedEditionFrom,p2.TimedEditionState,P2.PlanVersion,P1.Comment
