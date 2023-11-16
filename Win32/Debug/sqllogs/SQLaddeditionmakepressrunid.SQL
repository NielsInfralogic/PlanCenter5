DECLARE @SequenceNumber int
DECLARE @Deadline1 datetime
DECLARE @Deadline2 datetime
DECLARE @Deadline3 datetime
DECLARE @Deadline4 datetime
DECLARE @PriorityBeforeHottime int
DECLARE @PriorityDuringHottime int
DECLARE @PriorityAfterHottime int
DECLARE @PriorityHottimeBegin datetime
DECLARE @PriorityHottimeEnd datetime
DECLARE @Comment varchar(512)
DECLARE @UsePressTowerInfo int
DECLARE @OrderNumber varchar(50)
DECLARE @InkComment varchar(50)
DECLARE @Backwards int
DECLARE @perfectbound int
DECLARE @inserted int
DECLARE @Planname varchar(50)
DECLARE @Presssystem varchar(50)
DECLARE @Plantype int
DECLARE @TimedEditionFrom int
DECLARE @TimedEditionTo int
DECLARE @TimedEditionState int
DECLARE @FromZone int
DECLARE @ToZone int
DECLARE @Circulation int
DECLARE @Circulation2 int
DECLARE @Comment2 varchar(512)
DECLARE @Miscint1 int
DECLARE @Miscint2 int
DECLARE @Miscstring1 varchar(50)
DECLARE @Miscstring2 varchar(50)
DECLARE @miscdate datetime
DECLARE @planversion int
DECLARE @t TABLE (SequenceNumber int,Deadline1 datetime,Deadline2 datetime,Deadline3 datetime,Deadline4 datetime,
PriorityBeforeHottime int,PriorityDuringHottime int,PriorityAfterHottime int,PriorityHottimeBegin datetime,PriorityHottimeEnd datetime,
Comment varchar(512),UsePressTowerInfo int,OrderNumber varchar(50),InkComment varchar(50),Backwards int,perfectbound int,inserted int,
Planname varchar(50),Presssystem varchar(50),Plantype int,TimedEditionFrom int,TimedEditionTo int,TimedEditionState int,
FromZone int,ToZone int,Circulation int,Circulation2 int,Comment2 varchar(512),
Miscint1 int,Miscint2 int,Miscstring1 varchar(50),Miscstring2 varchar(50),miscdate datetime,Planversion int)
INSERT INTO @t
	SELECT DISTINCT SequenceNumber,Deadline1,Deadline2,Deadline3,Deadline4,PriorityBeforeHottime,
	PriorityDuringHottime,PriorityAfterHottime,PriorityHottimeBegin,PriorityHottimeEnd,
	Comment,UsePressTowerInfo,OrderNumber,InkComment,Backwards,perfectbound,inserted,
	Planname,Presssystem,Plantype int,TimedEditionFrom,TimedEditionTo,TimedEditionState,
	FromZone,ToZone,Circulation,Circulation2,Comment2,
	Miscint1,Miscint2,Miscstring1,Miscstring2,miscdate,Planversion
FROM pressrunid as p WITH (NOLOCK)
	WHERE p.pressrunid = 29
SET @SequenceNumber = 2
SET @Deadline1 = (SELECT Deadline1 FROM @t)
SET @Deadline2 = (SELECT Deadline2 FROM @t)
SET @Deadline3 = (SELECT Deadline3 FROM @t)
SET @Deadline4 = (SELECT Deadline4 FROM @t)
SET @PriorityBeforeHottime = (SELECT PriorityBeforeHottime FROM @t)
SET @PriorityDuringHottime = (SELECT PriorityDuringHottime FROM @t)
SET @PriorityAfterHottime = (SELECT PriorityAfterHottime FROM @t)
SET @PriorityHottimeBegin = (SELECT PriorityHottimeBegin FROM @t)
SET @PriorityHottimeEnd = (SELECT PriorityHottimeEnd FROM @t)
SET @Comment = (SELECT Comment FROM @t)
SET @UsePressTowerInfo = (SELECT UsePressTowerInfo FROM @t)
SET @OrderNumber = (SELECT OrderNumber FROM @t)
SET @InkComment = (SELECT InkComment FROM @t)
SET @Backwards = (SELECT Backwards FROM @t)
SET @perfectbound = (SELECT perfectbound FROM @t)
SET @inserted = (SELECT inserted FROM @t)
SET @Planname = (SELECT Planname FROM @t)
SET @Presssystem = (SELECT Presssystem FROM @t)
SET @Plantype = (SELECT Plantype FROM @t)
SET @FromZone = (SELECT FromZone FROM @t)
SET @ToZone = (SELECT ToZone FROM @t)
SET @Circulation = (SELECT Circulation FROM @t)
SET @Circulation2 = (SELECT Circulation2 FROM @t)
SET @Comment2 = (SELECT Comment2 FROM @t)
SET @TimedEditionFrom = (SELECT TimedEditionFrom FROM @t)
SET @TimedEditionTo = (SELECT TimedEditionTo FROM @t)
SET @TimedEditionState = (SELECT TimedEditionState FROM @t)
SET @Miscint1 = (SELECT Miscint1 FROM @t)
SET @Miscint2 = (SELECT Miscint2 FROM @t)
SET @Miscstring1 = (SELECT Miscstring1 FROM @t)
SET @Miscstring2 = (SELECT Miscstring2 FROM @t)
SET @miscdate = (SELECT miscdate FROM @t)
SET @planversion = (SELECT planversion FROM @t)
insert pressrunid
(PressRunID,SequenceNumber,Deadline1,Deadline2,Deadline3,Deadline4,PriorityBeforeHottime,
PriorityDuringHottime,PriorityAfterHottime,PriorityHottimeBegin,PriorityHottimeEnd,Comment,UsePressTowerInfo,
OrderNumber,InkComment,Backwards,PerfectBound,Inserted,PlanName,PressSystem,PlanType,TimedEditionFrom,TimedEditionTo,TimedEditionState,
FromZone,ToZone,Circulation,Circulation2,Comment2,MiscInt1,MiscInt2,MiscString1,MiscString2,MiscDate,PlanVersion)
values(89,@SequenceNumber,@Deadline1,@Deadline2,@Deadline3,@Deadline4,@PriorityBeforeHottime,@PriorityDuringHottime,
@PriorityAfterHottime,@PriorityHottimeBegin,@PriorityHottimeEnd,@Comment,@UsePressTowerInfo,
@OrderNumber,@InkComment,@Backwards,@perfectbound,@inserted,
@Planname,@Presssystem,@Plantype,@TimedEditionFrom,@TimedEditionTo,@TimedEditionState,
@FromZone,@ToZone,@Circulation,@Circulation2,@Comment2,
@Miscint1,@Miscint2,@Miscstring1,@Miscstring2,@miscdate,@planversion )
