NB. rnd =: 16777216|12820163+1140671485*] NB. 24-bit random number
NB. rnd =: ([:?16777216[[)+16777216*[:?16777216[[ NB. 48-bit random number
rnd =: 281474976710656&|@((128!:4)@1:)

t1 =: 3 : 0
  m =. 1000
  r =. rnd 13477581
  9!:1 m
  a =. 0$0
  c =. 0
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      if. -. r e. a do. a =. a, r else. c =. c+1 end.
    end.
  end.
  echo ($a),c
  n =. 0
  r =. rnd 13477581
  9!:1 m
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      if. (#a)>a i. r   do. n =. n + 1 end.
      if. (#a)>a i. r+1 do. n =. n + 1 end.
    end.
  end.
  echo n
)

t2 =: 3 : 0
  m =. 1000
  r =. rnd 13477581
  9!:1 m
  a =. 0$s:' *'
  c =. 0
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      x =. s:<": r
      if. -. x e. a do. a =. a, x else. c =. c+1 end.
    end.
  end.
  echo ($a),c
  n =. 0
  r =. rnd 13477581
  9!:1 m
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      x =. s:<": r
      if. (#a)>a i. x do. n =. n + 1 end.
      x =. s:<": r+1
      if. (#a)>a i. x do. n =. n + 1 end.
    end.
  end.
  echo n
)

t3 =: 3 : 0
  m =. 1000
  r =. rnd 13477581
  9!:1 m
  a =. 0$0
  c =. 0
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      k =. a I. r
      if. k<#a do.
        if. r~:k{a do.
          a =. (k{.a),r,(k}.a)
        else.
          c =. c+1
        end.
      else.
        a =. a,r
      end.
    end.
  end.
  echo ($a),c
  n =. 0
  r =. rnd 13477581
  9!:1 m
  for_i. i.m do.
    for_j. i.y do.
      r =. rnd r
      k =. a I. r
      if. (#a)>k do. if. r=k{a do. n =. n + 1 end.end.
      k =. a I. r+1
      if. (#a)>k do. if. (r+1)=k{a do. n =. n + 1 end.end.
    end.
  end.
  echo n
)

3 : 0 ''
  n =. 4
  echo '---'
  m1 =. 14.48 for_i. i.n do.  m1 =. m1 <. (6!:2) 't1 50' end. echo '---' [ echo m1
  m2 =. 4.831 for_i. i.n do.  m2 =. m2 <. (6!:2) 't2 50' end. echo '---' [ echo m2
  m3 =. 1.060 for_i. i.n do.  m3 =. m3 <. (6!:2) 't3 50' end. echo '---' [ echo m3
)

NB. 50000 0  50160  14.48  4.880  1.737,1.077

exit 0
