# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   288.12k (  3.47µs) (± 3.62%)  1.72kB/op  fastest
Int32 10^2 dence    270.95k (  3.69µs) (± 5.60%)  1.72kB/op  fastest
Int32 10^6 sparse     7.71  (129.70ms) (± 5.80%)  12.0MB/op  fastest
Int32 10^6 dence      7.05  (141.90ms) (± 3.80%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.80  (263.05ms) (± 2.23%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.34  (230.58ms) (± 5.21%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   136.22m (  7.34s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   5.20k (192.43µs) (± 5.81%)  141kB/op  fastest
Int32 1e3          4.66k (214.64µs) (± 3.10%)  141kB/op  fastest
Int32 1e6 sorted   1.33  (750.72ms) (± 2.83%)  137MB/op  fastest
Int32 1e6        764.96m (  1.31s ) (± 2.22%)  137MB/op  fastest
Int32 1e3 * 1e3    1.07  (938.29ms) (± 0.85%)  137MB/op  fastest
Array 1e6 * 1e2  345.21m (  2.90s ) (± 0.43%)  183MB/op  fastest
class 1e6          1.20  (831.59ms) (± 3.71%)  183MB/op  fastest
SlowC 1e6 * 1e2  144.16m (  6.94s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.57  (218.96ms) (±15.59%)  137MB/op  fastest
Int32 1e5+9e5   5.74  (174.11ms) (± 9.86%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.76k (210.30µs) (± 4.63%)  188kB/op  fastest
Int32 1e3          3.69k (271.07µs) (± 3.58%)  188kB/op  fastest
Int32 1e6 sorted   1.09  (913.97ms) (± 2.11%)  183MB/op  fastest
Int32 1e6        588.11m (  1.70s ) (± 6.04%)  183MB/op  fastest
Int32 1e3 * 1e3  637.13m (  1.57s ) (± 1.50%)  183MB/op  fastest
Array 1e6 * 1e2  248.33m (  4.03s ) (± 2.75%)  244MB/op  fastest
class 1e6        614.30m (  1.63s ) (± 2.24%)  244MB/op  fastest
SlowC 1e6 * 1e2   73.31m ( 13.64s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.33  (157.90ms) (±21.84%)  137MB/op  fastest
Int32 1e5+9e5   8.11  (123.23ms) (±14.40%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.63k (215.99µs) (± 3.03%)  141kB/op  fastest
Int32 1e3          3.58k (278.98µs) (± 4.72%)  141kB/op  fastest
Int32 1e6 sorted   1.19  (839.02ms) (± 2.40%)  137MB/op  fastest
Int32 1e6        740.83m (  1.35s ) (± 5.49%)  137MB/op  fastest
Int32 1e3 * 1e3   15.57  ( 64.22ms) (± 5.37%)  141kB/op  fastest
Array 1e6 * 1e2  324.25m (  3.08s ) (± 0.21%)  183MB/op  fastest
class 1e6         25.54  ( 39.15ms) (± 6.29%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  443.46m (  2.26s ) (± 1.66%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.26  (306.47ms) (±11.29%)  137MB/op  fastest
Int32 1e5+9e5   3.96  (252.81ms) (± 7.85%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.75k (210.66µs) (± 3.41%)  188kB/op  fastest
Int32 1e3          3.56k (281.08µs) (± 4.64%)  188kB/op  fastest
Int32 1e6 sorted 976.57m (  1.02s ) (± 2.55%)  183MB/op  fastest
Int32 1e6        618.83m (  1.62s ) (± 2.37%)  183MB/op  fastest
Int32 1e3 * 1e3    6.24  (160.20ms) (± 4.27%)  137MB/op  fastest
Array 1e6 * 1e2  262.23m (  3.81s ) (± 0.75%)  244MB/op  fastest
class 1e6          7.80  (128.14ms) (±11.50%)  183MB/op  fastest
SlowC 1e6 * 1e2  293.66m (  3.41s ) (± 5.02%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.63  (177.71ms) (±22.75%)  137MB/op  fastest
Int32 1e5+9e5   6.68  (149.75ms) (±22.92%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  98.74  ( 10.13ms) (± 3.79%)  0.0B/op  33.55× slower
a &* b % mod  96.71  ( 10.34ms) (± 5.22%)  0.0B/op  34.25× slower
 a * b % MOD   3.31k (301.86µs) (± 4.04%)  0.0B/op        fastest
a &* b % MOD   3.27k (305.71µs) (± 4.21%)  0.0B/op   1.01× slower
bt.mul(a, b) 213.63  (  4.68ms) (± 5.06%)  0.0B/op  15.51× slower

-------- mod: 100000 --------
 a * b % mod  89.66  ( 11.15ms) (± 4.33%)  0.0B/op   2.76× slower
a &* b % mod  90.48  ( 11.05ms) (± 3.69%)  0.0B/op   2.74× slower
 a * b % MOD 245.13  (  4.08ms) (± 3.62%)  0.0B/op   1.01× slower
a &* b % MOD 247.84  (  4.03ms) (± 5.06%)  0.0B/op        fastest
bt.mul(a, b) 213.53  (  4.68ms) (± 4.48%)  0.0B/op   1.16× slower

-------- mod: 1000000000 --------
 a * b % mod  84.55  ( 11.83ms) (± 2.62%)  0.0B/op   2.97× slower
a &* b % mod  83.77  ( 11.94ms) (± 3.62%)  0.0B/op   3.00× slower
 a * b % MOD 251.48  (  3.98ms) (± 3.84%)  0.0B/op        fastest
a &* b % MOD 249.61  (  4.01ms) (± 4.66%)  0.0B/op   1.01× slower
bt.mul(a, b) 204.51  (  4.89ms) (± 6.04%)  0.0B/op   1.23× slower

-------- mod: 1000000007 --------
 a * b % mod  84.84  ( 11.79ms) (± 3.11%)  0.0B/op   3.26× slower
a &* b % mod  83.83  ( 11.93ms) (± 5.15%)  0.0B/op   3.30× slower
 a * b % MOD 276.86  (  3.61ms) (± 2.29%)  0.0B/op        fastest
a &* b % MOD 266.40  (  3.75ms) (± 6.30%)  0.0B/op   1.04× slower
bt.mul(a, b) 216.93  (  4.61ms) (± 4.14%)  0.0B/op   1.28× slower

-------- mod: 2147483647 --------
 a * b % mod  80.97  ( 12.35ms) (± 4.00%)  0.0B/op   2.84× slower
a &* b % mod  79.16  ( 12.63ms) (± 5.68%)  0.0B/op   2.91× slower
 a * b % MOD 217.65  (  4.59ms) (± 5.95%)  0.0B/op   1.06× slower
a &* b % MOD 230.02  (  4.35ms) (± 4.12%)  0.0B/op        fastest
bt.mul(a, b) 219.98  (  4.55ms) (± 3.70%)  0.0B/op   1.05× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 330.17  (  3.03ms) (± 5.36%)   106kB/op        fastest
 Scanner.s.to_i8 169.03  (  5.92ms) (± 4.53%)  2.51MB/op   1.95× slower
     Scanner.i16 298.19  (  3.35ms) (± 4.71%)   204kB/op        fastest
Scanner.s.to_i16 156.06  (  6.41ms) (± 4.16%)  3.26MB/op   1.91× slower
     Scanner.i32 223.80  (  4.47ms) (± 6.15%)   399kB/op        fastest
Scanner.s.to_i32 129.78  (  7.71ms) (± 3.71%)  3.46MB/op   1.72× slower
     Scanner.i64 164.01  (  6.10ms) (± 3.43%)  790kB/op        fastest
Scanner.s.to_i64 101.86  (  9.82ms) (± 4.50%)  5.3MB/op   1.61× slower
      Scanner.u8 545.61  (  1.83ms) (± 3.63%)   106kB/op        fastest
 Scanner.s.to_u8 177.80  (  5.62ms) (± 4.53%)  2.57MB/op   3.07× slower
     Scanner.u16 531.58  (  1.88ms) (± 4.44%)   204kB/op        fastest
Scanner.s.to_u16 163.43  (  6.12ms) (± 5.48%)  3.26MB/op   3.25× slower
     Scanner.u32 356.50  (  2.81ms) (± 7.52%)   399kB/op        fastest
Scanner.s.to_u32 130.41  (  7.67ms) (± 6.06%)  3.46MB/op   2.73× slower
     Scanner.u64 227.49  (  4.40ms) (± 3.84%)   790kB/op        fastest
Scanner.s.to_u64 103.63  (  9.65ms) (± 3.59%)  5.31MB/op   2.20× slower
```

