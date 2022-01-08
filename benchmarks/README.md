# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   216.40k (  4.62µs) (± 0.34%)  1.72kB/op  fastest
Int32 10^2 dence    212.58k (  4.70µs) (± 0.69%)  1.72kB/op  fastest
Int32 10^6 sparse     5.33  (187.48ms) (± 0.47%)  12.0MB/op  fastest
Int32 10^6 dence      4.72  (211.81ms) (± 0.24%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.90  (345.18ms) (± 0.13%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.38  (296.00ms) (± 0.18%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   103.52m (  9.66s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.85k (260.00µs) (± 2.07%)  141kB/op  fastest
Int32 1e3          3.21k (311.87µs) (± 0.45%)  141kB/op  fastest
Int32 1e6 sorted   1.02  (981.47ms) (± 1.14%)  137MB/op  fastest
Int32 1e6        621.11m (  1.61s ) (± 1.15%)  137MB/op  fastest
Int32 1e3 * 1e3    1.11  (904.92ms) (± 1.19%)  137MB/op  fastest
Array 1e6 * 1e2  285.31m (  3.50s ) (± 1.40%)  183MB/op  fastest
class 1e6          1.34  (747.45ms) (± 5.02%)  183MB/op  fastest
SlowC 1e6 * 1e2  100.26m (  9.97s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.74  (267.38ms) (±15.23%)  137MB/op  fastest
Int32 1e5+9e5   4.59  (217.78ms) (± 9.06%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.51k (285.01µs) (± 0.93%)  188kB/op  fastest
Int32 1e3          2.61k (382.94µs) (± 0.38%)  188kB/op  fastest
Int32 1e6 sorted 861.47m (  1.16s ) (± 1.00%)  183MB/op  fastest
Int32 1e6        484.74m (  2.06s ) (± 0.56%)  183MB/op  fastest
Int32 1e3 * 1e3  569.10m (  1.76s ) (± 0.61%)  183MB/op  fastest
Array 1e6 * 1e2  212.93m (  4.70s ) (± 0.19%)  244MB/op  fastest
class 1e6        569.45m (  1.76s ) (± 3.92%)  244MB/op  fastest
SlowC 1e6 * 1e2   52.71m ( 18.97s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.12  (195.26ms) (±22.80%)  137MB/op  fastest
Int32 1e5+9e5   6.70  (149.32ms) (±13.40%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.37k (297.00µs) (± 0.29%)  141kB/op  fastest
Int32 1e3          2.53k (395.44µs) (± 0.59%)  141kB/op  fastest
Int32 1e6 sorted 944.38m (  1.06s ) (± 1.33%)  137MB/op  fastest
Int32 1e6        578.48m (  1.73s ) (± 1.39%)  137MB/op  fastest
Int32 1e3 * 1e3   11.04  ( 90.60ms) (± 0.46%)  141kB/op  fastest
Array 1e6 * 1e2  257.66m (  3.88s ) (± 0.20%)  183MB/op  fastest
class 1e6         17.61  ( 56.80ms) (± 0.66%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  341.81m (  2.93s ) (± 0.14%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.97  (337.16ms) (±12.50%)  137MB/op  fastest
Int32 1e5+9e5   3.38  (295.90ms) (± 7.16%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.52k (284.30µs) (± 0.39%)  188kB/op  fastest
Int32 1e3          2.60k (384.97µs) (± 0.32%)  188kB/op  fastest
Int32 1e6 sorted 841.82m (  1.19s ) (± 1.14%)  183MB/op  fastest
Int32 1e6        481.30m (  2.08s ) (± 0.95%)  183MB/op  fastest
Int32 1e3 * 1e3    5.48  (182.39ms) (± 2.21%)  137MB/op  fastest
Array 1e6 * 1e2  219.51m (  4.56s ) (± 1.65%)  244MB/op  fastest
class 1e6          6.44  (155.16ms) (± 9.25%)  183MB/op  fastest
SlowC 1e6 * 1e2  217.01m (  4.61s ) (± 0.80%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.98  (200.75ms) (±22.70%)  137MB/op  fastest
Int32 1e5+9e5   6.28  (159.26ms) (±25.37%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  73.92  ( 13.53ms) (± 0.23%)  0.0B/op  33.75× slower
a &* b % mod  73.86  ( 13.54ms) (± 0.15%)  0.0B/op  33.78× slower
 a * b % MOD   2.49k (401.53µs) (± 0.55%)  0.0B/op   1.00× slower
a &* b % MOD   2.49k (400.81µs) (± 0.38%)  0.0B/op        fastest
bt.mul(a, b) 165.96  (  6.03ms) (± 0.15%)  0.0B/op  15.03× slower

-------- mod: 100000 --------
 a * b % mod  69.65  ( 14.36ms) (± 0.27%)  0.0B/op   2.75× slower
a &* b % mod  69.63  ( 14.36ms) (± 0.19%)  0.0B/op   2.76× slower
 a * b % MOD 191.74  (  5.22ms) (± 0.21%)  0.0B/op   1.00× slower
a &* b % MOD 191.84  (  5.21ms) (± 0.21%)  0.0B/op        fastest
bt.mul(a, b) 166.16  (  6.02ms) (± 0.20%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  69.63  ( 14.36ms) (± 0.53%)  0.0B/op   2.75× slower
a &* b % mod  69.76  ( 14.33ms) (± 0.34%)  0.0B/op   2.75× slower
 a * b % MOD 191.83  (  5.21ms) (± 0.25%)  0.0B/op        fastest
a &* b % MOD 191.75  (  5.22ms) (± 0.23%)  0.0B/op   1.00× slower
bt.mul(a, b) 166.09  (  6.02ms) (± 0.17%)  0.0B/op   1.16× slower

-------- mod: 1000000007 --------
 a * b % mod  69.60  ( 14.37ms) (± 0.16%)  0.0B/op   2.99× slower
a &* b % mod  69.63  ( 14.36ms) (± 0.21%)  0.0B/op   2.99× slower
 a * b % MOD 207.94  (  4.81ms) (± 0.28%)  0.0B/op        fastest
a &* b % MOD 207.82  (  4.81ms) (± 0.35%)  0.0B/op   1.00× slower
bt.mul(a, b) 166.26  (  6.01ms) (± 0.24%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  69.67  ( 14.35ms) (± 0.30%)  0.0B/op   2.55× slower
a &* b % mod  69.71  ( 14.34ms) (± 0.30%)  0.0B/op   2.55× slower
 a * b % MOD 177.90  (  5.62ms) (± 0.16%)  0.0B/op        fastest
a &* b % MOD 177.87  (  5.62ms) (± 0.12%)  0.0B/op   1.00× slower
bt.mul(a, b) 166.01  (  6.02ms) (± 0.14%)  0.0B/op   1.07× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.70  (175.33ms) (± 2.02%)  44.2MB/op   2.28× slower
SieveFast#new  12.98  ( 77.02ms) (± 2.05%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 249.25  (  4.01ms) (± 0.20%)   106kB/op        fastest
 Scanner.s.to_i8 124.93  (  8.00ms) (± 0.35%)  2.51MB/op   2.00× slower
     Scanner.i16 226.53  (  4.41ms) (± 0.24%)   204kB/op        fastest
Scanner.s.to_i16 110.66  (  9.04ms) (± 0.37%)  3.26MB/op   2.05× slower
     Scanner.i32 181.15  (  5.52ms) (± 0.31%)   399kB/op        fastest
Scanner.s.to_i32  91.13  ( 10.97ms) (± 0.62%)  3.46MB/op   1.99× slower
     Scanner.i64 124.85  (  8.01ms) (± 0.66%)  790kB/op        fastest
Scanner.s.to_i64  69.18  ( 14.46ms) (± 0.74%)  5.3MB/op   1.80× slower
      Scanner.u8 365.55  (  2.74ms) (± 0.38%)   106kB/op        fastest
 Scanner.s.to_u8 130.69  (  7.65ms) (± 2.54%)  2.57MB/op   2.80× slower
     Scanner.u16 358.53  (  2.79ms) (± 0.25%)   204kB/op        fastest
Scanner.s.to_u16 120.95  (  8.27ms) (± 0.60%)  3.26MB/op   2.96× slower
     Scanner.u32 267.15  (  3.74ms) (± 0.23%)   399kB/op        fastest
Scanner.s.to_u32  98.09  ( 10.19ms) (± 0.49%)  3.46MB/op   2.72× slower
     Scanner.u64 176.96  (  5.65ms) (± 0.70%)   790kB/op        fastest
Scanner.s.to_u64  67.92  ( 14.72ms) (± 0.72%)  5.31MB/op   2.61× slower
```

