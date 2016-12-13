xlate =: 3 : 0 NB. returns (OPCODE(1-6), 0/NUM/R#, NUM/R#)
  select. c [ ra=. _97+a.i.a [ rb =. _97+a.i.b [ 'c a b' =. 3$cut>y
  case.'inc' do. 1 0,ra case.'dec' do. 2 0,ra
  case.'cpy' do. if. _~:n=._".a do. 3,n,rb else. 4,ra,rb end.
  case.'jnz' do. if. a-:,'1' do. 5 0,".b else. 6,ra,".b end. end.
)

inc =: 4 : '(>:({:y){x)({:y)}x'  NB. tacits of these are not faster
dec =: 4 : '(<:({:y){x)({:y)}x'
cpi =: 4 : '({.y)({:y)}x'
cpy =: 4 : '(({.y){x)({:y)}x'
jmp =: 4 : '(<:({:y)+{:x)(_1)}x'
jnz =: 4 : 'if.({.y){x do.(<:({:y)+{:x)(_1)}x else. x end.'
add =: 4 : '(+/y{x)({:y)}x'      NB. new op, not even in assembly yet :)

opt =: 3 : 0 NB. can't use _3 ...\ :(
  for_i. i.2-~#y do. z =. ,(i+0 1 2){y NB. temp vector for easier analysis
    if. 1 2 6-:0 3 6{z do.                           NB. inc x, dec y, jnz y -2
      if. (~:/2 5{z) *. (=/5 7{z) *. _2={:z do.      NB. ... to ...
        y=.(3 3$7,(5 2{z),3 0,(5{z),3$0)(i+0 1 2)}y  NB. add y x, cpi 0 y, nop
  end. end. end. y
)

exec =: 4 : 0 NB. regs exec code --> regs
  lt =. #y [ it =. [`inc`dec`cpi`cpy`jmp`jnz`add
  while. lt > pc=.{:x do. x=.((>:pc)_1}x)it@.({.c)}.c=.pc{y end. x
)

assert 42 = {. (5$0) exec xlate"0 'cpy 41 a';'inc a';'inc a';'dec a';'jnz a 2';'dec a'

code =: opt xlate"0 cutLF CR-.~fread '12.dat'
echo {. 0 0 0 0 0 exec code NB. 954395 instr
echo {. 0 0 1 0 0 exec code NB. 27683406 instr; 72 s; 384 kops. Now in no time

exit 0
