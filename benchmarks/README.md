# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   141.12k (  7.09µs) (± 3.07%)  1.72kB/op  fastest
Int32 10^2 dence    125.59k (  7.96µs) (± 3.11%)  1.72kB/op  fastest
Int32 10^6 sparse     4.63  (215.77ms) (± 4.41%)  12.0MB/op  fastest
Int32 10^6 dence      4.35  (229.81ms) (± 3.05%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.03  (493.08ms) (± 1.28%)  12.0MB/op  fastest
Int32 10^6 dence  R   2.94  (340.44ms) (± 1.77%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   106.02m (  9.43s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.92k (255.32µs) (± 1.08%)  141kB/op  fastest
Int32 1e3          3.21k (311.51µs) (± 0.57%)  141kB/op  fastest
Int32 1e6 sorted 962.87m (  1.04s ) (± 1.18%)  137MB/op  fastest
Int32 1e6        581.09m (  1.72s ) (± 2.94%)  137MB/op  fastest
Int32 1e3 * 1e3    1.12  (896.53ms) (± 0.41%)  137MB/op  fastest
Array 1e6 * 1e2  277.59m (  3.60s ) (± 2.55%)  183MB/op  fastest
class 1e6          1.31  (763.96ms) (± 4.93%)  183MB/op  fastest
SlowC 1e6 * 1e2  108.79m (  9.19s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.76  (265.67ms) (±15.72%)  137MB/op  fastest
Int32 1e5+9e5   4.64  (215.67ms) (± 9.36%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.37k (296.88µs) (± 4.40%)  188kB/op  fastest
Int32 1e3          2.61k (382.67µs) (± 3.73%)  188kB/op  fastest
Int32 1e6 sorted 839.56m (  1.19s ) (± 0.98%)  183MB/op  fastest
Int32 1e6        478.98m (  2.09s ) (± 2.44%)  183MB/op  fastest
Int32 1e3 * 1e3  580.70m (  1.72s ) (± 0.10%)  183MB/op  fastest
Array 1e6 * 1e2  222.03m (  4.50s ) (± 1.42%)  244MB/op  fastest
class 1e6        586.96m (  1.70s ) (± 3.72%)  244MB/op  fastest
SlowC 1e6 * 1e2   55.20m ( 18.12s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.30  (188.56ms) (±22.99%)  137MB/op  fastest
Int32 1e5+9e5   7.07  (141.40ms) (±13.86%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.37k (296.80µs) (± 4.59%)  141kB/op  fastest
Int32 1e3          2.58k (387.72µs) (± 0.87%)  141kB/op  fastest
Int32 1e6 sorted 982.80m (  1.02s ) (± 1.75%)  137MB/op  fastest
Int32 1e6        600.06m (  1.67s ) (± 3.16%)  137MB/op  fastest
Int32 1e3 * 1e3   11.71  ( 85.39ms) (± 2.56%)  141kB/op  fastest
Array 1e6 * 1e2  273.85m (  3.65s ) (± 0.82%)  183MB/op  fastest
class 1e6         18.24  ( 54.84ms) (± 2.15%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  363.00m (  2.75s ) (± 0.79%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.94  (339.74ms) (±13.22%)  137MB/op  fastest
Int32 1e5+9e5   3.45  (290.20ms) (± 7.05%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.40k (293.83µs) (± 3.46%)  188kB/op  fastest
Int32 1e3          2.53k (395.83µs) (± 3.42%)  188kB/op  fastest
Int32 1e6 sorted 828.39m (  1.21s ) (± 0.72%)  183MB/op  fastest
Int32 1e6        469.33m (  2.13s ) (± 0.38%)  183MB/op  fastest
Int32 1e3 * 1e3    5.56  (179.84ms) (± 1.94%)  137MB/op  fastest
Array 1e6 * 1e2  228.52m (  4.38s ) (± 0.75%)  244MB/op  fastest
class 1e6          6.58  (151.94ms) (±10.38%)  183MB/op  fastest
SlowC 1e6 * 1e2  238.61m (  4.19s ) (± 0.17%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.99  (200.56ms) (±27.19%)  137MB/op  fastest
Int32 1e5+9e5   6.81  (146.74ms) (±12.99%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 258.80  (  3.86ms) (± 2.06%)   106kB/op        fastest
 Scanner.s.to_i8 130.52  (  7.66ms) (± 2.19%)  2.51MB/op   1.98× slower
     Scanner.i16 239.32  (  4.18ms) (± 3.13%)   204kB/op        fastest
Scanner.s.to_i16 112.89  (  8.86ms) (± 1.46%)  3.26MB/op   2.12× slower
     Scanner.i32 186.03  (  5.38ms) (± 1.49%)   399kB/op        fastest
Scanner.s.to_i32  92.10  ( 10.86ms) (± 1.42%)  3.46MB/op   2.02× slower
     Scanner.i64 131.05  (  7.63ms) (± 3.43%)  790kB/op        fastest
Scanner.s.to_i64  74.57  ( 13.41ms) (± 3.27%)  5.3MB/op   1.76× slower
      Scanner.u8 378.16  (  2.64ms) (± 2.16%)   106kB/op        fastest
 Scanner.s.to_u8 136.67  (  7.32ms) (± 2.17%)  2.57MB/op   2.77× slower
     Scanner.u16 379.35  (  2.64ms) (± 3.18%)   204kB/op        fastest
Scanner.s.to_u16 127.32  (  7.85ms) (± 2.93%)  3.26MB/op   2.98× slower
     Scanner.u32 272.51  (  3.67ms) (± 1.72%)   399kB/op        fastest
Scanner.s.to_u32  99.87  ( 10.01ms) (± 1.59%)  3.46MB/op   2.73× slower
     Scanner.u64 176.62  (  5.66ms) (± 1.54%)   790kB/op        fastest
Scanner.s.to_u64  68.48  ( 14.60ms) (± 1.52%)  5.31MB/op   2.58× slower
```

