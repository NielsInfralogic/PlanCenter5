Select top 1 f.processtype,p.productionid 
from FlatPageTable f (NOLOCK),pagetable p (NOLOCK)
where ((p.status = 46) or (p.status=49))
and p.pressrunid = 45
and f.FlatSeparation = p.FlatSeparation
order by p.productionid
