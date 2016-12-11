t =: cutLF CR-.~fread '10.dat'

'E O B' =: 0 0 1 NB. empty value; what:Output, what:Bot
b =: 0 6$0 NB. i-th bot: [lo-what lo-index hi-what hi-index slot1 slot2]
o =: i.0 NB. outputs, empty vector at first

NB. first we build the bot net
3 : 0 t
  for_s. y do. s =. ' 'cut >s
    if. -. 'bot'-:>{.s do. continue. end. NB. do only bots
    'k lk hk' =.".>1 6 11{s NB. all numbers from string
    lo=.('bot'-:> 5{s){O,B
    hi=.('bot'-:>10{s){O,B
    if. k>:#b do. b =: b,((>:k-#b),{:$b)$0 end. NB. expand b if needed
    b =: (lo,lk,hi,hk,E,E) k}b
  end.
)

pv =: 4 : 0 NB. pass value; x - value to set, y - pair what,index
  k=.{:y
  if. O={.y do. NB. output, set value in o
    if. k>:#o do. o =: o,(>:k-#o)$E end. NB. expand o if needed
    if. E~:k{o do. exit##echo 'output already set ',"k,k{o end.
    o =: x k}o
  else. NB. B - bot, set 1st slot, or 2nd slot and then propagate value
    if. k>:#b do. exit##echo 'no such bot ',":k end.
    'lw lx hw hx s1 s2' =. k{b
    if. s1=E do. NB. both slots are empty, let's set the 1st
      b =: x (<k,4)}b
    else.
      if. s2~:E do. exit##echo 'no empty slot ',":k,v,s1,s2 end.
      b =: x (<k,5)}b
      lv =. x <. s1
      hv =. x >. s1
      if. 17 61 -: lv,hv do. echo k end. NB. part 1: catch what was asked!
      lv pv 0 1{k{b
      hv pv 2 3{k{b
    end.
  end.
)

NB. then we spread values
3 : 0 t
  for_s. y do. s =. ' 'cut >s
    if. -. 'value'-:>{.s do. continue. end. NB. process only values
    v pv B,k [ 'v k' =.".>1 5{s
  end.
)

echo */0 1 2{o NB. part 2: multiply outputs

exit 0
