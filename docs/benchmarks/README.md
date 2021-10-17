# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   294.51k (  3.40µs) (± 0.62%)  1.72kB/op  fastest
Int32 10^2 dence    288.70k (  3.46µs) (± 0.21%)  1.72kB/op  fastest
Int32 10^6 sparse     7.26  (137.65ms) (± 0.27%)  12.0MB/op  fastest
Int32 10^6 dence      6.41  (155.91ms) (± 0.11%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.94  (253.91ms) (± 0.11%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.57  (218.67ms) (± 1.82%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   134.90m (  7.41s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   5.19k (192.72µs) (± 0.49%)  141kB/op  fastest
Int32 1e3          4.35k (229.98µs) (± 0.13%)  141kB/op  fastest
Int32 1e6 sorted   1.28  (779.29ms) (± 1.65%)  137MB/op  fastest
Int32 1e6        804.63m (  1.24s ) (± 2.03%)  137MB/op  fastest
Int32 1e3 * 1e3    1.41  (708.96ms) (± 1.09%)  137MB/op  fastest
Array 1e6 * 1e2  346.36m (  2.89s ) (± 0.75%)  183MB/op  fastest
class 1e6          1.74  (576.19ms) (± 4.88%)  183MB/op  fastest
SlowC 1e6 * 1e2  142.67m (  7.01s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.78  (209.11ms) (±16.77%)  137MB/op  fastest
Int32 1e5+9e5   5.96  (167.79ms) (±10.30%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.73k (211.57µs) (± 0.22%)  188kB/op  fastest
Int32 1e3          3.52k (283.72µs) (± 0.22%)  188kB/op  fastest
Int32 1e6 sorted   1.09  (920.33ms) (± 1.56%)  183MB/op  fastest
Int32 1e6        576.25m (  1.74s ) (± 1.12%)  183MB/op  fastest
Int32 1e3 * 1e3  704.66m (  1.42s ) (± 1.45%)  183MB/op  fastest
Array 1e6 * 1e2  263.79m (  3.79s ) (± 0.56%)  244MB/op  fastest
class 1e6        711.20m (  1.41s ) (± 2.94%)  244MB/op  fastest
SlowC 1e6 * 1e2   73.52m ( 13.60s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.42  (155.84ms) (±23.32%)  137MB/op  fastest
Int32 1e5+9e5   8.57  (116.68ms) (±13.83%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.54k (220.06µs) (± 0.45%)  141kB/op  fastest
Int32 1e3          3.43k (291.46µs) (± 0.12%)  141kB/op  fastest
Int32 1e6 sorted   1.17  (853.24ms) (± 1.69%)  137MB/op  fastest
Int32 1e6        723.97m (  1.38s ) (± 6.68%)  137MB/op  fastest
Int32 1e3 * 1e3   14.98  ( 66.76ms) (± 0.40%)  141kB/op  fastest
Array 1e6 * 1e2  316.08m (  3.16s ) (± 0.36%)  183MB/op  fastest
class 1e6         23.95  ( 41.75ms) (± 0.51%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  452.03m (  2.21s ) (± 0.07%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   4.04  (247.65ms) (±14.43%)  137MB/op  fastest
Int32 1e5+9e5   4.49  (222.72ms) (± 7.06%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.78k (209.24µs) (± 0.78%)  188kB/op  fastest
Int32 1e3          3.53k (283.40µs) (± 0.14%)  188kB/op  fastest
Int32 1e6 sorted   1.08  (923.81ms) (± 1.68%)  183MB/op  fastest
Int32 1e6        611.64m (  1.63s ) (± 0.82%)  183MB/op  fastest
Int32 1e3 * 1e3    7.15  (139.85ms) (± 2.11%)  137MB/op  fastest
Array 1e6 * 1e2  270.89m (  3.69s ) (± 1.40%)  244MB/op  fastest
class 1e6          8.17  (122.46ms) (±10.18%)  183MB/op  fastest
SlowC 1e6 * 1e2  306.45m (  3.26s ) (± 4.46%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.47  (154.61ms) (±35.92%)  137MB/op  fastest
Int32 1e5+9e5   8.42  (118.70ms) (±15.54%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod 100.42  (  9.96ms) (± 0.02%)  0.0B/op  33.73× slower
a &* b % mod 100.41  (  9.96ms) (± 0.36%)  0.0B/op  33.73× slower
 a * b % MOD   3.39k (295.25µs) (± 0.03%)  0.0B/op   1.00× slower
a &* b % MOD   3.39k (295.24µs) (± 0.03%)  0.0B/op        fastest
bt.mul(a, b) 225.75  (  4.43ms) (± 0.03%)  0.0B/op  15.00× slower

-------- mod: 100000 --------
 a * b % mod  94.65  ( 10.57ms) (± 0.02%)  0.0B/op   2.75× slower
a &* b % mod  94.65  ( 10.57ms) (± 0.02%)  0.0B/op   2.75× slower
 a * b % MOD 260.57  (  3.84ms) (± 0.03%)  0.0B/op   1.00× slower
a &* b % MOD 260.58  (  3.84ms) (± 0.02%)  0.0B/op        fastest
bt.mul(a, b) 225.76  (  4.43ms) (± 0.02%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  94.63  ( 10.57ms) (± 0.03%)  0.0B/op   2.75× slower
a &* b % mod  94.63  ( 10.57ms) (± 0.07%)  0.0B/op   2.75× slower
 a * b % MOD 260.57  (  3.84ms) (± 0.02%)  0.0B/op        fastest
a &* b % MOD 260.56  (  3.84ms) (± 0.03%)  0.0B/op   1.00× slower
bt.mul(a, b) 225.75  (  4.43ms) (± 0.03%)  0.0B/op   1.15× slower

-------- mod: 1000000007 --------
 a * b % mod  94.65  ( 10.57ms) (± 0.04%)  0.0B/op   2.98× slower
a &* b % mod  94.64  ( 10.57ms) (± 0.02%)  0.0B/op   2.98× slower
 a * b % MOD 282.28  (  3.54ms) (± 0.03%)  0.0B/op        fastest
a &* b % MOD 282.26  (  3.54ms) (± 0.02%)  0.0B/op   1.00× slower
bt.mul(a, b) 225.55  (  4.43ms) (± 0.41%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  94.60  ( 10.57ms) (± 0.02%)  0.0B/op   2.56× slower
a &* b % mod  94.59  ( 10.57ms) (± 0.03%)  0.0B/op   2.56× slower
 a * b % MOD 241.85  (  4.13ms) (± 0.05%)  0.0B/op   1.00× slower
a &* b % MOD 241.95  (  4.13ms) (± 0.03%)  0.0B/op        fastest
bt.mul(a, b) 225.76  (  4.43ms) (± 0.02%)  0.0B/op   1.07× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 335.42  (  2.98ms) (± 0.28%)   106kB/op        fastest
 Scanner.s.to_i8 168.88  (  5.92ms) (± 0.59%)  2.51MB/op   1.99× slower
     Scanner.i16 305.01  (  3.28ms) (± 0.23%)   204kB/op        fastest
Scanner.s.to_i16 149.19  (  6.70ms) (± 0.45%)  3.26MB/op   2.04× slower
     Scanner.i32 242.92  (  4.12ms) (± 0.19%)   399kB/op        fastest
Scanner.s.to_i32 115.42  (  8.66ms) (± 5.34%)  3.46MB/op   2.10× slower
     Scanner.i64 149.04  (  6.71ms) (± 0.37%)  790kB/op        fastest
Scanner.s.to_i64  81.72  ( 12.24ms) (± 0.40%)  5.3MB/op   1.82× slower
      Scanner.u8 429.67  (  2.33ms) (± 0.14%)   106kB/op        fastest
 Scanner.s.to_u8 156.57  (  6.39ms) (± 0.34%)  2.57MB/op   2.74× slower
     Scanner.u16 419.48  (  2.38ms) (± 0.23%)   204kB/op        fastest
Scanner.s.to_u16 143.88  (  6.95ms) (± 0.33%)  3.26MB/op   2.92× slower
     Scanner.u32 309.26  (  3.23ms) (± 0.37%)   399kB/op        fastest
Scanner.s.to_u32 116.65  (  8.57ms) (± 0.45%)  3.46MB/op   2.65× slower
     Scanner.u64 209.16  (  4.78ms) (± 0.25%)   790kB/op        fastest
Scanner.s.to_u64  81.47  ( 12.27ms) (± 0.54%)  5.31MB/op   2.57× slower
```

