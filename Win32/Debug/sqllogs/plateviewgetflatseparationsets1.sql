Select Count(Distinct Copyflatseparationset) from pagetable (NOLOCK)
where pressid = 1
and pressrunid = 45
and active = 1 and dirty = 0
and copyflatseparationset IN (-22,171,175,179,183,187,191,-99)
and locationid = 1
