update pagetable set pdfmaster = MasterCopySeparationSet 
where Uniquepage <> 1 and MasterCopySeparationSet <> pdfmaster
and LocationId = 1
and Pressid = 1
and Publicationid = 4
and (datepart(day,pubdate) = 1 and datepart(month,pubdate) = 11 and datepart(year,pubdate) = 2017)
