# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   130.57k (  7.66µs) (± 4.49%)  1.72kB/op  fastest
Int32 10^2 dence    115.95k (  8.62µs) (± 4.32%)  1.72kB/op  fastest
Int32 10^6 sparse     4.08  (244.92ms) (± 2.67%)  12.0MB/op  fastest
Int32 10^6 dence      3.85  (259.84ms) (± 5.48%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.00  (501.10ms) (± 3.14%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.06  (327.09ms) (± 2.22%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   111.48m (  8.97s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.41k (226.81µs) (± 5.04%)  141kB/op  fastest
Int32 1e3          3.77k (265.04µs) (± 6.39%)  141kB/op  fastest
Int32 1e6 sorted   1.17  (855.61ms) (± 2.78%)  137MB/op  fastest
Int32 1e6        654.60m (  1.53s ) (± 3.39%)  137MB/op  fastest
Int32 1e3 * 1e3  954.88m (  1.05s ) (± 2.07%)  137MB/op  fastest
Array 1e6 * 1e2  303.69m (  3.29s ) (± 0.23%)  183MB/op  fastest
class 1e6          1.05  (953.22ms) (± 3.27%)  183MB/op  fastest
SlowC 1e6 * 1e2  126.13m (  7.93s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.99  (250.62ms) (±13.76%)  137MB/op  fastest
Int32 1e5+9e5   4.90  (204.05ms) (±10.23%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.23k (236.18µs) (± 5.20%)  188kB/op  fastest
Int32 1e3          3.06k (327.32µs) (± 4.96%)  188kB/op  fastest
Int32 1e6 sorted 921.69m (  1.08s ) (± 2.19%)  183MB/op  fastest
Int32 1e6        535.82m (  1.87s ) (± 0.83%)  183MB/op  fastest
Int32 1e3 * 1e3  546.12m (  1.83s ) (± 2.36%)  183MB/op  fastest
Array 1e6 * 1e2  231.10m (  4.33s ) (± 0.90%)  244MB/op  fastest
class 1e6        528.69m (  1.89s ) (± 3.46%)  244MB/op  fastest
SlowC 1e6 * 1e2   60.44m ( 16.55s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.39  (185.48ms) (±30.15%)  137MB/op  fastest
Int32 1e5+9e5   6.51  (153.62ms) (±21.51%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.85k (259.92µs) (± 4.70%)  141kB/op  fastest
Int32 1e3          3.16k (316.17µs) (± 5.45%)  141kB/op  fastest
Int32 1e6 sorted   1.05  (954.60ms) (± 1.26%)  137MB/op  fastest
Int32 1e6        619.66m (  1.61s ) (± 2.44%)  137MB/op  fastest
Int32 1e3 * 1e3   13.81  ( 72.43ms) (± 5.30%)  141kB/op  fastest
Array 1e6 * 1e2  277.37m (  3.61s ) (± 1.26%)  183MB/op  fastest
class 1e6         23.32  ( 42.89ms) (± 5.22%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  386.25m (  2.59s ) (± 2.43%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.79  (358.35ms) (±11.01%)  137MB/op  fastest
Int32 1e5+9e5   3.09  (323.93ms) (± 7.00%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.11k (243.35µs) (± 4.55%)  188kB/op  fastest
Int32 1e3          3.14k (318.37µs) (± 5.81%)  188kB/op  fastest
Int32 1e6 sorted 894.81m (  1.12s ) (± 2.40%)  183MB/op  fastest
Int32 1e6        481.58m (  2.08s ) (± 0.73%)  183MB/op  fastest
Int32 1e3 * 1e3    5.57  (179.41ms) (± 3.93%)  137MB/op  fastest
Array 1e6 * 1e2  228.09m (  4.38s ) (± 3.15%)  244MB/op  fastest
class 1e6          7.06  (141.68ms) (±11.30%)  183MB/op  fastest
SlowC 1e6 * 1e2  250.71m (  3.99s ) (± 2.44%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.21  (191.76ms) (±22.06%)  137MB/op  fastest
Int32 1e5+9e5   6.92  (144.50ms) (±14.30%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 297.86  (  3.36ms) (± 4.95%)   106kB/op        fastest
 Scanner.s.to_i8 142.80  (  7.00ms) (± 4.17%)  2.51MB/op   2.09× slower
     Scanner.i16 256.28  (  3.90ms) (± 5.78%)   204kB/op        fastest
Scanner.s.to_i16 118.15  (  8.46ms) (± 4.91%)  3.26MB/op   2.17× slower
     Scanner.i32 196.38  (  5.09ms) (± 3.99%)   399kB/op        fastest
Scanner.s.to_i32 104.01  (  9.61ms) (± 3.23%)  3.46MB/op   1.89× slower
     Scanner.i64 128.68  (  7.77ms) (± 5.71%)  790kB/op        fastest
Scanner.s.to_i64  81.78  ( 12.23ms) (± 5.71%)  5.3MB/op   1.57× slower
      Scanner.u8 452.14  (  2.21ms) (± 3.84%)   106kB/op        fastest
 Scanner.s.to_u8 150.00  (  6.67ms) (± 4.04%)  2.57MB/op   3.01× slower
     Scanner.u16 446.22  (  2.24ms) (± 4.41%)   204kB/op        fastest
Scanner.s.to_u16 133.85  (  7.47ms) (± 3.58%)  3.26MB/op   3.33× slower
     Scanner.u32 309.39  (  3.23ms) (± 2.90%)   399kB/op        fastest
Scanner.s.to_u32 114.41  (  8.74ms) (± 3.20%)  3.47MB/op   2.70× slower
     Scanner.u64 185.01  (  5.41ms) (± 4.77%)   790kB/op        fastest
Scanner.s.to_u64  79.06  ( 12.65ms) (± 4.09%)  5.31MB/op   2.34× slower
```

