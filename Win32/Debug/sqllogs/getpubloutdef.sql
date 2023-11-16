Select distinct PT.TemplateID,PT.RipSetup,T.TemplateName from PublicationTemplates PT,TemplateConfigurations T 
where PT.pressid =  5
and PT.publicationid = 1
and PT.TemplateID = T.TemplateID
