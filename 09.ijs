t =: (fread'09.dat')-.CRLF

v =: 4 : 0
  p =. 0 NB. current position in string y
  o =. 0 NB. counted length
  for_b. '(' ss y do. NB. b - positions of '(' in y
    if. b<p do. continue. end. NB. skip (...) that were done recursively
    o =. o + b-p NB. count span to this '('
    t =. (>:b) }. y NB. tail after '('
    e =. {.')'ss t NB. find ')' - marker end
    's r' =. ".&>'x'cut e{.t NB. get span and repeat numbers
    if. x=1 do. o =. o + s*r NB. part 1 - no recursion
    else. o =. o + r*(2 v s{. (>:e) }. t) NB. part 2 - re-process that span
    end.
    p =. b+e+2+s NB. advance
  end.
  o + (#y) - p
)

echo 1 v t
echo 2 v t
exit 0
