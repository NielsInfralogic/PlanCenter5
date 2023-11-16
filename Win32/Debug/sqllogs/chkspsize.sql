 select count (distinct name)  from sys.all_parameters
	where object_id = (select top 1 object_id  from sys.objects 
	where name =  'spAddLogEntry')
