Update pagetable
set status = 30, miscint3 = 4, inkstatus = 0
where active <> -999
and status > 30
and (  publicationid = 3 and  (datepart(day,pubdate) = 16 and datepart(month,pubdate) = 9 and datepart(year,pubdate) = 2014))
and flatseparation = 3460104


