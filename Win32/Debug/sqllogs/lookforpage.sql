select locationID,pressID,pressrunid,productionid,fileserver,proofID,colorid,copynumber,status,proofstatus,
MasterCopySeparationSet,CopySeparationSet,SeparationSet,FlatSeparationSet,CopyFlatSeparationSet,separation,flatseparation,hold,approved,pagetype,UniquePage
 from pagetable (NOLOCK) where
publicationid = 4 and 
editionid = 2 and 
sectionid = 1 and 
pagename = '9'
 and (datepart(day,pubdate) = 1 and datepart(month,pubdate) = 11 and datepart(year,pubdate) = 2017)
