Select Distinct p1.PressSectionNumber,p1.pressrunid,p1.editionid,e1.name from pagetable p1 (NOLOCK), editionnames e1 (NOLOCK)
where p1.pressid = 1
and p1.locationid = 1
and p1.editionid = e1.editionid
and p1.dirty = 0 
and p1.productionid = 1
Order by p1.PressSectionNumber
