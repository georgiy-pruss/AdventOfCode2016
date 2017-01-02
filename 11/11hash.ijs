e =: 0
s =: 5 4$ 3 0 0 0  0 2 1 0  0 2 1 0  0 2 1 0  0 2 1 0

hash =: 256#.[,4#.]

echo e hash s

ef =: 3
sf =: 5 4$ 0 0 0 3

echo ef hash sf


NB. rnd =: 16777216|12820163+1140671485*] NB. 24-bit random number
NB. rnd =: ([:?16777216[[)+16777216*[:?16777216[[ NB. 48-bit random number
rnd =: 281474976710656&|@((128!:4)@1:)

qq =: 256$0
3 : 0 ''
  for_i. i.4 do.
    for_j. i.4 do.
      k =. (j |. 0 0 0 2) + i|. 0 0 0 1
      NB. p =. 4#.k
      NB. q =. 4#.1 i.~"1|:#: k
      NB. qq =: q p}qq
      qq =: (4#.1 i.~"1|:#: k) (4#.k)}qq
    end.
  end.
)

qqq =: $. qq
echo qqq

hash2 =: 16#.[,qq{~4#.]

echo 1000000 (6!:2) '4#. 0 1 0 2'             NB. 0.935 µs
echo 1000000 (6!:2) '4#.1 i.~"1|:#: 0 1 0 2'  NB. 1.457 µs
echo 1000000 (6!:2) 'qq{~4#. 0 1 0 2'         NB. 1.163 µs
echo 1000000 (6!:2) 'qqq{~4#. 0 1 0 2'        NB. 1.742 µs

echo e hash2 s
echo ef hash2 sf


3 : 0 ''
  for_i. i.4 do.
    for_j. i.4 do.
      k =. (j |. 0 0 0 2) + i|. 0 0 0 1
      p =. 4#.k
      q =. 4#.1 i.~"1|:#: k
      echo (3":q), (3":p{qq), (4":p),'  ', ": k
    end.
  end.
)

exit 0
