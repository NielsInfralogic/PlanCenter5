Update pagetable
set approved = 1,approvetime = getdate(),approveuser='admin'
where active <> -999 AND Dirty=0
and MasterCopySeparationSet IN (SELECT DISTINCT P9.MasterCopySeparationSet FROM PageTable P9 WITH (NOLOCK) WHERE P9.PDFMaster =  1978)
and productionid Not in  (-99)

