select top 1 t1.TemplateName,pr1.ProofName from pagetable p1 (NOLOCK), ProofConfigurations pr1 (NOLOCK), TemplateConfigurations t1 (NOLOCK) 
where p1.pressid = 1
and p1.publicationid = 4
and (datepart(day,pubdate) = 24 and datepart(month,pubdate) = 5 and datepart(year,pubdate) = 2017)
and p1.proofid = pr1.proofid 
and p1.templateid = t1.templateid 
