Select  p1.Miscstring3,p1.Miscstring1,p1.EditionID,p1.SectionID,p1.PageName,p1.Pagination,p1.Version,p1.SheetNumber,p1.SheetSide,p1.CopyNumber,p1.HardProofStatus,p1.FlatProofStatus,p1.PlanPageName,p1.colorid,p1.Miscstring2,p1.Active,p1.Status,p1.ExternalStatus,p1.Approved,p1.Hold,p1.InkStatus,p1.PageType,p1.ProofStatus,p1.UniquePage,p1.FileName,p1.DeviceID,p1.PressTower,p1.Priority,p1.TemplateID,p1.MarkGroups,p1.PressSectionNumber,p1.mastercopyseparationset,p1.copyseparationset,p1.separationset,p1.separation,p1.copyflatseparationset,p1.flatseparationset,p1.flatseparation,colorname,pr.pressrunid,p1.pdfmaster,p1.PublicationID,p1.IssueID,p1.ProofID,p1.ProductionID,p1.LocationID,p1.FlatProofConfigurationID,p1.HardProofConfigurationID,p1.CustomerID
 from pagetable p1 (NOLOCK), colornames (NOLOCK), pressrunid pr (NOLOCK)
where p1.dirty = 0 
 and (datepart(day,p1.pubdate) = 1 and datepart(month,p1.pubdate) = 11 and datepart(year,p1.pubdate) = 2017)
 and p1.publicationid = 4
 and p1.pressid IN (1)
 and p1.pagetype <> 3 and p1.active = 1

and p1.colorid = colornames.colorid
and p1.pressrunid = pr.pressrunid
order by  p1.Miscstring3,p1.Miscstring1,p1.pageindex,p1.Pagination,p1.Version,p1.SheetNumber,p1.SheetSide,p1.CopyNumber,p1.HardProofStatus,p1.FlatProofStatus,p1.PlanPageName,colornames.colorname,p1.colorid,p1.Miscstring2,p1.Active,p1.Approved,p1.Hold,p1.InkStatus,p1.PageType,p1.ProofStatus,p1.UniquePage,p1.FileName,p1.PressTower,p1.Priority,p1.TemplateID,p1.MarkGroups,p1.PressSectionNumber
