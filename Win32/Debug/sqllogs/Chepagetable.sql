SELECT DISTINCT P1.CopySeparationSet,P1.PublicationID,P1.PubDate,P1.SectionID,P1.PageName FROM PageTable P1 WITH (NOLOCK) 
WHERE (P1.uniquepage <> 1 and p1.copyseparationset <> p1.mastercopyseparationset) and
(( EXISTS (SELECT MasterCopySeparationSet FROM PageTable P2  WITH (NOLOCK) WHERE P1.MasterCopySeparationSet=P2.MasterCopySeparationSet AND (P1.PublicationID<>P2.PublicationID OR P1.PubDate <> P2.PubDate)))
or (not EXISTS (SELECT P3.MasterCopySeparationSet FROM PageTable P3 WITH (NOLOCK) WHERE P1.MasterCopySeparationSet=P3.MasterCopySeparationSet AND p3.uniquepage = 1)))
