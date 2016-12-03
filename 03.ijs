t =: > ".&.> cutLF CR-.~fread '03.dat'
v =: *./@(0&|. < 1&|. + 2&|.)
echo +/ v"1 t
echo +/ v"1 ($$,&|:) t
exit 0
