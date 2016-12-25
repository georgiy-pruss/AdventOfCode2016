xlate =: 3 : 0 NB. returns (OPCODE(0-7), R1, I1, R2, I2) Ix if Rx<0
  'c a b' =. 3$cut>y
  ra =. _97+a.i.a if. (0<:ra)*.ra<:3 do. o1=.ra,0 else. o1=._1,".a end.
  rb =. _97+a.i.b if. (0<:rb)*.rb<:3 do. o2=.rb,0 else. o2=._1,".b end.
  if. 9>i=.(<c) i.~ 0;1;2;3;4;'cpy';'jnz';'add';'mul' do. i,o1,o2
  else. if. 5>i=.(<c) i.~ 0;'inc';'dec';'tgl';'out' do. i,o1,0 0 else. 5$0 end. end.
)

inc =: 4 : '(>:({.y){x)({.y)}x'
dec =: 4 : '(<:({.y){x)({.y)}x'
cpy =: 4 : 'if. 0>2{y do. x else. if. 0>{.y do. (1{y)(2{y)}x else. (({.y){x)(2{y)}x end. end.'

jnz =: 4 : 0
  if. 0>{.y do. c=.1{y else. c=.({.y){x end. if. 0=c do. x return. end.
  if. 0>2{y do. d=.{:y else. d=.(2{y){x end. (<:d+{:x)_1}x
)

tgl =: 4 : 'x' NB. no 'tgl' today

add =: 4 : '(((2{y){x)+({.y){x)(2{y)}x'
mul =: 4 : '(((2{y){x)*({.y){x)(2{y)}x'

out =: 4 : 0
  o =.({.y){x
  if. output=_1 do. x [ output=:o return.end.
  if. o=output do. 0 0 0 0 99 return.end. NB. stop the program
  if. (o<0)+.o>1 do. 0 0 0 0 99 return.end. NB. stop the program
  count =: >:count
  if. count>500 do. 1 0 0 0 99 return.end. NB. I hope 500 (0 1 0 1...) is enough
  x [ output=:o
)

exec =: 3 : 0 NB. regs --> regs
  it =. [`inc`dec`tgl`out`cpy`jnz`add`mul
  while. lcode > pc=.{:y do. y =. ((>:pc)_1}y) it@.({.c) }.c=.pc{code end. y
)

lcode =: # code =: xlate"0 'cpy 41 a';'inc a';'inc a';'dec a';'jnz a 2';'dec a'
assert 42 = {. exec 5$0

lcode =: # code =: sv =: xlate"0 cutLF CR-.~fread '25.dat' NB. used 'add' in one place
3 : 0 ''
for_i. i.10000 do.
  output =: _1 NB. means no output yet. should be 0 1 0 1 0 1 0 1 ...
  count =: 0
  b =. {. exec  i,0 0 0 0
  if. b do. echo i return. end.
end.
)

exit 0
