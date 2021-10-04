# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   148.82k (  6.72µs) (± 0.10%)  1.72kB/op  fastest
Int32 10^2 dence    137.01k (  7.30µs) (± 0.19%)  1.72kB/op  fastest
Int32 10^6 sparse     4.82  (207.39ms) (± 0.98%)  12.0MB/op  fastest
Int32 10^6 dence      4.59  (218.06ms) (± 0.07%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.14  (467.56ms) (± 0.66%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.14  (318.97ms) (± 0.08%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   126.54m (  7.90s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.60k (217.18µs) (± 0.17%)  141kB/op  fastest
Int32 1e3          3.86k (259.04µs) (± 0.20%)  141kB/op  fastest
Int32 1e6 sorted   1.16  (861.84ms) (± 2.58%)  137MB/op  fastest
Int32 1e6        734.77m (  1.36s ) (± 4.50%)  137MB/op  fastest
Int32 1e3 * 1e3    1.27  (789.26ms) (± 1.27%)  137MB/op  fastest
Array 1e6 * 1e2  317.88m (  3.15s ) (± 0.41%)  183MB/op  fastest
class 1e6          1.55  (643.63ms) (± 5.06%)  183MB/op  fastest
SlowC 1e6 * 1e2  135.98m (  7.35s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.40  (227.14ms) (±15.58%)  137MB/op  fastest
Int32 1e5+9e5   5.40  (185.19ms) (± 9.27%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.18k (239.19µs) (± 0.19%)  188kB/op  fastest
Int32 1e3          3.12k (320.98µs) (± 0.30%)  188kB/op  fastest
Int32 1e6 sorted 982.29m (  1.02s ) (± 1.57%)  183MB/op  fastest
Int32 1e6        567.95m (  1.76s ) (± 0.45%)  183MB/op  fastest
Int32 1e3 * 1e3  657.18m (  1.52s ) (± 1.09%)  183MB/op  fastest
Array 1e6 * 1e2  238.62m (  4.19s ) (± 0.07%)  244MB/op  fastest
class 1e6        647.06m (  1.55s ) (± 3.63%)  244MB/op  fastest
SlowC 1e6 * 1e2   67.15m ( 14.89s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.96  (167.88ms) (±22.90%)  137MB/op  fastest
Int32 1e5+9e5   7.82  (127.93ms) (±12.90%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.99k (250.70µs) (± 0.17%)  141kB/op  fastest
Int32 1e3          3.04k (329.43µs) (± 0.11%)  141kB/op  fastest
Int32 1e6 sorted   1.06  (940.61ms) (± 1.65%)  137MB/op  fastest
Int32 1e6        651.96m (  1.53s ) (± 2.16%)  137MB/op  fastest
Int32 1e3 * 1e3   13.20  ( 75.74ms) (± 0.50%)  141kB/op  fastest
Array 1e6 * 1e2  291.72m (  3.43s ) (± 0.83%)  183MB/op  fastest
class 1e6         21.12  ( 47.35ms) (± 0.48%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  391.84m (  2.55s ) (± 0.04%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.33  (300.62ms) (±13.61%)  137MB/op  fastest
Int32 1e5+9e5   3.99  (250.79ms) (± 7.12%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.22k (237.07µs) (± 0.59%)  188kB/op  fastest
Int32 1e3          3.11k (321.69µs) (± 0.15%)  188kB/op  fastest
Int32 1e6 sorted 950.51m (  1.05s ) (± 1.97%)  183MB/op  fastest
Int32 1e6        533.81m (  1.87s ) (± 0.80%)  183MB/op  fastest
Int32 1e3 * 1e3    6.44  (155.18ms) (± 2.24%)  137MB/op  fastest
Array 1e6 * 1e2  246.60m (  4.06s ) (± 0.04%)  244MB/op  fastest
class 1e6          7.32  (136.55ms) (±10.63%)  183MB/op  fastest
SlowC 1e6 * 1e2  258.25m (  3.87s ) (± 4.27%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.20  (192.38ms) (±28.77%)  137MB/op  fastest
Int32 1e5+9e5   7.43  (134.57ms) (±14.39%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 298.17  (  3.35ms) (± 0.12%)   106kB/op        fastest
 Scanner.s.to_i8 150.45  (  6.65ms) (± 0.13%)  2.51MB/op   1.98× slower
     Scanner.i16 270.95  (  3.69ms) (± 0.13%)   204kB/op        fastest
Scanner.s.to_i16 132.33  (  7.56ms) (± 0.49%)  3.26MB/op   2.05× slower
     Scanner.i32 217.91  (  4.59ms) (± 0.17%)   399kB/op        fastest
Scanner.s.to_i32 108.72  (  9.20ms) (± 0.34%)  3.47MB/op   2.00× slower
     Scanner.i64 149.31  (  6.70ms) (± 0.28%)   790kB/op        fastest
Scanner.s.to_i64  82.68  ( 12.09ms) (± 0.42%)  5.29MB/op   1.81× slower
      Scanner.u8 430.33  (  2.32ms) (± 0.11%)   106kB/op        fastest
 Scanner.s.to_u8 157.69  (  6.34ms) (± 0.14%)  2.57MB/op   2.73× slower
     Scanner.u16 421.72  (  2.37ms) (± 0.14%)   204kB/op        fastest
Scanner.s.to_u16 144.25  (  6.93ms) (± 0.20%)  3.26MB/op   2.92× slower
     Scanner.u32 308.18  (  3.24ms) (± 0.31%)   399kB/op        fastest
Scanner.s.to_u32 117.36  (  8.52ms) (± 0.24%)  3.46MB/op   2.63× slower
     Scanner.u64 208.03  (  4.81ms) (± 0.29%)   790kB/op        fastest
Scanner.s.to_u64  81.04  ( 12.34ms) (± 0.57%)  5.31MB/op   2.57× slower
```

