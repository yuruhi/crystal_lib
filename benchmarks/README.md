# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   227.94k (  4.39µs) (± 2.87%)  1.72kB/op  fastest
Int32 10^2 dence    205.72k (  4.86µs) (± 5.20%)  1.72kB/op  fastest
Int32 10^6 sparse     6.17  (162.00ms) (± 1.46%)  12.0MB/op  fastest
Int32 10^6 dence      5.49  (182.29ms) (± 2.01%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.83  (353.27ms) (± 1.02%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.51  (285.12ms) (± 3.09%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   106.63m (  9.38s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.91k (255.97µs) (±21.15%)  141kB/op           fastest
Int32 1e3          3.38k (295.58µs) (±19.44%)  141kB/op      1.15× slower
Int32 1e6 sorted 842.24m (  1.19s ) (± 5.86%)  137MB/op   4638.45× slower
Int32 1e6        495.92m (  2.02s ) (± 2.58%)  137MB/op   7877.63× slower
Int32 1e3 * 1e3  726.36m (  1.38s ) (± 4.95%)  137MB/op   5378.48× slower
Array 1e6 * 1e2  245.32m (  4.08s ) (± 1.62%)  183MB/op  15924.98× slower
class 1e6        749.25m (  1.33s ) (± 6.72%)  183MB/op   5214.19× slower
SlowC 1e6 * 1e2  117.33m (  8.52s ) (± 0.00%)  183MB/op  33297.72× slower

-------- split --------
Int32 5e5+5e5   3.87  (258.46ms) (±23.19%)  137MB/op   1.00× slower
Int32 1e5+9e5   3.88  (257.76ms) (±23.62%)  137MB/op        fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.33k (300.06µs) (±27.78%)  188kB/op           fastest
Int32 1e3          2.58k (387.14µs) (±24.13%)  188kB/op      1.29× slower
Int32 1e6 sorted 699.65m (  1.43s ) (± 4.40%)  183MB/op   4763.32× slower
Int32 1e6        352.14m (  2.84s ) (± 1.82%)  183MB/op   9464.07× slower
Int32 1e3 * 1e3  373.61m (  2.68s ) (± 1.75%)  183MB/op   8920.18× slower
Array 1e6 * 1e2  179.40m (  5.57s ) (± 0.00%)  244MB/op  18577.18× slower
class 1e6        375.64m (  2.66s ) (± 0.18%)  244MB/op   8871.99× slower
SlowC 1e6 * 1e2   56.09m ( 17.83s ) (± 0.00%)  244MB/op  59413.66× slower

-------- split --------
Int32 5e5+5e5   5.45  (183.38ms) (±32.02%)  137MB/op   1.00× slower
Int32 1e5+9e5   5.47  (182.72ms) (±32.70%)  137MB/op        fastest
```

## [datastructure/sset.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset.cr)

```

```

## [datastructure/sset/bucket.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/bucket.cr)

```

```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.10k (323.09µs) (±27.48%)   141kB/op           fastest
Int32 1e3          2.54k (394.07µs) (±24.56%)   141kB/op      1.22× slower
Int32 1e6 sorted 751.78m (  1.33s ) (± 3.92%)   137MB/op   4117.05× slower
Int32 1e6        451.92m (  2.21s ) (± 3.42%)   137MB/op   6848.80× slower
Int32 1e3 * 1e3   12.01  ( 83.24ms) (± 2.71%)   141kB/op    257.65× slower
Array 1e6 * 1e2  226.56m (  4.41s ) (± 0.98%)   183MB/op  13661.32× slower
class 1e6         20.18  ( 49.56ms) (± 1.59%)  18.8kB/op    153.39× slower
SlowC 1e6 * 1e2  380.68m (  2.63s ) (± 0.26%)   426kB/op   8130.45× slower

-------- split --------
Int32 5e5+5e5   2.71  (368.60ms) (±17.04%)  137MB/op        fastest
Int32 1e5+9e5   2.71  (369.34ms) (±16.90%)  137MB/op   1.00× slower
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.30k (302.96µs) (±27.40%)  188kB/op           fastest
Int32 1e3          2.54k (393.92µs) (±23.68%)  188kB/op      1.30× slower
Int32 1e6 sorted 701.50m (  1.43s ) (± 5.02%)  183MB/op   4705.28× slower
Int32 1e6        347.04m (  2.88s ) (± 1.65%)  183MB/op   9511.08× slower
Int32 1e3 * 1e3    4.20  (237.92ms) (±21.96%)  137MB/op    785.33× slower
Array 1e6 * 1e2  176.97m (  5.65s ) (± 0.00%)  244MB/op  18651.31× slower
class 1e6          4.82  (207.41ms) (±27.44%)  183MB/op    684.61× slower
SlowC 1e6 * 1e2  246.59m (  4.06s ) (± 0.04%)  183MB/op  13385.51× slower

-------- split --------
Int32 5e5+5e5   5.33  (187.72ms) (±31.98%)  137MB/op        fastest
Int32 1e5+9e5   5.26  (189.98ms) (±31.77%)  137MB/op   1.01× slower
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  77.49  ( 12.90ms) (± 1.60%)  0.0B/op  32.47× slower
a &* b % mod  77.86  ( 12.84ms) (± 2.08%)  0.0B/op  32.31× slower
 a * b % MOD   2.49k (400.92µs) (± 1.52%)  0.0B/op   1.01× slower
a &* b % MOD   2.52k (397.48µs) (± 1.45%)  0.0B/op        fastest
bt.mul(a, b) 161.40  (  6.20ms) (± 1.91%)  0.0B/op  15.59× slower

-------- mod: 100000 --------
 a * b % mod  70.93  ( 14.10ms) (± 1.55%)  0.0B/op   2.77× slower
a &* b % mod  70.88  ( 14.11ms) (± 2.05%)  0.0B/op   2.77× slower
 a * b % MOD 195.32  (  5.12ms) (± 2.62%)  0.0B/op   1.01× slower
a &* b % MOD 196.65  (  5.09ms) (± 2.01%)  0.0B/op        fastest
bt.mul(a, b) 159.45  (  6.27ms) (± 1.72%)  0.0B/op   1.23× slower

-------- mod: 1000000000 --------
 a * b % mod  66.73  ( 14.98ms) (± 2.03%)  0.0B/op   2.95× slower
a &* b % mod  66.76  ( 14.98ms) (± 2.62%)  0.0B/op   2.95× slower
 a * b % MOD 196.99  (  5.08ms) (± 1.97%)  0.0B/op   1.00× slower
a &* b % MOD 197.11  (  5.07ms) (± 1.15%)  0.0B/op        fastest
bt.mul(a, b) 158.95  (  6.29ms) (± 1.72%)  0.0B/op   1.24× slower

-------- mod: 1000000007 --------
 a * b % mod  64.85  ( 15.42ms) (± 3.32%)  0.0B/op   3.28× slower
a &* b % mod  65.29  ( 15.32ms) (± 2.17%)  0.0B/op   3.25× slower
 a * b % MOD 211.99  (  4.72ms) (± 2.22%)  0.0B/op   1.00× slower
a &* b % MOD 212.40  (  4.71ms) (± 1.73%)  0.0B/op        fastest
bt.mul(a, b) 158.82  (  6.30ms) (± 1.67%)  0.0B/op   1.34× slower

-------- mod: 2147483647 --------
 a * b % mod  64.46  ( 15.51ms) (± 2.63%)  0.0B/op   2.80× slower
a &* b % mod  65.27  ( 15.32ms) (± 1.61%)  0.0B/op   2.77× slower
 a * b % MOD 180.78  (  5.53ms) (± 1.23%)  0.0B/op        fastest
a &* b % MOD 179.80  (  5.56ms) (± 2.10%)  0.0B/op   1.01× slower
bt.mul(a, b) 159.35  (  6.28ms) (± 1.30%)  0.0B/op   1.13× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.65  (176.95ms) (± 1.85%)  44.2MB/op   2.55× slower
SieveFast#new  14.42  ( 69.35ms) (± 4.03%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 263.42  (  3.80ms) (± 1.84%)   106kB/op        fastest
 Scanner.s.to_i8 134.12  (  7.46ms) (± 2.74%)  2.52MB/op   1.96× slower
     Scanner.i16 236.55  (  4.23ms) (± 3.15%)   204kB/op        fastest
Scanner.s.to_i16 121.86  (  8.21ms) (± 1.68%)  3.26MB/op   1.94× slower
     Scanner.i32 189.25  (  5.28ms) (± 2.75%)   399kB/op        fastest
Scanner.s.to_i32  98.11  ( 10.19ms) (± 1.99%)  3.46MB/op   1.93× slower
     Scanner.i64 127.02  (  7.87ms) (± 2.70%)   790kB/op        fastest
Scanner.s.to_i64  75.96  ( 13.16ms) (± 1.57%)  5.29MB/op   1.67× slower
      Scanner.u8 412.96  (  2.42ms) (± 1.71%)   106kB/op        fastest
 Scanner.s.to_u8 141.32  (  7.08ms) (± 2.30%)  2.57MB/op   2.92× slower
     Scanner.u16 411.61  (  2.43ms) (± 1.69%)   204kB/op        fastest
Scanner.s.to_u16 132.87  (  7.53ms) (± 1.93%)  3.26MB/op   3.10× slower
     Scanner.u32 293.04  (  3.41ms) (± 1.19%)   399kB/op        fastest
Scanner.s.to_u32 106.28  (  9.41ms) (± 2.29%)  3.46MB/op   2.76× slower
     Scanner.u64 181.90  (  5.50ms) (± 2.31%)   790kB/op        fastest
Scanner.s.to_u64  75.41  ( 13.26ms) (± 3.25%)  5.31MB/op   2.41× slower
```

