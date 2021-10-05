# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   166.01k (  6.02µs) (± 2.63%)  1.72kB/op  fastest
Int32 10^2 dence    151.86k (  6.58µs) (± 3.66%)  1.72kB/op  fastest
Int32 10^6 sparse     5.39  (185.69ms) (± 3.63%)  12.0MB/op  fastest
Int32 10^6 dence      5.07  (197.08ms) (± 2.82%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.41  (414.88ms) (± 3.02%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.48  (287.76ms) (± 2.30%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   127.22m (  7.86s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.60k (217.46µs) (± 4.37%)  141kB/op  fastest
Int32 1e3          3.98k (251.26µs) (± 4.51%)  141kB/op  fastest
Int32 1e6 sorted   1.26  (796.62ms) (± 1.18%)  137MB/op  fastest
Int32 1e6        804.33m (  1.24s ) (± 3.27%)  137MB/op  fastest
Int32 1e3 * 1e3    1.28  (778.92ms) (± 1.06%)  137MB/op  fastest
Array 1e6 * 1e2  337.05m (  2.97s ) (± 0.03%)  183MB/op  fastest
class 1e6          1.68  (595.93ms) (± 4.61%)  183MB/op  fastest
SlowC 1e6 * 1e2  142.14m (  7.04s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.60  (217.27ms) (±17.04%)  137MB/op  fastest
Int32 1e5+9e5   5.35  (186.86ms) (±10.25%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.27k (234.46µs) (± 3.27%)  188kB/op  fastest
Int32 1e3          2.90k (345.10µs) (± 3.53%)  188kB/op  fastest
Int32 1e6 sorted   1.02  (984.62ms) (± 2.01%)  183MB/op  fastest
Int32 1e6        582.28m (  1.72s ) (± 0.63%)  183MB/op  fastest
Int32 1e3 * 1e3  672.75m (  1.49s ) (± 0.61%)  183MB/op  fastest
Array 1e6 * 1e2  256.33m (  3.90s ) (± 2.27%)  244MB/op  fastest
class 1e6        677.47m (  1.48s ) (± 2.69%)  244MB/op  fastest
SlowC 1e6 * 1e2   69.72m ( 14.34s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.00  (166.71ms) (±24.05%)  137MB/op  fastest
Int32 1e5+9e5   7.65  (130.65ms) (±14.32%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.12k (242.64µs) (± 2.93%)  141kB/op  fastest
Int32 1e3          3.16k (316.45µs) (± 4.41%)  141kB/op  fastest
Int32 1e6 sorted   1.17  (856.44ms) (± 1.67%)  137MB/op  fastest
Int32 1e6        730.89m (  1.37s ) (± 3.00%)  137MB/op  fastest
Int32 1e3 * 1e3   13.91  ( 71.91ms) (± 4.04%)  141kB/op  fastest
Array 1e6 * 1e2  315.93m (  3.17s ) (± 0.73%)  183MB/op  fastest
class 1e6         22.34  ( 44.77ms) (± 3.80%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  375.56m (  2.66s ) (± 0.46%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.36  (297.84ms) (±12.31%)  137MB/op  fastest
Int32 1e5+9e5   4.25  (235.31ms) (± 7.88%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.30k (232.46µs) (± 4.77%)  188kB/op  fastest
Int32 1e3          3.30k (303.03µs) (± 3.05%)  188kB/op  fastest
Int32 1e6 sorted   1.03  (967.42ms) (± 2.89%)  183MB/op  fastest
Int32 1e6        530.67m (  1.88s ) (± 4.07%)  183MB/op  fastest
Int32 1e3 * 1e3    6.54  (152.96ms) (± 3.15%)  137MB/op  fastest
Array 1e6 * 1e2  258.32m (  3.87s ) (± 1.60%)  244MB/op  fastest
class 1e6          7.38  (135.45ms) (±10.18%)  183MB/op  fastest
SlowC 1e6 * 1e2  265.97m (  3.76s ) (± 7.31%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.49  (182.09ms) (±28.32%)  137MB/op  fastest
Int32 1e5+9e5   7.70  (129.80ms) (±13.19%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 285.18  (  3.51ms) (± 2.99%)   106kB/op        fastest
 Scanner.s.to_i8 144.37  (  6.93ms) (± 3.56%)  2.52MB/op   1.98× slower
     Scanner.i16 275.07  (  3.64ms) (± 3.60%)   204kB/op        fastest
Scanner.s.to_i16 129.95  (  7.70ms) (± 3.74%)  3.26MB/op   2.12× slower
     Scanner.i32 219.96  (  4.55ms) (± 4.33%)   399kB/op        fastest
Scanner.s.to_i32 112.14  (  8.92ms) (± 4.29%)  3.47MB/op   1.96× slower
     Scanner.i64 152.58  (  6.55ms) (± 6.30%)  790kB/op        fastest
Scanner.s.to_i64  79.56  ( 12.57ms) (± 1.79%)  5.3MB/op   1.92× slower
      Scanner.u8 415.66  (  2.41ms) (± 3.17%)   106kB/op        fastest
 Scanner.s.to_u8 150.00  (  6.67ms) (± 2.30%)  2.57MB/op   2.77× slower
     Scanner.u16 405.32  (  2.47ms) (± 2.28%)   204kB/op        fastest
Scanner.s.to_u16 137.45  (  7.28ms) (± 1.90%)  3.26MB/op   2.95× slower
     Scanner.u32 298.57  (  3.35ms) (± 2.02%)   399kB/op        fastest
Scanner.s.to_u32 113.02  (  8.85ms) (± 1.66%)  3.46MB/op   2.64× slower
     Scanner.u64 202.64  (  4.93ms) (± 2.16%)   790kB/op        fastest
Scanner.s.to_u64  81.83  ( 12.22ms) (± 5.00%)  5.31MB/op   2.48× slower
```

