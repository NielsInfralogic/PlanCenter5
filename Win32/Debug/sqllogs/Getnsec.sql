Select distinct min(pageindex) as maxp, max(pageindex) as minp, editionid, sectionid from pagetable (NOLOCK)
where pressid = 1
and presssectionnumber = 2
and pressrunid = 45
and dirty = 0 and pagetype<3
group by editionid,sectionid
order by editionid,sectionid
