Select * from pagetable (NOLOCK) 
where (dirty = 0) and (pressid = 1) and (productionid =  20)
order by editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions
