t =: 'uqwqemis'

md5 =: 3 : 0
  m=.,y
  c=. '"',libjqt,'" gethash ',(IFWIN#'+'),' i *c *c i * *i'
  'r t m w p n'=. c cd 'md5';m;(#m);(,2);,0
  res=. memr p,0,n
  if. r do.
    res (13!:8) 3
  end.
  res
)

NB. https://en.wikipedia.org/wiki/MD5
assert '9e107d9d372bb6826bd81d3542a419d6' -: md5 'The quick brown fox jumps over the lazy dog'

assert '1' -: 5{ md5 'abc3231929'
assert '8' -: 5{ md5 'abc5017308'
assert 'f' -: 5{ md5 'abc5278568'

f =: 3 : 0 NB. part 1
  i =. 0
  o =. ''
  while. 1 do.
    m =. md5 y,":i
    if. '00000' -: 5{.m do. o=.o,5{m if. 8=#o do. break. end. end.
    i =. i+1
  end.
  NB. echo i
  o
)

g =: 3 : 0 NB. part 2
  i =. 0
  B =. '_' NB. blank char
  o =. 8$B
  d =. 0   NB. digits done
  while. 1 do.
    m =. md5 y,":i
    if. '00000' -: 5{.m do.
      p=.5{m
      if. p e. '01234567' do.
        if. B=(".p){o do.
          o =. (6{m) (".p)}o
          d =. d+1
          NB. echo i
          NB. echo o
          if. d=8 do. break. end.
        end.
      end.
    end.
    i =. i+1
  end.
  o
)

NB. assert '18f47a30' -: f 'abc'  NB. it's ok but long: 64.65 s for 8605828 iters.
NB. assert '05ace8e3' -: g 'abc' NB. 104 s for 13753421 iterations
echo f t NB. 1a3099aa, 125.5 s for 16734551 iterations
echo g t NB. 694190cd, 199 s for 26326685 iterations
exit 0
