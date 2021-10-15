# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   227.01k (  4.41µs) (± 1.96%)  1.72kB/op  fastest
Int32 10^2 dence    222.52k (  4.49µs) (± 2.32%)  1.72kB/op  fastest
Int32 10^6 sparse     5.55  (180.28ms) (± 1.84%)  12.0MB/op  fastest
Int32 10^6 dence      4.91  (203.72ms) (± 1.65%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.04  (329.03ms) (± 1.71%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.51  (284.54ms) (± 1.96%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   109.97m (  9.09s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.08k (245.05µs) (± 2.48%)  141kB/op  fastest
Int32 1e3          3.42k (292.72µs) (± 1.91%)  141kB/op  fastest
Int32 1e6 sorted   1.09  (915.39ms) (± 4.32%)  137MB/op  fastest
Int32 1e6        705.61m (  1.42s ) (± 1.89%)  137MB/op  fastest
Int32 1e3 * 1e3    1.18  (846.85ms) (± 1.97%)  137MB/op  fastest
Array 1e6 * 1e2  306.53m (  3.26s ) (± 0.82%)  183MB/op  fastest
class 1e6          1.42  (704.32ms) (± 5.56%)  183MB/op  fastest
SlowC 1e6 * 1e2  122.40m (  8.17s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.94  (253.83ms) (±15.42%)  137MB/op  fastest
Int32 1e5+9e5   4.81  (208.03ms) (± 8.83%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.75k (267.00µs) (± 1.78%)  188kB/op  fastest
Int32 1e3          2.80k (357.72µs) (± 2.31%)  188kB/op  fastest
Int32 1e6 sorted 932.68m (  1.07s ) (± 3.27%)  183MB/op  fastest
Int32 1e6        540.61m (  1.85s ) (± 0.77%)  183MB/op  fastest
Int32 1e3 * 1e3  602.65m (  1.66s ) (± 1.73%)  183MB/op  fastest
Array 1e6 * 1e2  223.39m (  4.48s ) (± 3.16%)  244MB/op  fastest
class 1e6        595.51m (  1.68s ) (± 3.46%)  244MB/op  fastest
SlowC 1e6 * 1e2   56.89m ( 17.58s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.29  (189.08ms) (±22.41%)  137MB/op  fastest
Int32 1e5+9e5   7.08  (141.33ms) (±13.83%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.57k (280.09µs) (± 2.97%)  141kB/op  fastest
Int32 1e3          2.71k (368.35µs) (± 2.00%)  141kB/op  fastest
Int32 1e6 sorted   1.02  (978.53ms) (± 2.69%)  137MB/op  fastest
Int32 1e6        635.67m (  1.57s ) (± 2.41%)  137MB/op  fastest
Int32 1e3 * 1e3   11.86  ( 84.28ms) (± 2.76%)  141kB/op  fastest
Array 1e6 * 1e2  279.64m (  3.58s ) (± 1.60%)  183MB/op  fastest
class 1e6         18.92  ( 52.85ms) (± 2.86%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  347.63m (  2.88s ) (± 0.71%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.96  (338.03ms) (±19.00%)  137MB/op  fastest
Int32 1e5+9e5   3.54  (282.44ms) (± 7.85%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.74k (267.61µs) (± 2.45%)  188kB/op  fastest
Int32 1e3          2.73k (366.80µs) (± 2.14%)  188kB/op  fastest
Int32 1e6 sorted 917.88m (  1.09s ) (± 1.55%)  183MB/op  fastest
Int32 1e6        535.38m (  1.87s ) (± 0.84%)  183MB/op  fastest
Int32 1e3 * 1e3    5.81  (172.12ms) (± 2.56%)  137MB/op  fastest
Array 1e6 * 1e2  235.68m (  4.24s ) (± 1.18%)  244MB/op  fastest
class 1e6          6.74  (148.40ms) (± 9.87%)  183MB/op  fastest
SlowC 1e6 * 1e2  259.53m (  3.85s ) (± 5.05%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.13  (195.10ms) (±22.13%)  137MB/op  fastest
Int32 1e5+9e5   6.71  (149.02ms) (±13.89%)  137MB/op  fastest
```

## [math/barret.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barret.cr)

```
-------- mod: 1 --------
 a * b % mod  79.60  ( 12.56ms) (± 2.42%)  0.0B/op  33.88× slower
a &* b % mod  80.42  ( 12.43ms) (± 2.90%)  0.0B/op  33.54× slower
 a * b % MOD   2.70k (370.79µs) (± 2.70%)  0.0B/op        fastest
a &* b % MOD   2.69k (371.10µs) (± 2.39%)  0.0B/op   1.00× slower
bt.mul(a, b) 177.62  (  5.63ms) (± 2.15%)  0.0B/op  15.18× slower

-------- mod: 100000 --------
 a * b % mod  75.49  ( 13.25ms) (± 2.32%)  0.0B/op   2.75× slower
a &* b % mod  75.20  ( 13.30ms) (± 3.24%)  0.0B/op   2.76× slower
 a * b % MOD 207.78  (  4.81ms) (± 3.31%)  0.0B/op        fastest
a &* b % MOD 204.62  (  4.89ms) (± 3.14%)  0.0B/op   1.02× slower
bt.mul(a, b) 179.30  (  5.58ms) (± 3.13%)  0.0B/op   1.16× slower

-------- mod: 1000000000 --------
 a * b % mod  73.28  ( 13.65ms) (± 2.04%)  0.0B/op   2.74× slower
a &* b % mod  71.84  ( 13.92ms) (± 1.52%)  0.0B/op   2.79× slower
 a * b % MOD 195.54  (  5.11ms) (± 1.40%)  0.0B/op   1.03× slower
a &* b % MOD 200.51  (  4.99ms) (± 3.28%)  0.0B/op        fastest
bt.mul(a, b) 177.57  (  5.63ms) (± 2.56%)  0.0B/op   1.13× slower

-------- mod: 1000000007 --------
 a * b % mod  74.93  ( 13.34ms) (± 2.12%)  0.0B/op   3.01× slower
a &* b % mod  74.92  ( 13.35ms) (± 2.22%)  0.0B/op   3.01× slower
 a * b % MOD 222.44  (  4.50ms) (± 2.70%)  0.0B/op   1.01× slower
a &* b % MOD 225.36  (  4.44ms) (± 2.57%)  0.0B/op        fastest
bt.mul(a, b) 178.30  (  5.61ms) (± 2.39%)  0.0B/op   1.26× slower

-------- mod: 2147483647 --------
 a * b % mod  74.69  ( 13.39ms) (± 2.40%)  0.0B/op   2.59× slower
a &* b % mod  75.14  ( 13.31ms) (± 2.55%)  0.0B/op   2.57× slower
 a * b % MOD 193.10  (  5.18ms) (± 2.58%)  0.0B/op        fastest
a &* b % MOD 190.98  (  5.24ms) (± 2.42%)  0.0B/op   1.01× slower
bt.mul(a, b) 178.62  (  5.60ms) (± 3.57%)  0.0B/op   1.08× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 268.63  (  3.72ms) (± 2.50%)   106kB/op        fastest
 Scanner.s.to_i8 130.93  (  7.64ms) (± 2.14%)  2.51MB/op   2.05× slower
     Scanner.i16 234.23  (  4.27ms) (± 2.06%)   204kB/op        fastest
Scanner.s.to_i16 113.85  (  8.78ms) (± 1.72%)  3.26MB/op   2.06× slower
     Scanner.i32 195.62  (  5.11ms) (± 2.05%)   399kB/op        fastest
Scanner.s.to_i32  96.77  ( 10.33ms) (± 2.57%)  3.46MB/op   2.02× slower
     Scanner.i64 134.16  (  7.45ms) (± 2.06%)  790kB/op        fastest
Scanner.s.to_i64  71.92  ( 13.90ms) (± 2.07%)  5.3MB/op   1.87× slower
      Scanner.u8 386.25  (  2.59ms) (± 2.32%)   106kB/op        fastest
 Scanner.s.to_u8 139.27  (  7.18ms) (± 2.01%)  2.57MB/op   2.77× slower
     Scanner.u16 378.62  (  2.64ms) (± 2.37%)   204kB/op        fastest
Scanner.s.to_u16 126.04  (  7.93ms) (± 2.12%)  3.26MB/op   3.00× slower
     Scanner.u32 277.31  (  3.61ms) (± 1.89%)   399kB/op        fastest
Scanner.s.to_u32 103.92  (  9.62ms) (± 2.42%)  3.46MB/op   2.67× slower
     Scanner.u64 187.65  (  5.33ms) (± 2.50%)   790kB/op        fastest
Scanner.s.to_u64  70.61  ( 14.16ms) (± 2.17%)  5.31MB/op   2.66× slower
```

