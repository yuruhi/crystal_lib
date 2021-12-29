# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   244.11k (  4.10µs) (± 3.77%)  1.72kB/op  fastest
Int32 10^2 dence    234.83k (  4.26µs) (± 4.73%)  1.72kB/op  fastest
Int32 10^6 sparse     6.58  (151.91ms) (± 3.66%)  12.0MB/op  fastest
Int32 10^6 dence      5.55  (180.22ms) (± 5.51%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.06  (326.66ms) (± 2.96%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.55  (281.67ms) (± 5.82%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   103.68m (  9.65s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.48k (223.45µs) (± 4.11%)  141kB/op  fastest
Int32 1e3          3.86k (258.74µs) (± 4.83%)  141kB/op  fastest
Int32 1e6 sorted   1.08  (926.05ms) (± 3.71%)  137MB/op  fastest
Int32 1e6        639.49m (  1.56s ) (± 5.22%)  137MB/op  fastest
Int32 1e3 * 1e3  915.65m (  1.09s ) (± 1.16%)  137MB/op  fastest
Array 1e6 * 1e2  272.92m (  3.66s ) (± 0.10%)  183MB/op  fastest
class 1e6        967.20m (  1.03s ) (± 3.95%)  183MB/op  fastest
SlowC 1e6 * 1e2  111.95m (  8.93s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.52  (283.94ms) (±14.91%)  137MB/op  fastest
Int32 1e5+9e5   4.51  (221.71ms) (±10.52%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.13k (241.99µs) (± 6.09%)  188kB/op  fastest
Int32 1e3          3.00k (333.49µs) (± 5.55%)  188kB/op  fastest
Int32 1e6 sorted 911.16m (  1.10s ) (± 2.45%)  183MB/op  fastest
Int32 1e6        461.04m (  2.17s ) (± 1.46%)  183MB/op  fastest
Int32 1e3 * 1e3  478.86m (  2.09s ) (± 0.81%)  183MB/op  fastest
Array 1e6 * 1e2  209.37m (  4.78s ) (± 2.04%)  244MB/op  fastest
class 1e6        489.63m (  2.04s ) (± 3.68%)  244MB/op  fastest
SlowC 1e6 * 1e2   58.59m ( 17.07s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.93  (202.86ms) (±21.84%)  137MB/op  fastest
Int32 1e5+9e5   6.41  (155.99ms) (±13.73%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.63k (275.41µs) (± 4.26%)  141kB/op  fastest
Int32 1e3          2.97k (336.24µs) (± 4.90%)  141kB/op  fastest
Int32 1e6 sorted 949.98m (  1.05s ) (± 2.95%)  137MB/op  fastest
Int32 1e6        568.30m (  1.76s ) (± 4.77%)  137MB/op  fastest
Int32 1e3 * 1e3   12.99  ( 77.01ms) (± 4.11%)  141kB/op  fastest
Array 1e6 * 1e2  256.34m (  3.90s ) (± 0.55%)  183MB/op  fastest
class 1e6         21.99  ( 45.48ms) (± 4.34%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  354.57m (  2.82s ) (± 0.03%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.70  (370.19ms) (±13.45%)  137MB/op  fastest
Int32 1e5+9e5   3.09  (323.87ms) (± 7.90%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.76k (265.70µs) (± 4.34%)  188kB/op  fastest
Int32 1e3          2.80k (357.09µs) (± 3.15%)  188kB/op  fastest
Int32 1e6 sorted 805.31m (  1.24s ) (± 2.26%)  183MB/op  fastest
Int32 1e6        434.44m (  2.30s ) (± 0.52%)  183MB/op  fastest
Int32 1e3 * 1e3    4.83  (207.08ms) (± 4.22%)  137MB/op  fastest
Array 1e6 * 1e2  193.98m (  5.16s ) (± 0.00%)  244MB/op  fastest
class 1e6          6.14  (162.93ms) (±11.55%)  183MB/op  fastest
SlowC 1e6 * 1e2  225.43m (  4.44s ) (± 3.23%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.39  (227.81ms) (±24.33%)  137MB/op  fastest
Int32 1e5+9e5   5.99  (166.92ms) (±14.11%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  76.38  ( 13.09ms) (± 2.69%)  0.0B/op  33.46× slower
a &* b % mod  76.51  ( 13.07ms) (± 3.77%)  0.0B/op  33.40× slower
 a * b % MOD   2.56k (391.29µs) (± 3.03%)  0.0B/op        fastest
a &* b % MOD   2.55k (391.59µs) (± 3.15%)  0.0B/op   1.00× slower
bt.mul(a, b) 171.03  (  5.85ms) (± 3.05%)  0.0B/op  14.94× slower

-------- mod: 100000 --------
 a * b % mod  71.08  ( 14.07ms) (± 3.23%)  0.0B/op   2.67× slower
a &* b % mod  69.08  ( 14.48ms) (± 3.16%)  0.0B/op   2.74× slower
 a * b % MOD 189.49  (  5.28ms) (± 3.32%)  0.0B/op   1.00× slower
a &* b % MOD 189.56  (  5.28ms) (± 3.12%)  0.0B/op        fastest
bt.mul(a, b) 162.74  (  6.14ms) (± 4.41%)  0.0B/op   1.16× slower

-------- mod: 1000000000 --------
 a * b % mod  64.66  ( 15.47ms) (± 2.53%)  0.0B/op   3.10× slower
a &* b % mod  65.40  ( 15.29ms) (± 2.80%)  0.0B/op   3.06× slower
 a * b % MOD 196.83  (  5.08ms) (± 2.82%)  0.0B/op   1.02× slower
a &* b % MOD 200.18  (  5.00ms) (± 3.39%)  0.0B/op        fastest
bt.mul(a, b) 171.99  (  5.81ms) (± 3.44%)  0.0B/op   1.16× slower

-------- mod: 1000000007 --------
 a * b % mod  66.76  ( 14.98ms) (± 3.99%)  0.0B/op   3.25× slower
a &* b % mod  66.67  ( 15.00ms) (± 3.69%)  0.0B/op   3.25× slower
 a * b % MOD 216.94  (  4.61ms) (± 4.24%)  0.0B/op        fastest
a &* b % MOD 216.05  (  4.63ms) (± 3.46%)  0.0B/op   1.00× slower
bt.mul(a, b) 171.65  (  5.83ms) (± 2.89%)  0.0B/op   1.26× slower

-------- mod: 2147483647 --------
 a * b % mod  66.84  ( 14.96ms) (± 3.68%)  0.0B/op   2.81× slower
a &* b % mod  66.23  ( 15.10ms) (± 3.36%)  0.0B/op   2.84× slower
 a * b % MOD 187.86  (  5.32ms) (± 3.18%)  0.0B/op        fastest
a &* b % MOD 187.08  (  5.35ms) (± 2.38%)  0.0B/op   1.00× slower
bt.mul(a, b) 173.90  (  5.75ms) (± 3.44%)  0.0B/op   1.08× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 268.71  (  3.72ms) (± 4.16%)   106kB/op        fastest
 Scanner.s.to_i8 137.66  (  7.26ms) (± 4.33%)  2.52MB/op   1.95× slower
     Scanner.i16 245.66  (  4.07ms) (± 3.86%)   204kB/op        fastest
Scanner.s.to_i16 128.91  (  7.76ms) (± 5.05%)  3.26MB/op   1.91× slower
     Scanner.i32 209.78  (  4.77ms) (± 4.25%)   399kB/op        fastest
Scanner.s.to_i32 108.93  (  9.18ms) (± 7.20%)  3.46MB/op   1.93× slower
     Scanner.i64 143.96  (  6.95ms) (± 5.22%)  790kB/op        fastest
Scanner.s.to_i64  87.03  ( 11.49ms) (± 5.00%)  5.3MB/op   1.65× slower
      Scanner.u8 432.60  (  2.31ms) (± 6.90%)   106kB/op        fastest
 Scanner.s.to_u8 144.12  (  6.94ms) (± 4.59%)  2.57MB/op   3.00× slower
     Scanner.u16 403.01  (  2.48ms) (±10.51%)   204kB/op        fastest
Scanner.s.to_u16 132.07  (  7.57ms) (± 6.91%)  3.26MB/op   3.05× slower
     Scanner.u32 278.69  (  3.59ms) (± 5.54%)   399kB/op        fastest
Scanner.s.to_u32 110.92  (  9.02ms) (± 4.09%)  3.46MB/op   2.51× slower
     Scanner.u64 176.82  (  5.66ms) (± 3.02%)   790kB/op        fastest
Scanner.s.to_u64  82.82  ( 12.07ms) (± 3.59%)  5.31MB/op   2.14× slower
```

