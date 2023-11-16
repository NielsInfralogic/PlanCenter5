update pagetable set status = 30
where ((pagetable.status = 10) or (PageTable.Status >= 50))
and pagetable.productionid = 12
and pagetable.Editionid =  3
and pagetable.locationid = 1
and exists (Select p2.mastercopyseparationset from pagetable p2
where
pagetable.mastercopyseparationset = p2.mastercopyseparationset
and p2.status >= 30
and p2.colorid = pagetable.colorid
and p2.uniquepage = 1
and p2.editionid <> pagetable.editionid
and p2.locationid = pagetable.locationid)
