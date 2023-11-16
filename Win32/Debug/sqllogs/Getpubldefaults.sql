Select pl.TemplateID,pl.Markgroups,tc.TemplateName from PublicationTemplates pl, TemplateConfigurations tc
where pl.pressid = 1
and pl.publicationid = 4
and pl.templateid = tc.templateid
