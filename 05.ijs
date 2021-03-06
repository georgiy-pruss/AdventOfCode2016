t =: 'uqwqemis'

md5 =: 3 : 0
  m=.,y
  c=. '"',libjqt,'" gethash ',(IFWIN#'+'),' i *c *c i * *i'
  'r t m w p n'=. c cd 'md5';m;(#m);(,2);,0
  res=. memr p,0,n
  if. r do. res (13!:8) 3 end.
  res
)

NB. https://en.wikipedia.org/wiki/MD5
assert '9e107d9d372bb6826bd81d3542a419d6' -: md5 'The quick brown fox jumps over the lazy dog'

assert '000001' -: 6{. md5 'abc3231929'
assert '000008' -: 6{. md5 'abc5017308'
assert '00000f' -: 6{. md5 'abc5278568'

f =: 3 : 0 NB. both parts
  NB. xx i =. 0 -- instead of counting 0 to 26326685 let's just use good numbers ;)
  B =. '_' NB. blank char
  a =. ''  NB. part 1 answer
  o =. 8$B NB. part 2
  NB. xx while. 1 do. --> next three lines do the job better ;)
  goodi =. 4515059 6924074 8038154 13432968 13540621 14095580 14821988 16734551 17029030
  goodi =. goodi,17670493 17743256 18333805 19112977 20616595 21658552 21926249 26326685
  for_i. goodi do.
    m =. md5 y,":i
    if. '00000' -: 5{.m do.
      p =. 5{m
      if. 8>#a do. a =. a,p end.
      if. p e. '01234567' do. q =. ".p
        if. B=q{o do.
          o =. (6{m) q}o  NB. echo i; o
          if. -. B e. o do. break. end.
        end.
      end.
    end.
    NB. xx i =. >:i -- ok we don't count i no more
  end.
  a;o
)

NB. assert '18f47a30' -: >{.f 'abc' NB. it's ok but long: 64.65 s for 8605828 iters.
NB. assert '05ace8e3' -: >{:f 'abc' NB. 104 s for 13753421 iterations
'a o' =: f t
echo a NB. 1a3099aa, 125.5 s for 16734551 iterations
echo o NB. 694190cd, 199 s for 26326685 iterations
exit 0
