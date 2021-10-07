# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   133.25k (  7.50µs) (± 3.92%)  1.72kB/op  fastest
Int32 10^2 dence    121.92k (  8.20µs) (± 4.47%)  1.72kB/op  fastest
Int32 10^6 sparse     4.23  (236.46ms) (± 5.96%)  12.0MB/op  fastest
Int32 10^6 dence      4.17  (239.93ms) (± 2.40%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.14  (466.31ms) (± 2.81%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.14  (318.91ms) (± 2.88%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   107.45m (  9.31s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.22k (237.00µs) (± 5.95%)  141kB/op  fastest
Int32 1e3          3.71k (269.68µs) (± 5.50%)  141kB/op  fastest
Int32 1e6 sorted   1.05  (956.44ms) (± 4.80%)  137MB/op  fastest
Int32 1e6        630.93m (  1.58s ) (± 3.58%)  137MB/op  fastest
Int32 1e3 * 1e3  967.79m (  1.03s ) (± 0.59%)  137MB/op  fastest
Array 1e6 * 1e2  273.29m (  3.66s ) (± 0.27%)  183MB/op  fastest
class 1e6          1.03  (968.46ms) (± 2.99%)  183MB/op  fastest
SlowC 1e6 * 1e2  112.77m (  8.87s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.90  (256.46ms) (±18.29%)  137MB/op  fastest
Int32 1e5+9e5   4.96  (201.67ms) (±11.17%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.29k (233.06µs) (± 5.44%)  188kB/op  fastest
Int32 1e3          3.18k (314.87µs) (± 5.50%)  188kB/op  fastest
Int32 1e6 sorted 968.04m (  1.03s ) (± 1.18%)  183MB/op  fastest
Int32 1e6        524.38m (  1.91s ) (± 3.09%)  183MB/op  fastest
Int32 1e3 * 1e3  554.81m (  1.80s ) (± 1.28%)  183MB/op  fastest
Array 1e6 * 1e2  230.44m (  4.34s ) (± 1.47%)  244MB/op  fastest
class 1e6        545.50m (  1.83s ) (± 2.75%)  244MB/op  fastest
SlowC 1e6 * 1e2   60.28m ( 16.59s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.31  (188.31ms) (±21.04%)  137MB/op  fastest
Int32 1e5+9e5   6.94  (144.07ms) (±13.38%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.07k (245.98µs) (± 5.39%)  141kB/op  fastest
Int32 1e3          3.33k (300.49µs) (± 4.25%)  141kB/op  fastest
Int32 1e6 sorted   1.07  (937.75ms) (± 2.47%)  137MB/op  fastest
Int32 1e6        583.73m (  1.71s ) (± 1.14%)  137MB/op  fastest
Int32 1e3 * 1e3   12.63  ( 79.19ms) (± 6.44%)  141kB/op  fastest
Array 1e6 * 1e2  261.51m (  3.82s ) (± 2.40%)  183MB/op  fastest
class 1e6         21.20  ( 47.17ms) (± 8.13%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  368.65m (  2.71s ) (± 1.51%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.58  (387.97ms) (±14.72%)  137MB/op  fastest
Int32 1e5+9e5   3.04  (328.55ms) (± 7.26%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.89k (256.81µs) (± 6.44%)  188kB/op  fastest
Int32 1e3          2.93k (341.73µs) (± 5.95%)  188kB/op  fastest
Int32 1e6 sorted 869.81m (  1.15s ) (± 1.96%)  183MB/op  fastest
Int32 1e6        444.13m (  2.25s ) (± 1.05%)  183MB/op  fastest
Int32 1e3 * 1e3    5.16  (193.80ms) (± 4.45%)  137MB/op  fastest
Array 1e6 * 1e2  229.62m (  4.36s ) (± 0.83%)  244MB/op  fastest
class 1e6          7.04  (142.11ms) (±11.24%)  183MB/op  fastest
SlowC 1e6 * 1e2  277.31m (  3.61s ) (± 9.47%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.19  (192.72ms) (±22.36%)  137MB/op  fastest
Int32 1e5+9e5   6.40  (156.15ms) (±13.73%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 293.25  (  3.41ms) (± 4.55%)   106kB/op        fastest
 Scanner.s.to_i8 147.82  (  6.77ms) (± 5.57%)  2.51MB/op   1.98× slower
     Scanner.i16 246.84  (  4.05ms) (± 4.96%)   204kB/op        fastest
Scanner.s.to_i16 122.21  (  8.18ms) (± 7.24%)  3.26MB/op   2.02× slower
     Scanner.i32 199.11  (  5.02ms) (± 6.14%)   399kB/op        fastest
Scanner.s.to_i32  99.59  ( 10.04ms) (± 5.63%)  3.47MB/op   2.00× slower
     Scanner.i64 122.21  (  8.18ms) (± 6.44%)  790kB/op        fastest
Scanner.s.to_i64  75.15  ( 13.31ms) (± 3.90%)  5.3MB/op   1.63× slower
      Scanner.u8 408.96  (  2.45ms) (± 4.34%)   106kB/op        fastest
 Scanner.s.to_u8 139.90  (  7.15ms) (± 5.94%)  2.57MB/op   2.92× slower
     Scanner.u16 438.62  (  2.28ms) (± 5.12%)   204kB/op        fastest
Scanner.s.to_u16 135.56  (  7.38ms) (± 6.19%)  3.26MB/op   3.24× slower
     Scanner.u32 306.73  (  3.26ms) (± 7.50%)   399kB/op        fastest
Scanner.s.to_u32 113.47  (  8.81ms) (± 5.83%)  3.46MB/op   2.70× slower
     Scanner.u64 192.15  (  5.20ms) (± 9.39%)   790kB/op        fastest
Scanner.s.to_u64  86.33  ( 11.58ms) (± 8.04%)  5.31MB/op   2.23× slower
```

