Select distinct f.flatseparation,f.side,f.processid,f.processtype,f.event,f.message,f.eventtime,p.copynumber,p.flatseparationset,p.colorid 
from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)
where ((p.status = 46) or (p.status=49))
and p.copyflatseparationset = 979
and f.flatseparation = p.flatseparation
order by f.flatseparation
