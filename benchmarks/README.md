# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   222.72k (  4.49µs) (± 1.60%)  1.72kB/op  fastest
Int32 10^2 dence    218.11k (  4.58µs) (± 1.30%)  1.72kB/op  fastest
Int32 10^6 sparse     5.55  (180.32ms) (± 1.90%)  12.0MB/op  fastest
Int32 10^6 dence      4.92  (203.07ms) (± 1.65%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.01  (331.69ms) (± 1.21%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.48  (287.03ms) (± 1.44%)  12.0MB/op  fastest
SlowC 10^6 * 10^2    92.52m ( 10.81s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.98k (251.57µs) (± 2.42%)  141kB/op  fastest
Int32 1e3          3.35k (298.91µs) (± 1.60%)  141kB/op  fastest
Int32 1e6 sorted 866.24m (  1.15s ) (± 1.00%)  137MB/op  fastest
Int32 1e6        483.28m (  2.07s ) (± 2.09%)  137MB/op  fastest
Int32 1e3 * 1e3  784.80m (  1.27s ) (± 0.62%)  137MB/op  fastest
Array 1e6 * 1e2  209.00m (  4.78s ) (± 0.56%)  183MB/op  fastest
class 1e6        934.51m (  1.07s ) (± 3.16%)  183MB/op  fastest
SlowC 1e6 * 1e2   92.52m ( 10.81s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.69  (271.08ms) (±15.09%)  137MB/op  fastest
Int32 1e5+9e5   4.61  (216.80ms) (± 9.32%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.62k (276.21µs) (± 1.02%)  188kB/op  fastest
Int32 1e3          2.67k (374.02µs) (± 1.59%)  188kB/op  fastest
Int32 1e6 sorted 695.99m (  1.44s ) (± 1.67%)  183MB/op  fastest
Int32 1e6        365.56m (  2.74s ) (± 0.29%)  183MB/op  fastest
Int32 1e3 * 1e3  420.96m (  2.38s ) (± 0.91%)  183MB/op  fastest
Array 1e6 * 1e2  149.77m (  6.68s ) (± 0.00%)  244MB/op  fastest
class 1e6        414.90m (  2.41s ) (± 2.19%)  244MB/op  fastest
SlowC 1e6 * 1e2   45.92m ( 21.78s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.82  (207.44ms) (±25.83%)  137MB/op  fastest
Int32 1e5+9e5   6.78  (147.47ms) (±12.50%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.44k (290.77µs) (± 1.64%)  141kB/op  fastest
Int32 1e3          2.61k (383.14µs) (± 1.83%)  141kB/op  fastest
Int32 1e6 sorted 799.39m (  1.25s ) (± 0.46%)  137MB/op  fastest
Int32 1e6        464.00m (  2.16s ) (± 0.25%)  137MB/op  fastest
Int32 1e3 * 1e3   11.29  ( 88.57ms) (± 1.66%)  141kB/op  fastest
Array 1e6 * 1e2  191.22m (  5.23s ) (± 0.00%)  183MB/op  fastest
class 1e6         18.08  ( 55.31ms) (± 1.74%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  334.62m (  2.99s ) (± 0.02%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.74  (364.66ms) (±11.59%)  137MB/op  fastest
Int32 1e5+9e5   3.37  (296.79ms) (± 7.47%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.60k (277.85µs) (± 1.24%)  188kB/op  fastest
Int32 1e3          2.59k (385.58µs) (± 1.69%)  188kB/op  fastest
Int32 1e6 sorted 693.70m (  1.44s ) (± 0.84%)  183MB/op  fastest
Int32 1e6        361.02m (  2.77s ) (± 1.00%)  183MB/op  fastest
Int32 1e3 * 1e3    5.33  (187.54ms) (± 2.41%)  137MB/op  fastest
Array 1e6 * 1e2  152.62m (  6.55s ) (± 0.00%)  244MB/op  fastest
class 1e6          6.57  (152.22ms) (±10.64%)  183MB/op  fastest
SlowC 1e6 * 1e2  219.20m (  4.56s ) (± 1.07%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.31  (188.45ms) (±31.61%)  137MB/op  fastest
Int32 1e5+9e5   6.64  (150.63ms) (±13.21%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  74.69  ( 13.39ms) (± 0.89%)  0.0B/op  34.34× slower
a &* b % mod  75.21  ( 13.30ms) (± 1.21%)  0.0B/op  34.11× slower
 a * b % MOD   2.57k (389.83µs) (± 1.57%)  0.0B/op        fastest
a &* b % MOD   2.54k (393.09µs) (± 1.41%)  0.0B/op   1.01× slower
bt.mul(a, b) 170.74  (  5.86ms) (± 1.64%)  0.0B/op  15.02× slower

-------- mod: 100000 --------
 a * b % mod  75.02  ( 13.33ms) (± 1.30%)  0.0B/op   2.64× slower
a &* b % mod  75.28  ( 13.28ms) (± 1.37%)  0.0B/op   2.63× slower
 a * b % MOD 195.90  (  5.10ms) (± 1.34%)  0.0B/op   1.01× slower
a &* b % MOD 198.03  (  5.05ms) (± 1.73%)  0.0B/op        fastest
bt.mul(a, b) 173.42  (  5.77ms) (± 1.78%)  0.0B/op   1.14× slower

-------- mod: 1000000000 --------
 a * b % mod  72.50  ( 13.79ms) (± 2.04%)  0.0B/op   2.75× slower
a &* b % mod  71.30  ( 14.02ms) (± 1.77%)  0.0B/op   2.80× slower
 a * b % MOD 199.39  (  5.02ms) (± 1.78%)  0.0B/op        fastest
a &* b % MOD 197.97  (  5.05ms) (± 1.70%)  0.0B/op   1.01× slower
bt.mul(a, b) 172.19  (  5.81ms) (± 1.56%)  0.0B/op   1.16× slower

-------- mod: 1000000007 --------
 a * b % mod  71.39  ( 14.01ms) (± 1.64%)  0.0B/op   3.02× slower
a &* b % mod  71.80  ( 13.93ms) (± 1.87%)  0.0B/op   3.01× slower
 a * b % MOD 215.90  (  4.63ms) (± 1.86%)  0.0B/op        fastest
a &* b % MOD 213.31  (  4.69ms) (± 2.05%)  0.0B/op   1.01× slower
bt.mul(a, b) 171.60  (  5.83ms) (± 1.57%)  0.0B/op   1.26× slower

-------- mod: 2147483647 --------
 a * b % mod  70.73  ( 14.14ms) (± 1.61%)  0.0B/op   2.61× slower
a &* b % mod  71.59  ( 13.97ms) (± 1.74%)  0.0B/op   2.58× slower
 a * b % MOD 184.48  (  5.42ms) (± 1.47%)  0.0B/op        fastest
a &* b % MOD 182.83  (  5.47ms) (± 1.66%)  0.0B/op   1.01× slower
bt.mul(a, b) 170.54  (  5.86ms) (± 1.47%)  0.0B/op   1.08× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 257.29  (  3.89ms) (± 1.92%)   106kB/op        fastest
 Scanner.s.to_i8 128.26  (  7.80ms) (± 1.71%)  2.51MB/op   2.01× slower
     Scanner.i16 228.30  (  4.38ms) (± 1.19%)   204kB/op        fastest
Scanner.s.to_i16 113.07  (  8.84ms) (± 1.46%)  3.26MB/op   2.02× slower
     Scanner.i32 187.14  (  5.34ms) (± 1.64%)   399kB/op        fastest
Scanner.s.to_i32  92.47  ( 10.81ms) (± 1.28%)  3.46MB/op   2.02× slower
     Scanner.i64 126.85  (  7.88ms) (± 1.33%)   790kB/op        fastest
Scanner.s.to_i64  69.98  ( 14.29ms) (± 2.01%)  5.29MB/op   1.81× slower
      Scanner.u8 364.29  (  2.75ms) (± 1.51%)   106kB/op        fastest
 Scanner.s.to_u8 133.14  (  7.51ms) (± 1.78%)  2.57MB/op   2.74× slower
     Scanner.u16 361.53  (  2.77ms) (± 2.20%)   204kB/op        fastest
Scanner.s.to_u16 124.06  (  8.06ms) (± 1.52%)  3.26MB/op   2.91× slower
     Scanner.u32 269.39  (  3.71ms) (± 2.04%)   399kB/op        fastest
Scanner.s.to_u32  99.37  ( 10.06ms) (± 1.36%)  3.46MB/op   2.71× slower
     Scanner.u64 172.94  (  5.78ms) (± 1.55%)  790kB/op        fastest
Scanner.s.to_u64  67.65  ( 14.78ms) (± 0.81%)  5.3MB/op   2.56× slower
```

