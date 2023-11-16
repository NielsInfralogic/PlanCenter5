Select * from pagetable (NOLOCK)
where pressid = 1
and pressrunid = 44
and locationid = 1
 and (datepart(day,pubdate) = 11 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2014)
and copynumber <= 1
order by sheetnumber,sheetside,copyflatseparationset,flatseparationset,colorid,pagepositions
