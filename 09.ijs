t =: (fread'09.dat')-.CRLF
v =: 4 : 0
  b =. y i.'(' if. b=#y do. b return. end.
  's r' =. ".&> 'x' cut (e =. {.t i.')') {. t =. (>:b) }. y
  if. x=1 do. d =. s else. d =. 2 v s{. (>:e) }. t end.
  b + (r*d) + x v (e+1+s) }. t
)
echo 2 v t [ echo 1 v t
exit 0
