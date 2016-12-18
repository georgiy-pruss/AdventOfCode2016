v =: '^'=(CRLF)-.~fread'18.dat'
a =: 3({.~:{:)\0,0,~]
s =: 4 : 'm=.+/0=y for_i. i.<:x do. m=.m+ +/0= y=.a y end. m'
echo 40 s v
echo 400000 s v
exit 0
