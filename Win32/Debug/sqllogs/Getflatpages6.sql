Select Count(Distinct Copyflatseparationset) from pagetable (NOLOCK)
where pressrunid = 45
and active = 1
and copyflatseparationset IN (-22,171,175,179,183,187,191,-99)
