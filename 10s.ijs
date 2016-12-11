t =: cutLF CR-.~fread '10.dat'

b =: 0 6$0 [ o =: i.0

pv =: 4 : 0
  k=.{:y
  if. {.y do.
    'lw lx hw hx s1 s2' =. k{b
    if. s1=0 do.
      b =: x (<k,4)}b
    else.
      b =: x (<k,5)}b
      lv =. x <. s1 [ hv =. x >. s1
      if. 17 61 -: lv,hv do. echo k end.
      lv pv 0 1{k{b [ hv pv 2 3{k{b
    end.
  else.
    if. k>:#o do. o =: o,(>:k-#o)$0 end.
    o =: x k}o
  end.
)

3 : 0 /:~ t NB. sort values last
  for_s. y do. s =. ' 'cut >s
    if. 'bot'-:>{.s do.
      'k lk hk' =.".>1 6 11{s
      lo=.'bot'-:>5{s [ hi=.'bot'-:>10{s
      if. k>:#b do. b =: b,((>:k-#b),{:$b)$0 end.
      b =: (lo,lk,hi,hk,0,0) k}b
    else.
      v pv 1,k [ 'v k' =.".>1 5{s
    end.
  end.
)

echo */3{.o
exit 0
