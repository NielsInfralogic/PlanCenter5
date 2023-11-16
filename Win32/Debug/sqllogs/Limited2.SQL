Select DISTINCT p1.sectionid,s.name from publicationsections p1, sectionnames s
Where publicationid = 4
and p1.sectionid = s.sectionid
order by s.name
