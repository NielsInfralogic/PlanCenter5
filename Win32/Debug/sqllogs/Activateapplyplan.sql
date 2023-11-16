Select TOP 1 p1.PressRunID,p1.SequenceNumber,min(p1.PriorityBeforeHottime),min(p1.PriorityDuringHottime),min(p1.PriorityAfterHottime),min(p1.PriorityHottimeBegin)
,min(p1.PriorityHottimeEnd),min(p1.OrderNumber),p2.pressrunid,min(p2.presstime),max(p2.deadline) from pressrunid p1 WITH (NOLOCK), pagetable p2 WITH (NOLOCK) 
Where p1.PressRunID = p2.PressRunID
and p2.publicationid = 4
 and (datepart(day,p2.pubdate) = 1 and datepart(month,p2.pubdate) = 11 and datepart(year,p2.pubdate) = 2017)
 group by p1.PressRunID,p1.SequenceNumber,p2.pressrunid
