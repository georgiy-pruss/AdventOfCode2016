t =: cutLF CR-.~fread '04.dat'
a =: a.{~97+i.26                        NB. 'abc...z'
c =: 5{.a\:[:+/"1 a=/[:/:~_10}.'-'-.~]  NB. calculate checksum string
v =: c -: _1}._6&{.                     NB. checksums match = good string
n =: [:".3{._10{.]                      NB. extract number (id)
s =: 4 :'((26|x+])&.(_97+a.i.]))"0 y'   NB. shift cypher, n s 'str'
p =. +./@('north' E. n s ])             NB. if decrypted string contains 'north'
echo +/(n*v)&> t                        NB. sum of ids of good strings
echo +/(n*p)&> t                        NB. sum of ids of strings with 'north'
exit 0                                  NB. ^^^ we assume such string is only one
