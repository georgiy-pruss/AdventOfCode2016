scramble =: 4 : 0 NB. x - input array, y - string to scramble
  for_s. x do. select. >1{s
  case. 'letter' do. y=.(|.z{y)z}y [ z=.y i.>2 5{s NB. swap letter X with letter Y
  case. 'left' do. y=.y|.~".>2{s NB. rotate left X steps
  case. 'right' do. y=.y|.~-".>2{s NB. rotate right X steps
  case. 'positions' do. y=. (a{.y),(|.a}.b{.y),b}.y [ 'a b'=.0 1+/:~".>2 4{s NB. |. X..Y
  case. 'based' do. y=.(_1-n+n>:4)|.y [ n=.y i.>6{s NB. rotate based on position of letter X
  case. 'position' do. NB. swap pos. X/Y or move pos. X --> pos. Y
  if. 'swap'-:>{.s do. y=.(|.z{y)z}y [ z=.".>2 5{s NB. rev.swap position X with position Y
  else. y=.(c{.y),((*b-a)|.c}.(>:d){.y),(>:d)}.y['c d'=./:~'a b'=.".>2 5{s end. end. end.
  y
)

unscramble =: 4 : 0 NB. x - input array, y - string to unscramble
  for_s. |.x do. select. >1{s NB. do the reverse ops!!!
  case. 'letter' do. y=.(|.a{y)a}y [ a=.y i.>2 5{s NB. rev.swap letter X Y
  case. 'left' do. y=.y|.~-".>2{s NB. rev.rotate left X steps
  case. 'right' do. y=.y|.~".>2{s NB. rev.rotate right X steps
  case. 'positions' do. y=. (a{.y),(|.a}.b{.y),b}.y [ 'a b'=.0 1+/:~".>2 4{s NB. rev. |. X..Y
  case. 'based' do. y=.y|.~1 1 _2 2 _1 3 0 4{~y i.>6{s NB. rev.rotate based on letter X
  case. 'position' do. NB. rev.swap pos. X/Y or rev.move pos. X --> pos. Y
  if. 'swap'-:>{.s do. y=.(|.z{y)z}y [ z=.".>2 5{s NB. rev.swap position X with position Y
  else. y=.(c{.y),((*b-a)|.c}.(>:d){.y),(>:d)}.y['c d'=./:~'b a'=.".>2 5{s end. end. end.
  y
)

echo 'abcdefgh' scramble~ d =: cut&>cutLF CR -.~ fread'21.dat'
assert 'abcdefgh' -: d unscramble d scramble 'abcdefgh'
echo d unscramble 'fbgdceah'
exit 0
