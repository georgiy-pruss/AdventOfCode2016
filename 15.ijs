f =: 1&{@] | {:@] + [ + {.@]
d =: 1 17 1, 2 7 0, 3 19 2, 4 5 0, 5 3 0,:6 13 5
e =: d,7 11 0
echo I. ([:*/0=((f)"1)&d)"0 (i.*/1{"1 d)
echo I. ([:*/0=((f)"1)&e)"0 (i.*/1{"1 e)
exit 0