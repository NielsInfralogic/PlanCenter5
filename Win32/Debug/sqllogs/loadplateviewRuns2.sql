Select Distinct p1.PressSectionNumber,p1.pressrunid,p1.editionid,e1.name from pagetable p1 (NOLOCK), editionnames e1 (NOLOCK)
where p1.pressid = 1
and p1.pressrunid IN (-48,43,45) and productionid = 20
and p1.editionid = e1.editionid
and p1.dirty = 0 
Order by p1.PressSectionNumber,e1.name,p1.pressrunid
