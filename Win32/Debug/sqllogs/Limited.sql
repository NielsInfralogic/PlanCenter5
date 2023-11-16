Select DISTINCT p1.editionid,e.name from publicationeditions p1, editionnames e
Where publicationid = 4
and p1.editionid = e.editionid
order by e.name
