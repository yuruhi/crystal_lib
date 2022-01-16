# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   233.02k (  4.29µs) (± 2.33%)  1.72kB/op  fastest
Int32 10^2 dence    220.92k (  4.53µs) (± 3.65%)  1.72kB/op  fastest
Int32 10^6 sparse     6.33  (157.92ms) (± 2.65%)  12.0MB/op  fastest
Int32 10^6 dence      5.45  (183.57ms) (± 1.88%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.89  (345.87ms) (± 1.85%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.68  (271.88ms) (± 2.11%)  12.0MB/op  fastest
SlowC 10^6 * 10^2    99.04m ( 10.10s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.19k (238.59µs) (± 2.38%)  141kB/op  fastest
Int32 1e3          3.62k (276.19µs) (± 1.97%)  141kB/op  fastest
Int32 1e6 sorted 930.75m (  1.07s ) (± 2.04%)  137MB/op  fastest
Int32 1e6        581.35m (  1.72s ) (± 2.15%)  137MB/op  fastest
Int32 1e3 * 1e3  906.68m (  1.10s ) (± 1.32%)  137MB/op  fastest
Array 1e6 * 1e2  246.87m (  4.05s ) (± 0.36%)  183MB/op  fastest
class 1e6        972.07m (  1.03s ) (± 3.12%)  183MB/op  fastest
SlowC 1e6 * 1e2  116.68m (  8.57s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.65  (274.27ms) (±15.36%)  137MB/op  fastest
Int32 1e5+9e5   4.61  (217.12ms) (±10.21%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.91k (255.48µs) (± 3.34%)  188kB/op  fastest
Int32 1e3          2.88k (347.04µs) (± 2.53%)  188kB/op  fastest
Int32 1e6 sorted 764.61m (  1.31s ) (± 2.07%)  183MB/op  fastest
Int32 1e6        410.08m (  2.44s ) (± 2.48%)  183MB/op  fastest
Int32 1e3 * 1e3  460.06m (  2.17s ) (± 1.58%)  183MB/op  fastest
Array 1e6 * 1e2  186.83m (  5.35s ) (± 0.00%)  244MB/op  fastest
class 1e6        467.49m (  2.14s ) (± 3.05%)  244MB/op  fastest
SlowC 1e6 * 1e2   52.46m ( 19.06s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.39  (228.02ms) (±21.71%)  137MB/op  fastest
Int32 1e5+9e5   6.52  (153.34ms) (±13.54%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.60k (277.67µs) (± 2.55%)  141kB/op  fastest
Int32 1e3          2.71k (369.23µs) (± 3.01%)  141kB/op  fastest
Int32 1e6 sorted 823.45m (  1.21s ) (± 2.27%)  137MB/op  fastest
Int32 1e6        486.68m (  2.05s ) (± 4.60%)  137MB/op  fastest
Int32 1e3 * 1e3   12.05  ( 82.96ms) (± 2.32%)  141kB/op  fastest
Array 1e6 * 1e2  228.80m (  4.37s ) (± 1.61%)  183MB/op  fastest
class 1e6         20.41  ( 48.99ms) (± 2.24%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  323.73m (  3.09s ) (± 0.22%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.55  (392.49ms) (±11.54%)  137MB/op  fastest
Int32 1e5+9e5   2.99  (334.42ms) (± 7.35%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.77k (265.15µs) (± 2.27%)  188kB/op  fastest
Int32 1e3          2.77k (360.38µs) (± 2.38%)  188kB/op  fastest
Int32 1e6 sorted 755.70m (  1.32s ) (± 3.06%)  183MB/op  fastest
Int32 1e6        411.13m (  2.43s ) (± 2.10%)  183MB/op  fastest
Int32 1e3 * 1e3    4.95  (202.09ms) (± 3.39%)  137MB/op  fastest
Array 1e6 * 1e2  186.10m (  5.37s ) (± 0.00%)  244MB/op  fastest
class 1e6          6.27  (159.44ms) (±12.66%)  183MB/op  fastest
SlowC 1e6 * 1e2  228.38m (  4.38s ) (± 3.80%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.08  (197.00ms) (±32.99%)  137MB/op  fastest
Int32 1e5+9e5   6.12  (163.27ms) (±20.15%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  75.04  ( 13.33ms) (± 2.56%)  0.0B/op  33.17× slower
a &* b % mod  75.20  ( 13.30ms) (± 2.08%)  0.0B/op  33.10× slower
 a * b % MOD   2.49k (401.80µs) (± 3.16%)  0.0B/op        fastest
a &* b % MOD   2.49k (402.40µs) (± 2.51%)  0.0B/op   1.00× slower
bt.mul(a, b) 167.22  (  5.98ms) (± 2.89%)  0.0B/op  14.88× slower

-------- mod: 100000 --------
 a * b % mod  68.88  ( 14.52ms) (± 1.71%)  0.0B/op   2.79× slower
a &* b % mod  68.44  ( 14.61ms) (± 3.22%)  0.0B/op   2.81× slower
 a * b % MOD 188.66  (  5.30ms) (± 2.97%)  0.0B/op   1.02× slower
a &* b % MOD 192.43  (  5.20ms) (± 2.01%)  0.0B/op        fastest
bt.mul(a, b) 167.75  (  5.96ms) (± 2.37%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  64.25  ( 15.57ms) (± 2.55%)  0.0B/op   2.99× slower
a &* b % mod  64.62  ( 15.48ms) (± 2.65%)  0.0B/op   2.97× slower
 a * b % MOD 189.94  (  5.26ms) (± 2.80%)  0.0B/op   1.01× slower
a &* b % MOD 192.01  (  5.21ms) (± 1.89%)  0.0B/op        fastest
bt.mul(a, b) 164.37  (  6.08ms) (± 2.74%)  0.0B/op   1.17× slower

-------- mod: 1000000007 --------
 a * b % mod  63.38  ( 15.78ms) (± 2.61%)  0.0B/op   3.29× slower
a &* b % mod  64.13  ( 15.59ms) (± 2.26%)  0.0B/op   3.25× slower
 a * b % MOD 207.97  (  4.81ms) (± 2.52%)  0.0B/op   1.00× slower
a &* b % MOD 208.41  (  4.80ms) (± 2.14%)  0.0B/op        fastest
bt.mul(a, b) 168.15  (  5.95ms) (± 1.89%)  0.0B/op   1.24× slower

-------- mod: 2147483647 --------
 a * b % mod  64.92  ( 15.40ms) (± 2.17%)  0.0B/op   2.73× slower
a &* b % mod  64.78  ( 15.44ms) (± 2.12%)  0.0B/op   2.74× slower
 a * b % MOD 177.35  (  5.64ms) (± 2.71%)  0.0B/op        fastest
a &* b % MOD 176.23  (  5.67ms) (± 1.98%)  0.0B/op   1.01× slower
bt.mul(a, b) 162.45  (  6.16ms) (± 2.21%)  0.0B/op   1.09× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.58  (179.28ms) (± 3.73%)  44.2MB/op   2.53× slower
SieveFast#new  14.11  ( 70.86ms) (± 4.15%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 247.11  (  4.05ms) (± 4.96%)   106kB/op        fastest
 Scanner.s.to_i8 125.89  (  7.94ms) (± 3.32%)  2.51MB/op   1.96× slower
     Scanner.i16 218.10  (  4.59ms) (± 4.23%)   204kB/op        fastest
Scanner.s.to_i16 112.75  (  8.87ms) (± 2.94%)  3.26MB/op   1.93× slower
     Scanner.i32 182.27  (  5.49ms) (± 3.43%)   399kB/op        fastest
Scanner.s.to_i32 100.62  (  9.94ms) (± 2.79%)  3.46MB/op   1.81× slower
     Scanner.i64 118.56  (  8.43ms) (± 3.24%)  790kB/op        fastest
Scanner.s.to_i64  76.00  ( 13.16ms) (± 3.01%)  5.3MB/op   1.56× slower
      Scanner.u8 399.55  (  2.50ms) (± 2.23%)   106kB/op        fastest
 Scanner.s.to_u8 136.24  (  7.34ms) (± 2.57%)  2.57MB/op   2.93× slower
     Scanner.u16 392.22  (  2.55ms) (± 3.29%)   204kB/op        fastest
Scanner.s.to_u16 126.29  (  7.92ms) (± 2.85%)  3.26MB/op   3.11× slower
     Scanner.u32 276.09  (  3.62ms) (± 2.38%)   399kB/op        fastest
Scanner.s.to_u32 103.07  (  9.70ms) (± 2.56%)  3.47MB/op   2.68× slower
     Scanner.u64 172.85  (  5.79ms) (± 4.59%)   790kB/op        fastest
Scanner.s.to_u64  73.86  ( 13.54ms) (± 3.48%)  5.31MB/op   2.34× slower
```

