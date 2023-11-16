Select distinct p1.name,p1.presstemplateid,p2.presstemplateid,p2.pressid from  presstemplatenames p1, presstemplate p2
where p1.presstemplateid = p2.presstemplateid
and p2.pressid = 1
order by p1.name
