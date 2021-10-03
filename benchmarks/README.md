# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 110.05k (  9.09µs) (± 1.26%)  1.72kB/op  fastest
Int32 10^2 dence   97.25k ( 10.28µs) (± 0.35%)  1.72kB/op  fastest
Int32 10^6 sparse   3.46  (289.12ms) (± 0.38%)  12.0MB/op  fastest
Int32 10^6 dence    3.31  (301.85ms) (± 0.12%)  12.0MB/op  fastest
Array 10^6 * 10^2 449.04m (  2.23s ) (± 0.68%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.86k (258.96µs) (± 1.46%)  141kB/op  fastest
Int32 1e3          3.22k (310.35µs) (± 0.62%)  141kB/op  fastest
Int32 1e6 sorted   1.02  (980.85ms) (± 1.71%)  137MB/op  fastest
Int32 1e6        605.11m (  1.65s ) (± 2.34%)  137MB/op  fastest
Int32 1e3 * 1e3    1.15  (867.83ms) (± 1.40%)  137MB/op  fastest
Array 1e6 * 1e2  286.63m (  3.49s ) (± 0.48%)  183MB/op  fastest
class 1e6          1.31  (762.94ms) (± 4.28%)  183MB/op  fastest
SlowC 1e6 * 1e2  102.33m (  9.77s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.75  (266.40ms) (±15.02%)  137MB/op  fastest
Int32 1e5+9e5   4.61  (216.92ms) (± 8.90%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.50k (285.42µs) (± 0.37%)  188kB/op  fastest
Int32 1e3          2.61k (383.61µs) (± 0.43%)  188kB/op  fastest
Int32 1e6 sorted 800.01m (  1.25s ) (± 1.88%)  183MB/op  fastest
Int32 1e6        465.60m (  2.15s ) (± 1.00%)  183MB/op  fastest
Int32 1e3 * 1e3  556.68m (  1.80s ) (± 1.13%)  183MB/op  fastest
Array 1e6 * 1e2  211.37m (  4.73s ) (± 0.66%)  244MB/op  fastest
class 1e6        553.60m (  1.81s ) (± 2.27%)  244MB/op  fastest
SlowC 1e6 * 1e2   53.22m ( 18.79s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.09  (196.39ms) (±22.35%)  137MB/op  fastest
Int32 1e5+9e5   6.68  (149.72ms) (±12.62%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.36k (297.92µs) (± 0.60%)  141kB/op  fastest
Int32 1e3          2.53k (394.90µs) (± 1.01%)  141kB/op  fastest
Int32 1e6 sorted 959.64m (  1.04s ) (± 2.88%)  137MB/op  fastest
Int32 1e6        560.04m (  1.79s ) (± 1.51%)  137MB/op  fastest
Int32 1e3 * 1e3   11.03  ( 90.67ms) (± 0.74%)  141kB/op  fastest
Array 1e6 * 1e2  257.39m (  3.89s ) (± 0.12%)  183MB/op  fastest
class 1e6         17.70  ( 56.49ms) (± 0.76%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  328.66m (  3.04s ) (± 0.06%)  427kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.09  (323.18ms) (±13.93%)  137MB/op  fastest
Int32 1e5+9e5   3.35  (298.19ms) (±11.24%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.56k (281.14µs) (± 0.48%)  188kB/op  fastest
Int32 1e3          2.61k (383.37µs) (± 0.72%)  188kB/op  fastest
Int32 1e6 sorted 874.85m (  1.14s ) (± 1.98%)  183MB/op  fastest
Int32 1e6        489.25m (  2.04s ) (± 1.93%)  183MB/op  fastest
Int32 1e3 * 1e3    5.53  (180.87ms) (± 2.06%)  137MB/op  fastest
Array 1e6 * 1e2  223.77m (  4.47s ) (± 0.30%)  244MB/op  fastest
class 1e6          6.40  (156.35ms) (±10.02%)  183MB/op  fastest
SlowC 1e6 * 1e2  243.23m (  4.11s ) (± 0.14%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.56  (219.26ms) (±28.21%)  137MB/op  fastest
Int32 1e5+9e5   6.39  (156.59ms) (±13.31%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 258.33  (  3.87ms) (± 0.95%)   106kB/op        fastest
 Scanner.s.to_i8 129.05  (  7.75ms) (± 0.83%)  2.51MB/op   2.00× slower
     Scanner.i16 234.89  (  4.26ms) (± 1.22%)   204kB/op        fastest
Scanner.s.to_i16 112.54  (  8.89ms) (± 1.13%)  3.26MB/op   2.09× slower
     Scanner.i32 183.32  (  5.45ms) (± 1.05%)   399kB/op        fastest
Scanner.s.to_i32  91.90  ( 10.88ms) (± 1.02%)  3.46MB/op   1.99× slower
     Scanner.i64 124.38  (  8.04ms) (± 0.98%)  790kB/op        fastest
Scanner.s.to_i64  68.65  ( 14.57ms) (± 1.06%)  5.3MB/op   1.81× slower
      Scanner.u8 378.78  (  2.64ms) (± 1.00%)   106kB/op        fastest
 Scanner.s.to_u8 134.58  (  7.43ms) (± 0.85%)  2.57MB/op   2.81× slower
     Scanner.u16 418.54  (  2.39ms) (± 0.99%)   204kB/op        fastest
Scanner.s.to_u16 121.43  (  8.24ms) (± 1.60%)  3.26MB/op   3.45× slower
     Scanner.u32 324.58  (  3.08ms) (± 0.81%)   399kB/op        fastest
Scanner.s.to_u32  97.47  ( 10.26ms) (± 1.11%)  3.46MB/op   3.33× slower
     Scanner.u64 189.92  (  5.27ms) (± 0.89%)   790kB/op        fastest
Scanner.s.to_u64  67.53  ( 14.81ms) (± 1.00%)  5.31MB/op   2.81× slower
```

