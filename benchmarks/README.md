# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   252.35k (  3.96µs) (± 4.13%)  1.72kB/op  fastest
Int32 10^2 dence    243.15k (  4.11µs) (± 4.20%)  1.72kB/op  fastest
Int32 10^6 sparse     7.15  (139.83ms) (± 2.62%)  12.0MB/op  fastest
Int32 10^6 dence      6.14  (162.90ms) (± 3.58%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.24  (308.25ms) (± 1.53%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.13  (242.36ms) (± 1.45%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   124.50m (  8.03s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.92k (203.23µs) (± 2.99%)  141kB/op  fastest
Int32 1e3          4.24k (235.90µs) (± 2.96%)  141kB/op  fastest
Int32 1e6 sorted   1.13  (886.53ms) (± 2.78%)  137MB/op  fastest
Int32 1e6        701.73m (  1.43s ) (± 7.75%)  137MB/op  fastest
Int32 1e3 * 1e3    1.13  (884.31ms) (± 1.66%)  137MB/op  fastest
Array 1e6 * 1e2  293.28m (  3.41s ) (± 0.35%)  183MB/op  fastest
class 1e6          1.15  (868.41ms) (± 3.71%)  183MB/op  fastest
SlowC 1e6 * 1e2  137.33m (  7.28s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.17  (239.70ms) (±16.94%)  137MB/op  fastest
Int32 1e5+9e5   5.32  (188.10ms) (±10.48%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.57k (218.87µs) (± 1.79%)  188kB/op  fastest
Int32 1e3          3.43k (291.87µs) (± 1.37%)  188kB/op  fastest
Int32 1e6 sorted 946.09m (  1.06s ) (± 0.98%)  183MB/op  fastest
Int32 1e6        579.78m (  1.72s ) (± 2.21%)  183MB/op  fastest
Int32 1e3 * 1e3  636.66m (  1.57s ) (± 2.43%)  183MB/op  fastest
Array 1e6 * 1e2  234.11m (  4.27s ) (± 1.39%)  244MB/op  fastest
class 1e6        581.65m (  1.72s ) (± 0.29%)  244MB/op  fastest
SlowC 1e6 * 1e2   68.84m ( 14.53s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.71  (175.17ms) (±22.62%)  137MB/op  fastest
Int32 1e5+9e5   7.83  (127.66ms) (±13.88%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.20k (237.87µs) (± 3.61%)  141kB/op  fastest
Int32 1e3          3.31k (302.19µs) (± 3.60%)  141kB/op  fastest
Int32 1e6 sorted   1.08  (929.65ms) (± 2.74%)  137MB/op  fastest
Int32 1e6        661.16m (  1.51s ) (± 1.84%)  137MB/op  fastest
Int32 1e3 * 1e3   14.04  ( 71.21ms) (± 2.69%)  141kB/op  fastest
Array 1e6 * 1e2  270.17m (  3.70s ) (± 1.25%)  183MB/op  fastest
class 1e6         23.60  ( 42.37ms) (± 4.15%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  388.10m (  2.58s ) (± 0.13%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.00  (333.61ms) (±13.37%)  137MB/op  fastest
Int32 1e5+9e5   3.61  (276.78ms) (± 7.25%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.35k (230.11µs) (± 3.91%)  188kB/op  fastest
Int32 1e3          3.30k (303.00µs) (± 2.41%)  188kB/op  fastest
Int32 1e6 sorted 961.77m (  1.04s ) (± 6.01%)  183MB/op  fastest
Int32 1e6        543.56m (  1.84s ) (± 7.01%)  183MB/op  fastest
Int32 1e3 * 1e3    5.94  (168.37ms) (± 2.63%)  137MB/op  fastest
Array 1e6 * 1e2  240.31m (  4.16s ) (± 3.09%)  244MB/op  fastest
class 1e6          7.49  (133.49ms) (±12.40%)  183MB/op  fastest
SlowC 1e6 * 1e2  267.18m (  3.74s ) (± 2.42%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.20  (192.32ms) (±28.63%)  137MB/op  fastest
Int32 1e5+9e5   7.11  (140.68ms) (±15.37%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  90.51  ( 11.05ms) (± 1.94%)  0.0B/op  32.43× slower
a &* b % mod  90.91  ( 11.00ms) (± 2.10%)  0.0B/op  32.29× slower
 a * b % MOD   2.92k (342.24µs) (± 2.03%)  0.0B/op   1.00× slower
a &* b % MOD   2.94k (340.67µs) (± 1.22%)  0.0B/op        fastest
bt.mul(a, b) 185.29  (  5.40ms) (± 2.90%)  0.0B/op  15.84× slower

-------- mod: 100000 --------
 a * b % mod  82.00  ( 12.19ms) (± 3.41%)  0.0B/op   2.80× slower
a &* b % mod  81.15  ( 12.32ms) (± 3.21%)  0.0B/op   2.83× slower
 a * b % MOD 229.90  (  4.35ms) (± 1.14%)  0.0B/op        fastest
a &* b % MOD 225.32  (  4.44ms) (± 3.35%)  0.0B/op   1.02× slower
bt.mul(a, b) 180.27  (  5.55ms) (± 4.67%)  0.0B/op   1.28× slower

-------- mod: 1000000000 --------
 a * b % mod  78.55  ( 12.73ms) (± 1.57%)  0.0B/op   2.90× slower
a &* b % mod  77.33  ( 12.93ms) (± 2.46%)  0.0B/op   2.95× slower
 a * b % MOD 227.75  (  4.39ms) (± 2.41%)  0.0B/op   1.00× slower
a &* b % MOD 227.95  (  4.39ms) (± 2.43%)  0.0B/op        fastest
bt.mul(a, b) 182.94  (  5.47ms) (± 3.61%)  0.0B/op   1.25× slower

-------- mod: 1000000007 --------
 a * b % mod  76.41  ( 13.09ms) (± 2.03%)  0.0B/op   3.26× slower
a &* b % mod  76.41  ( 13.09ms) (± 2.07%)  0.0B/op   3.26× slower
 a * b % MOD 248.24  (  4.03ms) (± 1.76%)  0.0B/op   1.00× slower
a &* b % MOD 249.41  (  4.01ms) (± 1.13%)  0.0B/op        fastest
bt.mul(a, b) 185.74  (  5.38ms) (± 2.19%)  0.0B/op   1.34× slower

-------- mod: 2147483647 --------
 a * b % mod  76.67  ( 13.04ms) (± 2.61%)  0.0B/op   2.66× slower
a &* b % mod  76.13  ( 13.14ms) (± 2.68%)  0.0B/op   2.68× slower
 a * b % MOD 203.67  (  4.91ms) (± 4.49%)  0.0B/op        fastest
a &* b % MOD 201.15  (  4.97ms) (± 3.50%)  0.0B/op   1.01× slower
bt.mul(a, b) 181.59  (  5.51ms) (± 3.20%)  0.0B/op   1.12× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 308.21  (  3.24ms) (± 1.09%)   106kB/op        fastest
 Scanner.s.to_i8 155.15  (  6.45ms) (± 2.26%)  2.51MB/op   1.99× slower
     Scanner.i16 281.35  (  3.55ms) (± 1.64%)   204kB/op        fastest
Scanner.s.to_i16 140.64  (  7.11ms) (± 1.86%)  3.26MB/op   2.00× slower
     Scanner.i32 218.05  (  4.59ms) (± 5.33%)   399kB/op        fastest
Scanner.s.to_i32 110.18  (  9.08ms) (± 5.95%)  3.46MB/op   1.98× slower
     Scanner.i64 146.67  (  6.82ms) (± 3.18%)  790kB/op        fastest
Scanner.s.to_i64  89.60  ( 11.16ms) (± 2.36%)  5.3MB/op   1.64× slower
      Scanner.u8 500.52  (  2.00ms) (± 2.12%)   106kB/op        fastest
 Scanner.s.to_u8 158.85  (  6.30ms) (± 3.38%)  2.57MB/op   3.15× slower
     Scanner.u16 476.87  (  2.10ms) (± 2.97%)   204kB/op        fastest
Scanner.s.to_u16 153.11  (  6.53ms) (± 1.68%)  3.26MB/op   3.11× slower
     Scanner.u32 346.31  (  2.89ms) (± 3.53%)   399kB/op        fastest
Scanner.s.to_u32 122.94  (  8.13ms) (± 2.35%)  3.46MB/op   2.82× slower
     Scanner.u64 211.46  (  4.73ms) (± 1.99%)  790kB/op        fastest
Scanner.s.to_u64  89.86  ( 11.13ms) (± 1.54%)  5.3MB/op   2.35× slower
```

