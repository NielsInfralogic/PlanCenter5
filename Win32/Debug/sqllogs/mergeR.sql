Select distinct p1.mastercopyseparationset,p1.proofid,p1.templateid,p1.sheetside,p1.pagepositions,p1.pagetype,p1.publicationid,p1.colorid,p1.active,p1.proofstatus from pagetable p1 (NOLOCK)
where p1.mastercopyseparationset = 2373
and p1.pagetype < 2
and p1.active = 1
and p1.copynumber = 1
