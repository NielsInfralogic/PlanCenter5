Select Distinct pr.miscint1,pf.PageFormatName from pagetable p1 (NOLOCK),pressrunid pr (NOLOCK),PageFormatNames pf (NOLOCK) 
Where active <> -999
and p1.publicationid = 32
 and (datepart(day,p1.pubdate) = 10 and datepart(month,p1.pubdate) = 3 and datepart(year,p1.pubdate) = 2016)
and p1.locationid = 1
and p1.pressrunid = pr.pressrunid and pr.miscint1 > 0
and pr.miscint1 = pf.PageFormatID 
