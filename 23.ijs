xlate =: 3 : 0 NB. returns (OPCODE(1-6), R1, I1, R2, I2) Ix if Rx<0
  'c a b' =. 3$cut>y
  ra =. _97+a.i.a if. (0<:ra)*.ra<:3 do. o1=.ra,0 else. o1=._1,".a end.
  rb =. _97+a.i.b if. (0<:rb)*.rb<:3 do. o2=.rb,0 else. o2=._1,".b end.
  select. c
  case.'nop' do. 0$~5
  case.'inc' do. 1,o1,0 0
  case.'dec' do. 2,o1,0 0
  case.'cpy' do. 3,o1,o2
  case.'jnz' do. 4,o1,o2
  case.'tgl' do. 5,o1,0 0
  case.'add' do. 6,o1,o2
  case.'mul' do. 7,o1,o2
  end.
)

inc =: 4 : '(>:({.y){x)({.y)}x'
dec =: 4 : '(<:({.y){x)({.y)}x'
cpy =: 4 : 'if. 0>2{y do. x else. if. 0>{.y do. (1{y)(2{y)}x else. (({.y){x)(2{y)}x end. end.'

jnz =: 4 : 0
  if. 0>{.y do. c=.1{y else. c=.({.y){x end.
  if. 0=c do. x return. end.
  if. 0>2{y do. d=.{:y else. d=.(2{y){x end.
  (<:d+{:x)_1}x
)

tgl =: 4 : 0
  target =. <:(({.y){x)+{:x
  if. (0<:target)*.target<lcode do.
    if. target<16 do. NB. we'll optimize first 16 commands so keep an eye!
      exit#echo '!';target
    end.
    code =: (0 2 1 4 3 1 6 7{~{.target{code) (<target,0)}code
  end. x
)

add =: 4 : '(((2{y){x)+({.y){x)(2{y)}x'
mul =: 4 : '(((2{y){x)*({.y){x)(2{y)}x'

exec =: 3 : 0 NB. regs --> regs
  it =. [`inc`dec`cpy`jnz`tgl`add`mul
  while. lcode > pc=.{:y do. y =. ((>:pc)_1}y) it@.({.c) }.c=.pc{code end. y
)

lcode =: # code =: xlate"0 'cpy 41 a';'inc a';'inc a';'dec a';'jnz a 2';'dec a'
assert 42 = {. exec 5$0

lcode =: # code =: xlate"0 'cpy 2 a';'tgl a';'tgl a';'tgl a';'cpy 1 a';'dec a';'dec a'
NB. assert 3 = {. exec 5$0  NB. this is ok but remove protection <16 in tgl

lcode =: # code =: sv =: xlate"0 cutLF CR-.~fread '23.dat'
echo {. exec  7 0 0 0 0

NB. echo (,.i.#code);(> cutLF CR-.~fread '23.dat');code1;(,.'x '{~code -:"1 1 code1);code

lcode =: # code =: sv
echo {. exec 12 0 0 0 0

exit 0
