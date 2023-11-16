select Distinct pressid from pagetable WITH (NOLOCK)
where publicationid = 11
 and (datepart(day,pubdate) = 28 and datepart(month,pubdate) = 10 and datepart(year,pubdate) = 2012)
Order by Pressid
