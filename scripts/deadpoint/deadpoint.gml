///@func deadpoont()
///@param value "
///@param deadpoint "
var val=argument0
var dp=argument1
if val<dp and val>0 val=0
if val>-dp and val<0 val=0
return(val)