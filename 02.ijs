NB. http://adventofcode.com/2016/day/2
t =. cutLF CR-.~fread '02.dat'
f =. 4 : 0 NB. x - dictionary, y - text (boxed strings)
  n =. '5'
  o =. ''
  for_l. y do.
    NB. next line is state machine actually: n-state c-input x-map
    for_c. >l do. n =. ('0123456789ABCDEF'i.n) { ('UDLR' i.c) { x end.
    o =. o,n
  end.
  o
)
d1 =. 4 10 $ '-123123456-456789789-112445778-233566899' NB. U D L R
d2 =. 4 14 $ '-121452349678B-36785ABC9ADCD-122355678AABD-134467899BCCD'
assert '1985' -: d1 f sample=.'ULL';'RRDDD';'LURDL';'UUUUD'
assert '5DB3' -: d2 f sample
echo d1 f t
echo d2 f t
exit 0
