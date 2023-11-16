Select distinct pr.pressrunid,p.presssectionnumber,pr.plantype from pagetable p WITH (NOLOCK), pressrunid pr WITH (NOLOCK) 
where p.publicationid = 4
and p.locationid = 1
and p.pressid = 1
and p.productionid = 22
and p.pressrunid = pr.pressrunid
and (datepart(day,p.pubdate) = 11 and datepart(month,p.pubdate) = 10 and datepart(year,p.pubdate) = 2014)
order by pr.plantype,p.presssectionnumber,pr.pressrunid
