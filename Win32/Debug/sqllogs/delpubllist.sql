Select distinct p1.pubdate,p1.publicationid,p2.publicationid,p2.name,p1.pressid from pagetable p1 WITH (NOLOCK), PublicationNames p2 WITH (NOLOCK) 
where p1.publicationid = p2.publicationid and p1.dirty = 0
order by p1.pubdate,p2.name
