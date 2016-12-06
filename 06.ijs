t =: 0 : 0 NB. test case
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar
)

m =: {.@([:\:+/"1@=){~.
n =: {.@([:/:+/"1@=){~.

assert 'easter' -: m"1|:>cutLF t
assert 'advent' -: n"1|:>cutLF t

echo m"1 t =: |:>cutLF CR-.~fread '06.dat'
echo n"1 t

exit 0
