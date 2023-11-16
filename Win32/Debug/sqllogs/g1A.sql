update pagetable
set approved = 1,approvetime = getdate(),approveuser='admin'
where pagetype <> 999
and mastercopyseparationset IN (-1,1053,1054)


