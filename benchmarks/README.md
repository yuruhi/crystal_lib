# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   127.86k (  7.82µs) (± 3.88%)  1.72kB/op  fastest
Int32 10^2 dence    117.18k (  8.53µs) (± 3.03%)  1.72kB/op  fastest
Int32 10^6 sparse     3.91  (255.69ms) (± 4.81%)  12.0MB/op  fastest
Int32 10^6 dence      3.78  (264.36ms) (± 7.09%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.00  (499.75ms) (± 2.49%)  12.0MB/op  fastest
Int32 10^6 dence  R   2.90  (345.27ms) (± 2.86%)  12.0MB/op  fastest
SlowC 10^6 * 10^2    97.89m ( 10.22s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.31k (231.90µs) (± 4.32%)  141kB/op  fastest
Int32 1e3          3.76k (265.79µs) (± 2.70%)  141kB/op  fastest
Int32 1e6 sorted 894.65m (  1.12s ) (± 2.65%)  137MB/op  fastest
Int32 1e6        491.67m (  2.03s ) (± 2.86%)  137MB/op  fastest
Int32 1e3 * 1e3  685.11m (  1.46s ) (± 0.61%)  137MB/op  fastest
Array 1e6 * 1e2  196.73m (  5.08s ) (± 0.00%)  183MB/op  fastest
class 1e6        715.79m (  1.40s ) (± 2.61%)  183MB/op  fastest
SlowC 1e6 * 1e2   98.73m ( 10.13s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.59  (278.57ms) (±17.22%)  137MB/op  fastest
Int32 1e5+9e5   4.46  (224.26ms) (± 9.08%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.00k (249.69µs) (± 2.02%)  188kB/op  fastest
Int32 1e3          2.96k (337.65µs) (± 3.80%)  188kB/op  fastest
Int32 1e6 sorted 715.63m (  1.40s ) (± 2.06%)  183MB/op  fastest
Int32 1e6        350.66m (  2.85s ) (± 1.48%)  183MB/op  fastest
Int32 1e3 * 1e3  362.27m (  2.76s ) (± 1.08%)  183MB/op  fastest
Array 1e6 * 1e2  136.85m (  7.31s ) (± 0.00%)  244MB/op  fastest
class 1e6        351.53m (  2.84s ) (± 2.21%)  244MB/op  fastest
SlowC 1e6 * 1e2   52.17m ( 19.17s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.74  (210.75ms) (±24.71%)  137MB/op  fastest
Int32 1e5+9e5   6.12  (163.29ms) (±25.75%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.76k (266.14µs) (± 2.80%)  141kB/op  fastest
Int32 1e3          2.98k (335.04µs) (± 2.36%)  141kB/op  fastest
Int32 1e6 sorted 812.83m (  1.23s ) (± 3.08%)  137MB/op  fastest
Int32 1e6        457.80m (  2.18s ) (± 2.11%)  137MB/op  fastest
Int32 1e3 * 1e3   12.35  ( 80.94ms) (± 3.65%)  141kB/op  fastest
Array 1e6 * 1e2  182.28m (  5.49s ) (± 0.00%)  183MB/op  fastest
class 1e6         20.98  ( 47.67ms) (± 3.39%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  367.51m (  2.72s ) (± 0.26%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.68  (373.60ms) (±11.53%)  137MB/op  fastest
Int32 1e5+9e5   3.16  (316.74ms) (± 6.63%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.94k (253.67µs) (± 3.37%)  188kB/op  fastest
Int32 1e3          2.93k (341.54µs) (± 2.76%)  188kB/op  fastest
Int32 1e6 sorted 693.07m (  1.44s ) (± 0.77%)  183MB/op  fastest
Int32 1e6        343.71m (  2.91s ) (± 1.57%)  183MB/op  fastest
Int32 1e3 * 1e3    5.10  (196.11ms) (± 2.89%)  137MB/op  fastest
Array 1e6 * 1e2  134.84m (  7.42s ) (± 0.00%)  244MB/op  fastest
class 1e6          6.77  (147.80ms) (±11.71%)  183MB/op  fastest
SlowC 1e6 * 1e2  268.27m (  3.73s ) (± 8.29%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.77  (209.56ms) (±25.59%)  137MB/op  fastest
Int32 1e5+9e5   6.56  (152.36ms) (±15.22%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 266.68  (  3.75ms) (± 2.61%)   106kB/op        fastest
 Scanner.s.to_i8 135.30  (  7.39ms) (± 2.25%)  2.52MB/op   1.97× slower
     Scanner.i16 246.82  (  4.05ms) (± 4.04%)   204kB/op        fastest
Scanner.s.to_i16 124.15  (  8.05ms) (± 4.67%)  3.26MB/op   1.99× slower
     Scanner.i32 193.78  (  5.16ms) (± 3.16%)   399kB/op        fastest
Scanner.s.to_i32 101.20  (  9.88ms) (± 3.20%)  3.46MB/op   1.91× slower
     Scanner.i64 130.34  (  7.67ms) (± 3.79%)  790kB/op        fastest
Scanner.s.to_i64  79.81  ( 12.53ms) (± 3.51%)  5.3MB/op   1.63× slower
      Scanner.u8 443.57  (  2.25ms) (± 3.20%)   106kB/op        fastest
 Scanner.s.to_u8 141.71  (  7.06ms) (± 2.79%)  2.57MB/op   3.13× slower
     Scanner.u16 437.46  (  2.29ms) (± 2.76%)   204kB/op        fastest
Scanner.s.to_u16 134.85  (  7.42ms) (± 3.09%)  3.26MB/op   3.24× slower
     Scanner.u32 298.40  (  3.35ms) (± 3.04%)   399kB/op        fastest
Scanner.s.to_u32 104.17  (  9.60ms) (± 4.42%)  3.46MB/op   2.86× slower
     Scanner.u64 185.91  (  5.38ms) (± 3.08%)  790kB/op        fastest
Scanner.s.to_u64  80.17  ( 12.47ms) (± 2.97%)  5.3MB/op   2.32× slower
```

