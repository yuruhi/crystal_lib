# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 137.60k (  7.27µs) (± 4.63%)  1.72kB/op  fastest
Int32 10^2 dence  119.39k (  8.38µs) (± 5.99%)  1.72kB/op  fastest
Int32 10^6 sparse   4.13  (242.00ms) (± 4.29%)  12.0MB/op  fastest
Int32 10^6 dence    4.00  (250.09ms) (± 4.04%)  12.0MB/op  fastest
Array 10^6 * 10^2 524.72m (  1.91s ) (± 1.18%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.69k (213.11µs) (± 5.86%)  141kB/op  fastest
Int32 1e3          4.34k (230.17µs) (± 4.43%)  141kB/op  fastest
Int32 1e6 sorted   1.19  (838.78ms) (± 2.78%)  137MB/op  fastest
Int32 1e6        763.71m (  1.31s ) (± 4.21%)  137MB/op  fastest
Int32 1e3 * 1e3    1.06  (943.56ms) (± 1.05%)  137MB/op  fastest
Array 1e6 * 1e2  321.45m (  3.11s ) (± 0.18%)  183MB/op  fastest
class 1e6          1.16  (862.35ms) (± 3.98%)  183MB/op  fastest
SlowC 1e6 * 1e2  135.68m (  7.37s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.23  (236.38ms) (±17.72%)  137MB/op  fastest
Int32 1e5+9e5   5.30  (188.76ms) (±10.20%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.51k (221.65µs) (± 4.65%)  188kB/op  fastest
Int32 1e3          3.34k (299.62µs) (± 4.55%)  188kB/op  fastest
Int32 1e6 sorted 984.99m (  1.02s ) (± 5.34%)  183MB/op  fastest
Int32 1e6        544.01m (  1.84s ) (± 5.01%)  183MB/op  fastest
Int32 1e3 * 1e3  588.71m (  1.70s ) (± 1.47%)  183MB/op  fastest
Array 1e6 * 1e2  242.59m (  4.12s ) (± 1.71%)  244MB/op  fastest
class 1e6        560.38m (  1.78s ) (± 4.71%)  244MB/op  fastest
SlowC 1e6 * 1e2   63.93m ( 15.64s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.63  (177.60ms) (±22.14%)  137MB/op  fastest
Int32 1e5+9e5   7.45  (134.28ms) (±14.43%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.23k (236.54µs) (± 4.77%)  141kB/op  fastest
Int32 1e3          3.36k (297.63µs) (± 4.61%)  141kB/op  fastest
Int32 1e6 sorted   1.12  (893.31ms) (± 2.69%)  137MB/op  fastest
Int32 1e6        689.50m (  1.45s ) (± 2.86%)  137MB/op  fastest
Int32 1e3 * 1e3   14.81  ( 67.53ms) (± 4.35%)  141kB/op  fastest
Array 1e6 * 1e2  299.45m (  3.34s ) (± 1.56%)  183MB/op  fastest
class 1e6         25.40  ( 39.37ms) (± 5.44%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  421.58m (  2.37s ) (± 1.26%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.18  (314.49ms) (±18.32%)  137MB/op  fastest
Int32 1e5+9e5   3.74  (267.27ms) (± 9.05%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.45k (224.76µs) (± 5.22%)  188kB/op  fastest
Int32 1e3          3.17k (315.61µs) (± 6.26%)  188kB/op  fastest
Int32 1e6 sorted 952.92m (  1.05s ) (± 4.31%)  183MB/op  fastest
Int32 1e6        542.17m (  1.84s ) (± 2.04%)  183MB/op  fastest
Int32 1e3 * 1e3    5.89  (169.70ms) (± 3.61%)  137MB/op  fastest
Array 1e6 * 1e2  241.39m (  4.14s ) (± 0.68%)  244MB/op  fastest
class 1e6          7.41  (134.96ms) (±12.41%)  183MB/op  fastest
SlowC 1e6 * 1e2  265.49m (  3.77s ) (± 3.26%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.18  (193.22ms) (±25.99%)  137MB/op  fastest
Int32 1e5+9e5   7.05  (141.85ms) (±15.89%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 313.45  (  3.19ms) (± 4.38%)   106kB/op        fastest
 Scanner.s.to_i8 157.83  (  6.34ms) (± 4.74%)  2.51MB/op   1.99× slower
     Scanner.i16 287.47  (  3.48ms) (± 2.85%)   204kB/op        fastest
Scanner.s.to_i16 143.79  (  6.95ms) (± 5.07%)  3.26MB/op   2.00× slower
     Scanner.i32 224.49  (  4.45ms) (± 5.19%)   399kB/op        fastest
Scanner.s.to_i32 117.72  (  8.50ms) (± 5.85%)  3.46MB/op   1.91× slower
     Scanner.i64 146.90  (  6.81ms) (± 6.07%)  790kB/op        fastest
Scanner.s.to_i64  97.12  ( 10.30ms) (± 3.68%)  5.3MB/op   1.51× slower
      Scanner.u8 503.59  (  1.99ms) (± 4.84%)   106kB/op        fastest
 Scanner.s.to_u8 164.50  (  6.08ms) (± 5.42%)  2.57MB/op   3.06× slower
     Scanner.u16 499.15  (  2.00ms) (± 4.05%)   204kB/op        fastest
Scanner.s.to_u16 156.22  (  6.40ms) (± 4.61%)  3.27MB/op   3.20× slower
     Scanner.u32 344.70  (  2.90ms) (± 4.42%)   399kB/op        fastest
Scanner.s.to_u32 129.35  (  7.73ms) (± 5.07%)  3.47MB/op   2.66× slower
     Scanner.u64 209.18  (  4.78ms) (± 5.76%)   790kB/op        fastest
Scanner.s.to_u64  94.18  ( 10.62ms) (± 4.65%)  5.31MB/op   2.22× slower
```

