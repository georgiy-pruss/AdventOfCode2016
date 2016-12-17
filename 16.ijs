g =: (,&'0'),('01'{~'0'=|.)
gg =: {.`($: g)@.(> #)
h =: '01'{~_2&(=/\)
hh =: ($:@h)`]@.(2&|@#)

assert '001' -: g '0'
assert '100' -: g '1'
assert '11111000000' -: g '11111'
assert '1111000010100101011110000' -: g '111100001010'
assert '10000011110010000111' -: 20 gg '10000'
assert '110101' -: h '110010110100'
assert '100' -: hh '110010110100'
assert '01100' -: hh 20 gg '10000'

echo hh 272      gg i =: '01110110101001000' NB. 11100111011101111
echo hh 35651584 gg i                        NB. 10001110010000110

NB. should have been: ($:@('01'{~_2&(=/\)))
echo 272 35651584 ('01'{~_2&(=/\))`]@.(2&|@#) @ ({.`($:((,&'0'),('01'{~'0'=|.)))@.(> #))"0 1 i

NB. and it's faster with ints (Godspiral)
echo ,":"(0)_2(=/)\^:(21)35651584{.(],0,-.@|.)^:21"."0 i

exit 0
