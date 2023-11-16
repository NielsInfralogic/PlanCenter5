update pagetable
set ImagingProcessID = 0,status = 30, EmailStatus = ((EmailStatus | 128) & 0xF0F0FFFF), miscint4 = 0,priority = 100
, OutputVersion = (CASE WHEN (OutputVersion <=0) THEN OutputVersion  ELSE (OutputVersion -1) END) 
where status > 30
 And Copynumber IN  (-1,1)
 And ColorID IN (-999,4)
 And Copyflatseparationset IN (-999,1)
