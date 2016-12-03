t =: > ".&.> cutLF CR-.~fread '03.dat'
v =: *./&(0 1 2&{ < 1 2 0&{ + 2 0 1&{)
echo +/ v"1 t
echo +/ v"1 ($$,&|:) t
exit 0
