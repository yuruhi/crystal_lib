# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   260.41k (  3.84µs) (± 0.29%)  1.72kB/op  fastest
Int32 10^2 dence    255.22k (  3.92µs) (± 0.28%)  1.72kB/op  fastest
Int32 10^6 sparse     6.39  (156.52ms) (± 0.37%)  12.0MB/op  fastest
Int32 10^6 dence      5.66  (176.68ms) (± 0.10%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.47  (287.89ms) (± 0.08%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.03  (248.27ms) (± 1.90%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   105.54m (  9.48s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.60k (217.20µs) (± 0.54%)  141kB/op  fastest
Int32 1e3          3.86k (258.87µs) (± 0.17%)  141kB/op  fastest
Int32 1e6 sorted   1.04  (959.29ms) (± 2.47%)  137MB/op  fastest
Int32 1e6        645.40m (  1.55s ) (± 1.20%)  137MB/op  fastest
Int32 1e3 * 1e3    1.24  (806.66ms) (± 0.87%)  137MB/op  fastest
Array 1e6 * 1e2  282.37m (  3.54s ) (± 0.27%)  183MB/op  fastest
class 1e6          1.46  (684.77ms) (± 5.29%)  183MB/op  fastest
SlowC 1e6 * 1e2  128.07m (  7.81s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.19  (238.87ms) (±17.01%)  137MB/op  fastest
Int32 1e5+9e5   5.26  (190.18ms) (±11.22%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.20k (238.05µs) (± 0.15%)  188kB/op  fastest
Int32 1e3          3.13k (319.31µs) (± 0.56%)  188kB/op  fastest
Int32 1e6 sorted 894.62m (  1.12s ) (± 2.32%)  183MB/op  fastest
Int32 1e6        512.71m (  1.95s ) (± 0.94%)  183MB/op  fastest
Int32 1e3 * 1e3  603.81m (  1.66s ) (± 0.52%)  183MB/op  fastest
Array 1e6 * 1e2  222.38m (  4.50s ) (± 1.90%)  244MB/op  fastest
class 1e6        607.00m (  1.65s ) (± 3.73%)  244MB/op  fastest
SlowC 1e6 * 1e2   66.08m ( 15.13s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.55  (180.27ms) (±23.46%)  137MB/op  fastest
Int32 1e5+9e5   7.66  (130.46ms) (±14.67%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.01k (249.61µs) (± 0.19%)  141kB/op  fastest
Int32 1e3          3.04k (328.77µs) (± 0.17%)  141kB/op  fastest
Int32 1e6 sorted 981.35m (  1.02s ) (± 1.42%)  137MB/op  fastest
Int32 1e6        606.09m (  1.65s ) (± 3.98%)  137MB/op  fastest
Int32 1e3 * 1e3   13.17  ( 75.90ms) (± 0.58%)  141kB/op  fastest
Array 1e6 * 1e2  265.17m (  3.77s ) (± 1.97%)  183MB/op  fastest
class 1e6         21.04  ( 47.52ms) (± 0.52%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  393.40m (  2.54s ) (± 0.12%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.18  (314.42ms) (±14.47%)  137MB/op  fastest
Int32 1e5+9e5   3.93  (254.13ms) (± 8.51%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.25k (235.38µs) (± 0.50%)  188kB/op  fastest
Int32 1e3          3.12k (320.61µs) (± 0.16%)  188kB/op  fastest
Int32 1e6 sorted 888.20m (  1.13s ) (± 0.97%)  183MB/op  fastest
Int32 1e6        518.44m (  1.93s ) (± 0.80%)  183MB/op  fastest
Int32 1e3 * 1e3    6.27  (159.39ms) (± 2.51%)  137MB/op  fastest
Array 1e6 * 1e2  226.69m (  4.41s ) (± 1.28%)  244MB/op  fastest
class 1e6          7.30  (136.93ms) (±11.49%)  183MB/op  fastest
SlowC 1e6 * 1e2  246.45m (  4.06s ) (± 2.35%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.98  (200.72ms) (±26.22%)  137MB/op  fastest
Int32 1e5+9e5   7.52  (132.91ms) (±14.62%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  88.60  ( 11.29ms) (± 0.01%)  0.0B/op  33.73× slower
a &* b % mod  88.59  ( 11.29ms) (± 0.02%)  0.0B/op  33.73× slower
 a * b % MOD   2.99k (334.64µs) (± 0.03%)  0.0B/op        fastest
a &* b % MOD   2.99k (334.66µs) (± 0.03%)  0.0B/op   1.00× slower
bt.mul(a, b) 199.03  (  5.02ms) (± 0.46%)  0.0B/op  15.01× slower

-------- mod: 100000 --------
 a * b % mod  83.38  ( 11.99ms) (± 0.50%)  0.0B/op   2.76× slower
a &* b % mod  83.51  ( 11.98ms) (± 0.03%)  0.0B/op   2.75× slower
 a * b % MOD 229.89  (  4.35ms) (± 0.02%)  0.0B/op   1.00× slower
a &* b % MOD 229.89  (  4.35ms) (± 0.04%)  0.0B/op        fastest
bt.mul(a, b) 199.16  (  5.02ms) (± 0.03%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  83.51  ( 11.97ms) (± 0.02%)  0.0B/op   2.75× slower
a &* b % mod  83.50  ( 11.98ms) (± 0.04%)  0.0B/op   2.75× slower
 a * b % MOD 229.88  (  4.35ms) (± 0.04%)  0.0B/op   1.00× slower
a &* b % MOD 229.89  (  4.35ms) (± 0.02%)  0.0B/op        fastest
bt.mul(a, b) 199.16  (  5.02ms) (± 0.02%)  0.0B/op   1.15× slower

-------- mod: 1000000007 --------
 a * b % mod  83.50  ( 11.98ms) (± 0.03%)  0.0B/op   2.98× slower
a &* b % mod  83.50  ( 11.98ms) (± 0.02%)  0.0B/op   2.98× slower
 a * b % MOD 249.01  (  4.02ms) (± 0.02%)  0.0B/op   1.00× slower
a &* b % MOD 249.04  (  4.02ms) (± 0.04%)  0.0B/op        fastest
bt.mul(a, b) 199.16  (  5.02ms) (± 0.02%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  83.50  ( 11.98ms) (± 0.04%)  0.0B/op   2.56× slower
a &* b % mod  83.50  ( 11.98ms) (± 0.02%)  0.0B/op   2.56× slower
 a * b % MOD 213.46  (  4.68ms) (± 0.02%)  0.0B/op        fastest
a &* b % MOD 213.45  (  4.68ms) (± 0.02%)  0.0B/op   1.00× slower
bt.mul(a, b) 199.17  (  5.02ms) (± 0.03%)  0.0B/op   1.07× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.54  (180.63ms) (± 1.74%)  44.2MB/op   2.71× slower
SieveFast#new  15.02  ( 66.58ms) (± 2.69%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 296.78  (  3.37ms) (± 0.44%)   106kB/op        fastest
 Scanner.s.to_i8 150.09  (  6.66ms) (± 0.19%)  2.51MB/op   1.98× slower
     Scanner.i16 270.09  (  3.70ms) (± 0.17%)   204kB/op        fastest
Scanner.s.to_i16 133.07  (  7.51ms) (± 0.50%)  3.26MB/op   2.03× slower
     Scanner.i32 216.48  (  4.62ms) (± 0.16%)   399kB/op        fastest
Scanner.s.to_i32 109.77  (  9.11ms) (± 0.31%)  3.46MB/op   1.97× slower
     Scanner.i64 146.69  (  6.82ms) (± 0.63%)  790kB/op        fastest
Scanner.s.to_i64  80.77  ( 12.38ms) (± 0.93%)  5.3MB/op   1.82× slower
      Scanner.u8 436.32  (  2.29ms) (± 0.16%)   106kB/op        fastest
 Scanner.s.to_u8 157.88  (  6.33ms) (± 0.11%)  2.57MB/op   2.76× slower
     Scanner.u16 429.45  (  2.33ms) (± 0.22%)   204kB/op        fastest
Scanner.s.to_u16 145.19  (  6.89ms) (± 0.25%)  3.26MB/op   2.96× slower
     Scanner.u32 321.94  (  3.11ms) (± 0.16%)   399kB/op        fastest
Scanner.s.to_u32 117.74  (  8.49ms) (± 0.27%)  3.46MB/op   2.73× slower
     Scanner.u64 214.02  (  4.67ms) (± 0.21%)   790kB/op        fastest
Scanner.s.to_u64  80.73  ( 12.39ms) (± 0.32%)  5.31MB/op   2.65× slower
```

