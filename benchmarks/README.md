# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   133.89k (  7.47µs) (± 4.67%)  1.72kB/op  fastest
Int32 10^2 dence    123.77k (  8.08µs) (± 5.25%)  1.72kB/op  fastest
Int32 10^6 sparse     4.53  (220.71ms) (± 6.53%)  12.0MB/op  fastest
Int32 10^6 dence      4.75  (210.38ms) (± 6.43%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.41  (414.52ms) (± 2.63%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.56  (280.53ms) (± 3.24%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   117.30m (  8.53s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.49k (222.74µs) (± 5.47%)  141kB/op  fastest
Int32 1e3          3.69k (271.11µs) (± 6.21%)  141kB/op  fastest
Int32 1e6 sorted   1.11  (901.88ms) (± 3.43%)  137MB/op  fastest
Int32 1e6        703.71m (  1.42s ) (± 2.65%)  137MB/op  fastest
Int32 1e3 * 1e3    1.05  (952.59ms) (± 1.85%)  137MB/op  fastest
Array 1e6 * 1e2  327.17m (  3.06s ) (± 0.18%)  183MB/op  fastest
class 1e6          1.19  (842.65ms) (± 4.11%)  183MB/op  fastest
SlowC 1e6 * 1e2  135.98m (  7.35s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.17  (239.63ms) (±15.84%)  137MB/op  fastest
Int32 1e5+9e5   5.35  (186.93ms) (± 9.97%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.58k (218.50µs) (± 5.82%)  188kB/op  fastest
Int32 1e3          3.34k (299.22µs) (± 6.21%)  188kB/op  fastest
Int32 1e6 sorted   1.03  (973.81ms) (± 2.41%)  183MB/op  fastest
Int32 1e6        588.02m (  1.70s ) (± 1.47%)  183MB/op  fastest
Int32 1e3 * 1e3  593.83m (  1.68s ) (± 1.42%)  183MB/op  fastest
Array 1e6 * 1e2  256.38m (  3.90s ) (± 0.61%)  244MB/op  fastest
class 1e6        581.56m (  1.72s ) (± 3.79%)  244MB/op  fastest
SlowC 1e6 * 1e2   62.65m ( 15.96s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.58  (179.06ms) (±35.26%)  137MB/op  fastest
Int32 1e5+9e5   6.85  (145.89ms) (±14.28%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.80k (262.86µs) (± 4.65%)  141kB/op  fastest
Int32 1e3          3.08k (325.09µs) (± 6.92%)  141kB/op  fastest
Int32 1e6 sorted   1.02  (976.15ms) (± 1.28%)  137MB/op  fastest
Int32 1e6        625.16m (  1.60s ) (± 3.38%)  137MB/op  fastest
Int32 1e3 * 1e3   12.73  ( 78.54ms) (± 5.99%)  141kB/op  fastest
Array 1e6 * 1e2  295.04m (  3.39s ) (± 4.41%)  183MB/op  fastest
class 1e6         24.45  ( 40.90ms) (± 5.96%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  413.33m (  2.42s ) (± 1.31%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.98  (336.10ms) (±13.53%)  137MB/op  fastest
Int32 1e5+9e5   3.42  (292.60ms) (± 7.11%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.41k (227.00µs) (± 6.27%)  188kB/op  fastest
Int32 1e3          3.23k (309.62µs) (± 5.65%)  188kB/op  fastest
Int32 1e6 sorted 980.53m (  1.02s ) (± 2.63%)  183MB/op  fastest
Int32 1e6        503.53m (  1.99s ) (± 1.77%)  183MB/op  fastest
Int32 1e3 * 1e3    5.66  (176.53ms) (± 5.01%)  137MB/op  fastest
Array 1e6 * 1e2  237.01m (  4.22s ) (± 1.20%)  244MB/op  fastest
class 1e6          7.02  (142.45ms) (±12.75%)  183MB/op  fastest
SlowC 1e6 * 1e2  274.68m (  3.64s ) (± 0.64%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.79  (208.85ms) (±21.94%)  137MB/op  fastest
Int32 1e5+9e5   6.39  (156.53ms) (±13.72%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 307.39  (  3.25ms) (± 7.42%)   106kB/op        fastest
 Scanner.s.to_i8 149.68  (  6.68ms) (± 6.67%)  2.52MB/op   2.05× slower
     Scanner.i16 273.80  (  3.65ms) (± 7.70%)   204kB/op        fastest
Scanner.s.to_i16 139.47  (  7.17ms) (± 6.55%)  3.26MB/op   1.96× slower
     Scanner.i32 233.17  (  4.29ms) (± 6.92%)   399kB/op        fastest
Scanner.s.to_i32 124.94  (  8.00ms) (± 5.36%)  3.46MB/op   1.87× slower
     Scanner.i64 147.51  (  6.78ms) (± 7.06%)  790kB/op        fastest
Scanner.s.to_i64  91.58  ( 10.92ms) (± 7.69%)  5.3MB/op   1.61× slower
      Scanner.u8 490.66  (  2.04ms) (± 5.12%)   106kB/op        fastest
 Scanner.s.to_u8 165.24  (  6.05ms) (± 6.40%)  2.57MB/op   2.97× slower
     Scanner.u16 461.69  (  2.17ms) (± 4.50%)   204kB/op        fastest
Scanner.s.to_u16 147.93  (  6.76ms) (± 4.85%)  3.26MB/op   3.12× slower
     Scanner.u32 308.96  (  3.24ms) (± 6.56%)   399kB/op        fastest
Scanner.s.to_u32 120.12  (  8.32ms) (± 6.17%)  3.46MB/op   2.57× slower
     Scanner.u64 190.10  (  5.26ms) (± 5.76%)   790kB/op        fastest
Scanner.s.to_u64  84.11  ( 11.89ms) (± 4.38%)  5.31MB/op   2.26× slower
```

