# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   216.16k (  4.63µs) (± 0.94%)  1.72kB/op  fastest
Int32 10^2 dence    212.62k (  4.70µs) (± 0.42%)  1.72kB/op  fastest
Int32 10^6 sparse     5.33  (187.70ms) (± 0.44%)  12.0MB/op  fastest
Int32 10^6 dence      4.75  (210.66ms) (± 0.56%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.92  (342.68ms) (± 0.67%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.41  (293.18ms) (± 0.55%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   103.66m (  9.65s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.88k (258.01µs) (± 0.46%)  141kB/op  fastest
Int32 1e3          3.23k (309.96µs) (± 0.44%)  141kB/op  fastest
Int32 1e6 sorted   1.00  (999.90ms) (± 1.68%)  137MB/op  fastest
Int32 1e6        617.21m (  1.62s ) (± 3.41%)  137MB/op  fastest
Int32 1e3 * 1e3    1.13  (881.47ms) (± 1.04%)  137MB/op  fastest
Array 1e6 * 1e2  284.81m (  3.51s ) (± 1.46%)  183MB/op  fastest
class 1e6          1.34  (745.03ms) (± 4.59%)  183MB/op  fastest
SlowC 1e6 * 1e2  106.00m (  9.43s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.77  (265.39ms) (±15.06%)  137MB/op  fastest
Int32 1e5+9e5   4.63  (215.92ms) (± 9.25%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.55k (281.70µs) (± 0.48%)  188kB/op  fastest
Int32 1e3          2.62k (381.82µs) (± 0.52%)  188kB/op  fastest
Int32 1e6 sorted 841.26m (  1.19s ) (± 1.54%)  183MB/op  fastest
Int32 1e6        480.01m (  2.08s ) (± 1.47%)  183MB/op  fastest
Int32 1e3 * 1e3  557.71m (  1.79s ) (± 1.30%)  183MB/op  fastest
Array 1e6 * 1e2  212.28m (  4.71s ) (± 1.36%)  244MB/op  fastest
class 1e6        546.06m (  1.83s ) (± 3.36%)  244MB/op  fastest
SlowC 1e6 * 1e2   53.10m ( 18.83s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.77  (209.79ms) (±27.33%)  137MB/op  fastest
Int32 1e5+9e5   6.62  (150.97ms) (±12.97%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.40k (293.76µs) (± 0.62%)  141kB/op  fastest
Int32 1e3          2.54k (394.28µs) (± 0.54%)  141kB/op  fastest
Int32 1e6 sorted 948.92m (  1.05s ) (± 1.03%)  137MB/op  fastest
Int32 1e6        565.18m (  1.77s ) (± 1.61%)  137MB/op  fastest
Int32 1e3 * 1e3   11.02  ( 90.76ms) (± 0.72%)  141kB/op  fastest
Array 1e6 * 1e2  260.74m (  3.84s ) (± 1.18%)  183MB/op  fastest
class 1e6         17.74  ( 56.38ms) (± 0.92%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  344.32m (  2.90s ) (± 0.13%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.85  (350.37ms) (±13.90%)  137MB/op  fastest
Int32 1e5+9e5   3.40  (294.44ms) (± 7.28%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.56k (280.94µs) (± 0.58%)  188kB/op  fastest
Int32 1e3          2.61k (383.34µs) (± 0.52%)  188kB/op  fastest
Int32 1e6 sorted 860.59m (  1.16s ) (± 1.17%)  183MB/op  fastest
Int32 1e6        481.98m (  2.07s ) (± 0.85%)  183MB/op  fastest
Int32 1e3 * 1e3    5.52  (181.22ms) (± 2.43%)  137MB/op  fastest
Array 1e6 * 1e2  223.56m (  4.47s ) (± 1.21%)  244MB/op  fastest
class 1e6          6.45  (155.14ms) (± 9.59%)  183MB/op  fastest
SlowC 1e6 * 1e2  231.68m (  4.32s ) (± 8.67%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.75  (210.51ms) (±26.44%)  137MB/op  fastest
Int32 1e5+9e5   6.11  (163.71ms) (±22.96%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 248.79  (  4.02ms) (± 1.95%)   106kB/op        fastest
 Scanner.s.to_i8 126.00  (  7.94ms) (± 0.72%)  2.51MB/op   1.97× slower
     Scanner.i16 226.98  (  4.41ms) (± 0.71%)   204kB/op        fastest
Scanner.s.to_i16 111.65  (  8.96ms) (± 0.50%)  3.26MB/op   2.03× slower
     Scanner.i32 182.25  (  5.49ms) (± 0.45%)   399kB/op        fastest
Scanner.s.to_i32  90.24  ( 11.08ms) (± 0.80%)  3.46MB/op   2.02× slower
     Scanner.i64 124.97  (  8.00ms) (± 0.70%)  790kB/op        fastest
Scanner.s.to_i64  68.44  ( 14.61ms) (± 1.09%)  5.3MB/op   1.83× slower
      Scanner.u8 362.71  (  2.76ms) (± 0.58%)   106kB/op        fastest
 Scanner.s.to_u8 131.32  (  7.62ms) (± 0.58%)  2.57MB/op   2.76× slower
     Scanner.u16 352.27  (  2.84ms) (± 0.52%)   204kB/op        fastest
Scanner.s.to_u16 119.89  (  8.34ms) (± 0.57%)  3.26MB/op   2.94× slower
     Scanner.u32 259.19  (  3.86ms) (± 0.31%)   399kB/op        fastest
Scanner.s.to_u32  98.10  ( 10.19ms) (± 0.42%)  3.46MB/op   2.64× slower
     Scanner.u64 173.73  (  5.76ms) (± 0.39%)   790kB/op        fastest
Scanner.s.to_u64  67.03  ( 14.92ms) (± 0.64%)  5.31MB/op   2.59× slower
```

