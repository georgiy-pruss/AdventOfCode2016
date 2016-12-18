v =: '^'=(CRLF)-.~fread'18.dat'
a =: 3({.~:{:)\0,0,~]
echo (#-+/),a^:(i.40)v
echo (#-+/),a^:(i.400000)v NB. ~9.2s
NB. s =: 4 : 'm=.+/0=y for_i. i.<:x do. m=.m+ +/0= y=.a y end. m'
NB. echo 400000 s v NB. that would give ~9.5s
exit 0
