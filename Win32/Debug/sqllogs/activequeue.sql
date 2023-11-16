SELECT P1.Deviceid,P1.status,P1.Publicationid,P1.editionid,P1.sectionid,P1.pagename,P1.copynumber,P1.Colorid,P1.priority,P1.templateid,P1.pageindex,P1.flatseparation FROM PageTable AS P1  WITH (NOLOCK)
INNER JOIN ColorNames AS COL WITH (NOLOCK) ON COL.ColorID=P1.ColorID
INNER JOIN ProductionNames AS PROD WITH (NOLOCK) ON PROD.Productionid=P1.Productionid
WHERE
P1.LocationID = 1
AND P1.Dirty = 0
AND (P1.Status>=30 and P1.Status<50)
AND P1.UniquePage > 0
AND P1.Active=1
AND P1.Hold=0
AND P1.OutputPriority>=0
AND PROD.plantype>0
AND (P1.Approved = -1 OR P1.Approved = 1)
AND not EXISTS ( SELECT P2.FlatSeparation from PageTable AS P2 WITH (NOLOCK) WHERE P1.FlatSeparation = P2.FlatSeparation AND P2.Dirty=0 AND P2.Active=1 AND (P2.Status < 30 OR P2.Hold = 1 OR P2.Approved=2 OR P2.Approved=0))
ORDER BY p1.deviceid desc,P1.Priority DESC,P1.PressRunID,P1.SheetNumber,P1.SheetSide,P1.CopyFlatSeparationSet,COL.ColorOrder,P1.CopyNumber, P1.ApproveTime,P1.InputTime
