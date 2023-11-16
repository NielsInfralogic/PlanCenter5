Select Distinct p1.PressSectionNumber,p1.pressrunid,p1.editionid,e1.name from pagetable p1 (NOLOCK), editionnames e1 (NOLOCK)
where p1.pressid = 1
and p1.pressrunid IN (-48,41) and productionid = 28
and p1.locationid = 1
and p1.editionid = e1.editionid
and p1.dirty = 0 
Order by e1.name,p1.PressSectionNumber,p1.pressrunid
