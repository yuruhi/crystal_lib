# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   222.90k (  4.49µs) (± 8.18%)  1.72kB/op  fastest
Int32 10^2 dence    256.71k (  3.90µs) (± 4.31%)  1.72kB/op  fastest
Int32 10^6 sparse     7.80  (128.27ms) (± 4.85%)  12.0MB/op  fastest
Int32 10^6 dence      6.54  (152.83ms) (± 6.77%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.53  (282.93ms) (± 4.04%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.13  (242.24ms) (± 5.29%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   116.17m (  8.61s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   5.13k (194.94µs) (± 6.04%)  141kB/op  fastest
Int32 1e3          4.26k (234.86µs) (± 6.74%)  141kB/op  fastest
Int32 1e6 sorted   1.14  (878.22ms) (± 2.59%)  137MB/op  fastest
Int32 1e6        713.92m (  1.40s ) (± 2.01%)  137MB/op  fastest
Int32 1e3 * 1e3    1.01  (987.67ms) (± 3.14%)  137MB/op  fastest
Array 1e6 * 1e2  295.51m (  3.38s ) (± 0.68%)  183MB/op  fastest
class 1e6          1.13  (882.33ms) (± 3.12%)  183MB/op  fastest
SlowC 1e6 * 1e2  126.44m (  7.91s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.93  (254.72ms) (±19.16%)  137MB/op  fastest
Int32 1e5+9e5   4.94  (202.41ms) (±10.61%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.15k (241.03µs) (± 5.04%)  188kB/op  fastest
Int32 1e3          3.29k (304.17µs) (± 6.80%)  188kB/op  fastest
Int32 1e6 sorted 973.19m (  1.03s ) (± 1.17%)  183MB/op  fastest
Int32 1e6        534.44m (  1.87s ) (± 2.48%)  183MB/op  fastest
Int32 1e3 * 1e3  583.87m (  1.71s ) (± 0.51%)  183MB/op  fastest
Array 1e6 * 1e2  228.33m (  4.38s ) (± 0.97%)  244MB/op  fastest
class 1e6        552.26m (  1.81s ) (± 5.35%)  244MB/op  fastest
SlowC 1e6 * 1e2   65.87m ( 15.18s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.26  (190.28ms) (±30.81%)  137MB/op  fastest
Int32 1e5+9e5   7.51  (133.12ms) (±17.11%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.37k (228.72µs) (± 5.01%)  141kB/op  fastest
Int32 1e3          3.56k (281.02µs) (± 4.83%)  141kB/op  fastest
Int32 1e6 sorted   1.07  (935.59ms) (± 0.94%)  137MB/op  fastest
Int32 1e6        638.36m (  1.57s ) (± 3.81%)  137MB/op  fastest
Int32 1e3 * 1e3   14.10  ( 70.95ms) (± 9.29%)  141kB/op  fastest
Array 1e6 * 1e2  281.13m (  3.56s ) (± 0.46%)  183MB/op  fastest
class 1e6         25.67  ( 38.96ms) (± 6.12%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  412.68m (  2.42s ) (± 1.01%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.15  (317.92ms) (±14.39%)  137MB/op  fastest
Int32 1e5+9e5   3.80  (262.82ms) (± 9.45%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.60k (217.46µs) (± 5.17%)  188kB/op  fastest
Int32 1e3          3.46k (288.78µs) (± 4.18%)  188kB/op  fastest
Int32 1e6 sorted 881.91m (  1.13s ) (± 3.80%)  183MB/op  fastest
Int32 1e6        474.24m (  2.11s ) (± 2.59%)  183MB/op  fastest
Int32 1e3 * 1e3    5.39  (185.38ms) (± 4.84%)  137MB/op  fastest
Array 1e6 * 1e2  190.74m (  5.24s ) (± 0.00%)  244MB/op  fastest
class 1e6          6.70  (149.28ms) (±13.03%)  183MB/op  fastest
SlowC 1e6 * 1e2  282.05m (  3.55s ) (± 5.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.96  (201.60ms) (±25.42%)  137MB/op  fastest
Int32 1e5+9e5   7.33  (136.38ms) (±15.78%)  137MB/op  fastest
```

## [math/barret.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barret.cr)

```
-------- mod: 1 --------
 a * b % mod  85.98  ( 11.63ms) (± 5.25%)  0.0B/op  36.95× slower
a &* b % mod  92.80  ( 10.78ms) (± 6.79%)  0.0B/op  34.24× slower
 a * b % MOD   3.18k (314.73µs) (± 4.47%)  0.0B/op        fastest
a &* b % MOD   3.16k (316.16µs) (± 5.30%)  0.0B/op   1.00× slower
bt.mul(a, b) 200.68  (  4.98ms) (± 6.34%)  0.0B/op  15.83× slower

-------- mod: 100000 --------
 a * b % mod  85.43  ( 11.71ms) (± 6.41%)  0.0B/op   2.70× slower
a &* b % mod  82.82  ( 12.07ms) (± 5.55%)  0.0B/op   2.79× slower
 a * b % MOD 230.92  (  4.33ms) (± 3.85%)  0.0B/op        fastest
a &* b % MOD 228.79  (  4.37ms) (± 4.40%)  0.0B/op   1.01× slower
bt.mul(a, b) 190.75  (  5.24ms) (± 6.33%)  0.0B/op   1.21× slower

-------- mod: 1000000000 --------
 a * b % mod  73.94  ( 13.52ms) (± 5.16%)  0.0B/op   3.31× slower
a &* b % mod  77.15  ( 12.96ms) (± 7.30%)  0.0B/op   3.17× slower
 a * b % MOD 244.06  (  4.10ms) (± 5.15%)  0.0B/op   1.00× slower
a &* b % MOD 244.43  (  4.09ms) (± 6.14%)  0.0B/op        fastest
bt.mul(a, b) 212.05  (  4.72ms) (± 4.88%)  0.0B/op   1.15× slower

-------- mod: 1000000007 --------
 a * b % mod  83.11  ( 12.03ms) (± 4.56%)  0.0B/op   3.21× slower
a &* b % mod  81.77  ( 12.23ms) (± 6.49%)  0.0B/op   3.26× slower
 a * b % MOD 266.43  (  3.75ms) (± 4.56%)  0.0B/op        fastest
a &* b % MOD 260.99  (  3.83ms) (± 7.89%)  0.0B/op   1.02× slower
bt.mul(a, b) 212.61  (  4.70ms) (± 5.67%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  76.96  ( 12.99ms) (± 7.86%)  0.0B/op   2.94× slower
a &* b % mod  76.84  ( 13.01ms) (± 6.93%)  0.0B/op   2.94× slower
 a * b % MOD 225.75  (  4.43ms) (± 4.51%)  0.0B/op   1.00× slower
a &* b % MOD 225.90  (  4.43ms) (± 3.91%)  0.0B/op        fastest
bt.mul(a, b) 202.62  (  4.94ms) (± 7.23%)  0.0B/op   1.11× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 305.99  (  3.27ms) (± 6.89%)   106kB/op        fastest
 Scanner.s.to_i8 142.44  (  7.02ms) (± 4.44%)  2.51MB/op   2.15× slower
     Scanner.i16 254.21  (  3.93ms) (± 4.80%)   204kB/op        fastest
Scanner.s.to_i16 130.82  (  7.64ms) (± 5.78%)  3.26MB/op   1.94× slower
     Scanner.i32 231.48  (  4.32ms) (± 5.70%)   399kB/op        fastest
Scanner.s.to_i32 109.60  (  9.12ms) (± 5.09%)  3.46MB/op   2.11× slower
     Scanner.i64 151.56  (  6.60ms) (± 6.82%)  790kB/op        fastest
Scanner.s.to_i64  91.75  ( 10.90ms) (± 4.68%)  5.3MB/op   1.65× slower
      Scanner.u8 486.19  (  2.06ms) (± 6.20%)   106kB/op        fastest
 Scanner.s.to_u8 161.95  (  6.17ms) (± 7.80%)  2.57MB/op   3.00× slower
     Scanner.u16 499.49  (  2.00ms) (± 4.43%)   204kB/op        fastest
Scanner.s.to_u16 156.36  (  6.40ms) (± 4.00%)  3.26MB/op   3.19× slower
     Scanner.u32 340.59  (  2.94ms) (± 7.83%)   399kB/op        fastest
Scanner.s.to_u32 132.27  (  7.56ms) (± 6.05%)  3.46MB/op   2.58× slower
     Scanner.u64 217.13  (  4.61ms) (± 4.06%)   790kB/op        fastest
Scanner.s.to_u64  99.61  ( 10.04ms) (± 4.85%)  5.31MB/op   2.18× slower
```

