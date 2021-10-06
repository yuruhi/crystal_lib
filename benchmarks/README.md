# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   156.15k (  6.40µs) (± 0.21%)  1.72kB/op  fastest
Int32 10^2 dence    142.15k (  7.03µs) (± 0.14%)  1.72kB/op  fastest
Int32 10^6 sparse     5.16  (193.81ms) (± 3.15%)  12.0MB/op  fastest
Int32 10^6 dence      4.90  (204.02ms) (± 0.07%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.35  (426.16ms) (± 0.04%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.30  (303.18ms) (± 0.26%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   128.98m (  7.75s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.65k (215.13µs) (± 1.15%)  141kB/op  fastest
Int32 1e3          3.86k (258.76µs) (± 0.25%)  141kB/op  fastest
Int32 1e6 sorted   1.24  (808.09ms) (± 2.90%)  137MB/op  fastest
Int32 1e6        796.84m (  1.25s ) (± 3.12%)  137MB/op  fastest
Int32 1e3 * 1e3    1.31  (762.41ms) (± 0.97%)  137MB/op  fastest
Array 1e6 * 1e2  342.25m (  2.92s ) (± 1.16%)  183MB/op  fastest
class 1e6          1.65  (606.91ms) (± 4.71%)  183MB/op  fastest
SlowC 1e6 * 1e2  131.12m (  7.63s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.43  (225.63ms) (±15.28%)  137MB/op  fastest
Int32 1e5+9e5   5.41  (184.98ms) (± 9.24%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.23k (236.46µs) (± 0.66%)  188kB/op  fastest
Int32 1e3          3.15k (317.67µs) (± 0.11%)  188kB/op  fastest
Int32 1e6 sorted   1.05  (954.61ms) (± 2.34%)  183MB/op  fastest
Int32 1e6        601.59m (  1.66s ) (± 1.08%)  183MB/op  fastest
Int32 1e3 * 1e3  680.04m (  1.47s ) (± 2.13%)  183MB/op  fastest
Array 1e6 * 1e2  266.61m (  3.75s ) (± 0.67%)  244MB/op  fastest
class 1e6        690.96m (  1.45s ) (± 3.26%)  244MB/op  fastest
SlowC 1e6 * 1e2   68.15m ( 14.67s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.98  (167.34ms) (±21.76%)  137MB/op  fastest
Int32 1e5+9e5   7.84  (127.56ms) (±12.55%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.01k (249.11µs) (± 1.86%)  141kB/op  fastest
Int32 1e3          3.04k (328.60µs) (± 0.13%)  141kB/op  fastest
Int32 1e6 sorted   1.14  (876.57ms) (± 2.17%)  137MB/op  fastest
Int32 1e6        705.94m (  1.42s ) (± 2.72%)  137MB/op  fastest
Int32 1e3 * 1e3   13.22  ( 75.65ms) (± 0.30%)  141kB/op  fastest
Array 1e6 * 1e2  321.65m (  3.11s ) (± 0.93%)  183MB/op  fastest
class 1e6         21.20  ( 47.18ms) (± 0.57%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  408.08m (  2.45s ) (± 0.08%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.35  (298.79ms) (±13.54%)  137MB/op  fastest
Int32 1e5+9e5   4.01  (249.15ms) (± 6.89%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.25k (235.48µs) (± 0.60%)  188kB/op  fastest
Int32 1e3          3.12k (320.61µs) (± 0.14%)  188kB/op  fastest
Int32 1e6 sorted   1.03  (971.01ms) (± 1.67%)  183MB/op  fastest
Int32 1e6        599.77m (  1.67s ) (± 1.80%)  183MB/op  fastest
Int32 1e3 * 1e3    6.43  (155.54ms) (± 1.17%)  137MB/op  fastest
Array 1e6 * 1e2  267.00m (  3.75s ) (± 0.56%)  244MB/op  fastest
class 1e6          7.44  (134.43ms) (± 9.73%)  183MB/op  fastest
SlowC 1e6 * 1e2  262.83m (  3.80s ) (± 1.35%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.60  (178.50ms) (±27.63%)  137MB/op  fastest
Int32 1e5+9e5   7.72  (129.45ms) (±12.42%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 299.53  (  3.34ms) (± 0.07%)   106kB/op        fastest
 Scanner.s.to_i8 150.55  (  6.64ms) (± 0.13%)  2.52MB/op   1.99× slower
     Scanner.i16 271.92  (  3.68ms) (± 0.09%)   204kB/op        fastest
Scanner.s.to_i16 134.00  (  7.46ms) (± 0.12%)  3.26MB/op   2.03× slower
     Scanner.i32 218.40  (  4.58ms) (± 0.14%)   399kB/op        fastest
Scanner.s.to_i32 109.70  (  9.12ms) (± 0.15%)  3.46MB/op   1.99× slower
     Scanner.i64 149.99  (  6.67ms) (± 0.16%)  790kB/op        fastest
Scanner.s.to_i64  83.13  ( 12.03ms) (± 0.34%)  5.3MB/op   1.80× slower
      Scanner.u8 432.13  (  2.31ms) (± 0.09%)   106kB/op        fastest
 Scanner.s.to_u8 157.79  (  6.34ms) (± 0.13%)  2.57MB/op   2.74× slower
     Scanner.u16 423.54  (  2.36ms) (± 0.15%)   204kB/op        fastest
Scanner.s.to_u16 144.31  (  6.93ms) (± 0.19%)  3.26MB/op   2.93× slower
     Scanner.u32 313.04  (  3.19ms) (± 0.40%)   399kB/op        fastest
Scanner.s.to_u32 117.89  (  8.48ms) (± 0.17%)  3.46MB/op   2.66× slower
     Scanner.u64 210.59  (  4.75ms) (± 0.19%)   790kB/op        fastest
Scanner.s.to_u64  81.33  ( 12.30ms) (± 0.65%)  5.31MB/op   2.59× slower
```

