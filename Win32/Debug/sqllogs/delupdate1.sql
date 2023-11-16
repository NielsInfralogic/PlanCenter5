Update pagetable Set pubdate = :newdate, dirty = 1
where publicationid = 7
and (datepart(day,pubdate) = 8 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2014)
and pressid = 1
