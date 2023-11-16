Select distinct p1.Copyflatseparationset
from pagetable P1 (NOLOCK)
where (active = 1)
 and pressrunid = 21
and (Sectionid = 4 or pressrunid = 21)
and (Uniquepage = 1 or Uniquepage = 2)
