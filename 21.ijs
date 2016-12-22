sl=: 4 :'(|.z{y)z}y [ z=.y i.>2 5{x'
sp=: 4 :'(|.z{y)z}y [ z=.".>2 5{x'
rl=: 4 :'y|.~".>2{x'
rr=: 4 :'y|.~-".>2{x'
rp=: 4 :'(a{.y),(|.a}.b{.y),b}.y [ ''a b''=.0 1+/:~".>2 4{x'
rb=: 4 :'y|.~_1-n+n>:4 [ n=.y i.>6{x'
rbo=:4 :'y|.~1 1 _2 2 _1 3 0 4{~y i.>6{x'
mx=: 1 :(':';'((b{.]),c,b&}.)y-.c=.a{y [ ''a b''=.".>(u 2 5){x')
v=: sl`sp`rl`rr`rp`rb`([mx)
u=: sl`sp`rr`rl`rp`rbo`(|.mx)
k =: (<;._1' sl sp rl rr rp rb mp')&i. @: (<@({.&>@:(2{.[)))
scrmbl =: 4 :'for_s. x do. y =. s v@.k y end. y'
unscr=: 4 :'for_s. |.x do. y =. s u@.k y end. y'
echo 'abcdefgh' scrmbl~ d =: cut&>cutLF CR -.~ fread'21.dat'
echo d unscr 'fbgdceah'
assert 'fdhbcgea' -: d scrmbl 'abcdefgh'
assert 'abcdefgh' -: d unscr d scrmbl 'abcdefgh'
assert 'egfbcadh' -: d unscr 'fbgdceah'
exit 0
