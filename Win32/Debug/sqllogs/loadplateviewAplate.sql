Select pagepositions,pressrunid,UniquePage, pagetype,Creep,SectionID,pressid,pagename,MasterCopySeparationSet,
CopySeparationSet,SeparationSet,pagetable.Separation,flatseparationset,
sheetside,CopyFlatSeparationSet,productionID,IssueID,publicationID,Copynumber,EditionID,locationID,deviceID,templateid,
pagetable.FlatSeparation,colorid,active,status,Proofstatus,Approved,priority,Hold,sortingposition,sheetnumber,
pressTower,pressHighlow,pressCylinder,pressZone,pagetype,pagename,pagination,pageindex,MarkGroups,flatproofconfigurationid,HardProofConfigurationID,Miscstring1,version,inkstatus,fileserver,externalstatus,flatproofstatus
, Comment
, Comment
 from pagetable (NOLOCK) 
where dirty = 0 and copyflatseparationset = 55
order by editionid,PressSectionNumber,pressrunid,sheetnumber,sheetside,Copynumber,copyflatseparationset,flatseparationset,colorid,pagepositions
