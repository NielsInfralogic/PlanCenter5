select DeviceID,Devicename,devicetype,Enabled,CurrentState,PanoramaOrientation from DeviceConfigurations 
where locationid = 1
order by DeviceName
