SELECT TOP 1 PRE.Message FROM PageTable P WITH (NOLOCK) LEFT OUTER JOIN PrepollPageTable PRE WITH (NOLOCK) ON P.PdfMaster=PRE.MasterCopySeparationSet AND PRE.Event=260  
WHERE P.MasterCopySeparationSet=845
