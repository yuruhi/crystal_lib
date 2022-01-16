# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   239.95k (  4.17µs) (± 4.09%)  1.72kB/op  fastest
Int32 10^2 dence    227.10k (  4.40µs) (± 5.87%)  1.72kB/op  fastest
Int32 10^6 sparse     7.12  (140.36ms) (± 1.59%)  12.0MB/op  fastest
Int32 10^6 dence      6.24  (160.15ms) (± 1.97%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.22  (310.27ms) (± 1.91%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.05  (247.06ms) (± 1.62%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   119.93m (  8.34s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```

```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```

```

## [datastructure/sset.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset.cr)

```
#add (1e5 times)
   RBT  18.74  ( 53.37ms) (± 3.82%)  13.7MB/op   2.14× slower
 Treap  18.78  ( 53.26ms) (± 3.42%)  13.7MB/op   2.14× slower
Bucket  40.17  ( 24.89ms) (± 4.91%)  2.05MB/op        fastest

#add and #delete (1e5 times)
   RBT  11.86  ( 84.30ms) (± 5.03%)  13.7MB/op   1.82× slower
 Treap   9.82  (101.82ms) (± 6.46%)  18.3MB/op   2.20× slower
Bucket  21.61  ( 46.28ms) (± 3.50%)  2.05MB/op        fastest

#add (1e6 times)
   RBT   1.01  (985.66ms) (± 5.16%)   137MB/op   1.26× slower
 Treap 964.61m (  1.04s ) (± 6.72%)   137MB/op   1.33× slower
Bucket   1.28  (779.99ms) (± 1.59%)  20.6MB/op        fastest

#add (1e6 times) and #delete (1e6 times)
   RBT 594.98m (  1.68s ) (± 3.24%)   137MB/op   1.13× slower
 Treap 496.26m (  2.02s ) (± 1.55%)   183MB/op   1.36× slower
Bucket 673.82m (  1.48s ) (± 1.39%)  20.7MB/op        fastest

#each (1e6 elements)
   RBT  16.58  ( 60.32ms) (± 7.57%)  0.0B/op  86.85× slower
 Treap  14.93  ( 66.98ms) (± 4.07%)  0.0B/op  96.44× slower
Bucket   1.44k (694.52µs) (± 4.23%)  0.0B/op        fastest

#includes? (1e6 times with 5e5 elements)
   RBT  12.23  ( 81.80ms) (± 2.81%)  0.0B/op        fastest
 Treap   9.50  (105.31ms) (± 2.96%)  0.0B/op   1.29× slower
Bucket   5.70  (175.40ms) (± 4.01%)  0.0B/op   2.14× slower

#le (1e6 times with 5e5 elements)
   RBT   8.62  (116.05ms) (± 2.68%)  0.0B/op   1.10× slower
 Treap   9.46  (105.66ms) (± 3.04%)  0.0B/op        fastest
Bucket   5.88  (170.21ms) (± 6.14%)  0.0B/op   1.61× slower
```

## [datastructure/sset/bucket.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/bucket.cr)

```
-------- add, delete --------
Int32 1e3 sorted   9.53k (104.96µs) (±17.61%)  26.3kB/op           fastest
Int32 1e3          6.09k (164.19µs) (±11.00%)  23.2kB/op      1.56× slower
Int32 1e6 sorted 811.67m (  1.23s ) (± 4.27%)   368MB/op  11737.74× slower
Int32 1e6        658.49m (  1.52s ) (± 1.81%)  17.1MB/op  14468.17× slower
Int32 1e3 * 1e3   14.78  ( 67.67ms) (± 4.01%)  24.1kB/op    644.68× slower
Array 1e6 * 1e2  171.03m (  5.85s ) (± 0.00%)  34.0MB/op  55705.86× slower
class 1e6         18.06  ( 55.37ms) (± 4.91%)  2.68kB/op    527.49× slower
SlowC 1e6 * 1e2  326.78m (  3.06s ) (± 0.94%)   130kB/op  29154.60× slower
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.34k (299.63µs) (±29.61%)   141kB/op           fastest
Int32 1e3          2.75k (363.41µs) (±26.71%)   141kB/op      1.21× slower
Int32 1e6 sorted 952.17m (  1.05s ) (± 5.58%)   137MB/op   3505.08× slower
Int32 1e6        631.04m (  1.58s ) (± 3.77%)   137MB/op   5288.77× slower
Int32 1e3 * 1e3   13.89  ( 72.01ms) (± 2.69%)   141kB/op    240.32× slower
Array 1e6 * 1e2  266.79m (  3.75s ) (± 0.43%)   183MB/op  12509.52× slower
class 1e6         23.17  ( 43.15ms) (± 2.49%)  18.8kB/op    144.02× slower
SlowC 1e6 * 1e2  407.22m (  2.46s ) (± 0.23%)   426kB/op   8195.64× slower

-------- split --------
Int32 5e5+5e5   3.04  (329.36ms) (±19.51%)  137MB/op        fastest
Int32 1e5+9e5   3.01  (331.78ms) (±19.62%)  137MB/op   1.01× slower
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.51k (285.23µs) (±28.41%)  188kB/op           fastest
Int32 1e3          2.78k (359.90µs) (±25.27%)  188kB/op      1.26× slower
Int32 1e6 sorted 874.37m (  1.14s ) (± 7.45%)  183MB/op   4009.74× slower
Int32 1e6        518.56m (  1.93s ) (± 2.18%)  183MB/op   6760.95× slower
Int32 1e3 * 1e3    4.57  (218.71ms) (±26.18%)  137MB/op    766.80× slower
Array 1e6 * 1e2  220.85m (  4.53s ) (± 1.05%)  244MB/op  15875.27× slower
class 1e6          4.89  (204.58ms) (±31.08%)  183MB/op    717.26× slower
SlowC 1e6 * 1e2  268.94m (  3.72s ) (± 2.40%)  183MB/op  13036.42× slower

-------- split --------
Int32 5e5+5e5   5.56  (179.96ms) (±33.59%)  137MB/op        fastest
Int32 1e5+9e5   5.37  (186.14ms) (±34.33%)  137MB/op   1.03× slower
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  88.34  ( 11.32ms) (± 4.16%)  0.0B/op  32.63× slower
a &* b % mod  89.46  ( 11.18ms) (± 3.27%)  0.0B/op  32.22× slower
 a * b % MOD   2.88k (346.91µs) (± 1.85%)  0.0B/op        fastest
a &* b % MOD   2.86k (350.03µs) (± 2.78%)  0.0B/op   1.01× slower
bt.mul(a, b) 181.71  (  5.50ms) (± 2.59%)  0.0B/op  15.86× slower

-------- mod: 100000 --------
 a * b % mod  81.46  ( 12.28ms) (± 1.91%)  0.0B/op   2.77× slower
a &* b % mod  81.13  ( 12.33ms) (± 2.21%)  0.0B/op   2.78× slower
 a * b % MOD 223.91  (  4.47ms) (± 3.13%)  0.0B/op   1.01× slower
a &* b % MOD 225.45  (  4.44ms) (± 3.63%)  0.0B/op        fastest
bt.mul(a, b) 182.78  (  5.47ms) (± 2.48%)  0.0B/op   1.23× slower

-------- mod: 1000000000 --------
 a * b % mod  74.48  ( 13.43ms) (± 3.95%)  0.0B/op   3.01× slower
a &* b % mod  73.45  ( 13.61ms) (± 5.28%)  0.0B/op   3.05× slower
 a * b % MOD 224.35  (  4.46ms) (± 3.15%)  0.0B/op        fastest
a &* b % MOD 222.93  (  4.49ms) (± 4.00%)  0.0B/op   1.01× slower
bt.mul(a, b) 181.52  (  5.51ms) (± 3.40%)  0.0B/op   1.24× slower

-------- mod: 1000000007 --------
 a * b % mod  75.85  ( 13.18ms) (± 3.47%)  0.0B/op   3.21× slower
a &* b % mod  76.53  ( 13.07ms) (± 4.00%)  0.0B/op   3.18× slower
 a * b % MOD 243.13  (  4.11ms) (± 3.12%)  0.0B/op        fastest
a &* b % MOD 241.65  (  4.14ms) (± 3.28%)  0.0B/op   1.01× slower
bt.mul(a, b) 182.91  (  5.47ms) (± 2.06%)  0.0B/op   1.33× slower

-------- mod: 2147483647 --------
 a * b % mod  74.08  ( 13.50ms) (± 3.77%)  0.0B/op   2.77× slower
a &* b % mod  73.90  ( 13.53ms) (± 3.57%)  0.0B/op   2.77× slower
 a * b % MOD 200.08  (  5.00ms) (± 4.67%)  0.0B/op   1.02× slower
a &* b % MOD 205.07  (  4.88ms) (± 3.10%)  0.0B/op        fastest
bt.mul(a, b) 180.08  (  5.55ms) (± 3.51%)  0.0B/op   1.14× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.74  (174.34ms) (± 3.43%)  44.2MB/op   2.81× slower
SieveFast#new  16.14  ( 61.96ms) (± 6.93%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 297.95  (  3.36ms) (± 3.06%)   106kB/op        fastest
 Scanner.s.to_i8 152.99  (  6.54ms) (± 2.74%)  2.51MB/op   1.95× slower
     Scanner.i16 274.41  (  3.64ms) (± 2.39%)   204kB/op        fastest
Scanner.s.to_i16 137.35  (  7.28ms) (± 3.93%)  3.26MB/op   2.00× slower
     Scanner.i32 218.94  (  4.57ms) (± 3.19%)   399kB/op        fastest
Scanner.s.to_i32 112.58  (  8.88ms) (± 2.78%)  3.46MB/op   1.94× slower
     Scanner.i64 146.64  (  6.82ms) (± 3.12%)  790kB/op        fastest
Scanner.s.to_i64  87.55  ( 11.42ms) (± 2.91%)  5.3MB/op   1.67× slower
      Scanner.u8 476.61  (  2.10ms) (± 2.64%)   106kB/op        fastest
 Scanner.s.to_u8 158.85  (  6.30ms) (± 3.78%)  2.57MB/op   3.00× slower
     Scanner.u16 463.98  (  2.16ms) (± 4.79%)   204kB/op        fastest
Scanner.s.to_u16 150.43  (  6.65ms) (± 3.49%)  3.26MB/op   3.08× slower
     Scanner.u32 324.75  (  3.08ms) (± 5.39%)   399kB/op        fastest
Scanner.s.to_u32 118.09  (  8.47ms) (± 5.09%)  3.46MB/op   2.75× slower
     Scanner.u64 205.80  (  4.86ms) (± 5.72%)  790kB/op        fastest
Scanner.s.to_u64  88.21  ( 11.34ms) (± 1.88%)  5.3MB/op   2.33× slower
```

