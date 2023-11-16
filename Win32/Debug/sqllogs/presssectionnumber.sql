select Min (presssectionnumber) from pagetable WITH (NOLOCK) 
where locationid = 1
and publicationid = 4
and (datepart(day,pubdate) = 23 and datepart(month,pubdate) = 9 and datepart(year,pubdate) = 2015)
