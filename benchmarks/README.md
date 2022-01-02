# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   216.42k (  4.62µs) (± 0.64%)  1.72kB/op  fastest
Int32 10^2 dence    212.50k (  4.71µs) (± 0.62%)  1.72kB/op  fastest
Int32 10^6 sparse     5.33  (187.49ms) (± 0.32%)  12.0MB/op  fastest
Int32 10^6 dence      4.70  (212.64ms) (± 0.47%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.89  (346.04ms) (± 0.16%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.38  (295.84ms) (± 0.19%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   102.72m (  9.73s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.87k (258.65µs) (± 0.32%)  141kB/op  fastest
Int32 1e3          3.21k (311.30µs) (± 0.39%)  141kB/op  fastest
Int32 1e6 sorted 965.34m (  1.04s ) (± 1.66%)  137MB/op  fastest
Int32 1e6        575.77m (  1.74s ) (± 0.73%)  137MB/op  fastest
Int32 1e3 * 1e3    1.14  (874.86ms) (± 1.26%)  137MB/op  fastest
Array 1e6 * 1e2  274.25m (  3.65s ) (± 0.68%)  183MB/op  fastest
class 1e6          1.31  (763.88ms) (± 4.60%)  183MB/op  fastest
SlowC 1e6 * 1e2  100.59m (  9.94s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.73  (268.02ms) (±15.65%)  137MB/op  fastest
Int32 1e5+9e5   4.61  (216.99ms) (± 9.25%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.52k (284.08µs) (± 0.62%)  188kB/op  fastest
Int32 1e3          2.59k (385.87µs) (± 0.31%)  188kB/op  fastest
Int32 1e6 sorted 791.59m (  1.26s ) (± 2.22%)  183MB/op  fastest
Int32 1e6        436.12m (  2.29s ) (± 2.32%)  183MB/op  fastest
Int32 1e3 * 1e3  547.32m (  1.83s ) (± 1.90%)  183MB/op  fastest
Array 1e6 * 1e2  203.90m (  4.90s ) (± 1.19%)  244MB/op  fastest
class 1e6        539.71m (  1.85s ) (± 4.11%)  244MB/op  fastest
SlowC 1e6 * 1e2   51.87m ( 19.28s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.75  (210.43ms) (±26.12%)  137MB/op  fastest
Int32 1e5+9e5   6.57  (152.24ms) (±12.56%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.34k (299.70µs) (± 0.47%)  141kB/op  fastest
Int32 1e3          2.52k (397.06µs) (± 0.64%)  141kB/op  fastest
Int32 1e6 sorted 876.54m (  1.14s ) (± 1.84%)  137MB/op  fastest
Int32 1e6        516.93m (  1.93s ) (± 2.00%)  137MB/op  fastest
Int32 1e3 * 1e3   11.04  ( 90.59ms) (± 0.42%)  141kB/op  fastest
Array 1e6 * 1e2  248.43m (  4.03s ) (± 1.92%)  183MB/op  fastest
class 1e6         17.57  ( 56.91ms) (± 0.73%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  326.86m (  3.06s ) (± 0.02%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.78  (360.34ms) (±11.71%)  137MB/op  fastest
Int32 1e5+9e5   3.39  (295.23ms) (± 6.65%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.51k (284.50µs) (± 0.55%)  188kB/op  fastest
Int32 1e3          2.59k (386.50µs) (± 0.55%)  188kB/op  fastest
Int32 1e6 sorted 818.84m (  1.22s ) (± 0.66%)  183MB/op  fastest
Int32 1e6        452.53m (  2.21s ) (± 0.46%)  183MB/op  fastest
Int32 1e3 * 1e3    5.43  (184.20ms) (± 2.81%)  137MB/op  fastest
Array 1e6 * 1e2  201.30m (  4.97s ) (± 0.01%)  244MB/op  fastest
class 1e6          6.39  (156.52ms) (± 9.75%)  183MB/op  fastest
SlowC 1e6 * 1e2  215.91m (  4.63s ) (± 2.48%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.90  (204.27ms) (±22.96%)  137MB/op  fastest
Int32 1e5+9e5   6.47  (154.50ms) (±13.36%)  137MB/op  fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  73.86  ( 13.54ms) (± 0.22%)  0.0B/op  33.72× slower
a &* b % mod  73.80  ( 13.55ms) (± 0.16%)  0.0B/op  33.75× slower
 a * b % MOD   2.49k (401.54µs) (± 0.18%)  0.0B/op        fastest
a &* b % MOD   2.49k (401.98µs) (± 0.08%)  0.0B/op   1.00× slower
bt.mul(a, b) 165.84  (  6.03ms) (± 0.06%)  0.0B/op  15.02× slower

-------- mod: 100000 --------
 a * b % mod  69.53  ( 14.38ms) (± 0.06%)  0.0B/op   2.75× slower
a &* b % mod  69.54  ( 14.38ms) (± 0.08%)  0.0B/op   2.75× slower
 a * b % MOD 191.48  (  5.22ms) (± 0.08%)  0.0B/op        fastest
a &* b % MOD 191.42  (  5.22ms) (± 0.04%)  0.0B/op   1.00× slower
bt.mul(a, b) 165.84  (  6.03ms) (± 0.04%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  69.86  ( 14.31ms) (± 0.61%)  0.0B/op   2.74× slower
a &* b % mod  69.58  ( 14.37ms) (± 0.17%)  0.0B/op   2.75× slower
 a * b % MOD 191.63  (  5.22ms) (± 0.24%)  0.0B/op        fastest
a &* b % MOD 191.45  (  5.22ms) (± 0.44%)  0.0B/op   1.00× slower
bt.mul(a, b) 166.20  (  6.02ms) (± 0.24%)  0.0B/op   1.15× slower

-------- mod: 1000000007 --------
 a * b % mod  69.66  ( 14.35ms) (± 0.28%)  0.0B/op   2.99× slower
a &* b % mod  69.61  ( 14.37ms) (± 0.17%)  0.0B/op   2.99× slower
 a * b % MOD 208.34  (  4.80ms) (± 0.51%)  0.0B/op   1.00× slower
a &* b % MOD 208.35  (  4.80ms) (± 0.49%)  0.0B/op        fastest
bt.mul(a, b) 166.58  (  6.00ms) (± 0.41%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  69.83  ( 14.32ms) (± 0.44%)  0.0B/op   2.56× slower
a &* b % mod  69.62  ( 14.36ms) (± 0.63%)  0.0B/op   2.56× slower
 a * b % MOD 178.32  (  5.61ms) (± 0.43%)  0.0B/op   1.00× slower
a &* b % MOD 178.48  (  5.60ms) (± 0.38%)  0.0B/op        fastest
bt.mul(a, b) 166.17  (  6.02ms) (± 0.30%)  0.0B/op   1.07× slower
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 249.58  (  4.01ms) (± 0.33%)   106kB/op        fastest
 Scanner.s.to_i8 123.08  (  8.13ms) (± 3.62%)  2.51MB/op   2.03× slower
     Scanner.i16 225.23  (  4.44ms) (± 0.19%)   204kB/op        fastest
Scanner.s.to_i16 109.53  (  9.13ms) (± 1.50%)  3.26MB/op   2.06× slower
     Scanner.i32 180.61  (  5.54ms) (± 0.49%)   399kB/op        fastest
Scanner.s.to_i32  90.74  ( 11.02ms) (± 0.43%)  3.46MB/op   1.99× slower
     Scanner.i64 123.98  (  8.07ms) (± 0.42%)  790kB/op        fastest
Scanner.s.to_i64  67.41  ( 14.83ms) (± 1.04%)  5.3MB/op   1.84× slower
      Scanner.u8 365.84  (  2.73ms) (± 0.36%)   106kB/op        fastest
 Scanner.s.to_u8 131.35  (  7.61ms) (± 0.38%)  2.57MB/op   2.79× slower
     Scanner.u16 358.21  (  2.79ms) (± 0.31%)   204kB/op        fastest
Scanner.s.to_u16 120.60  (  8.29ms) (± 0.44%)  3.26MB/op   2.97× slower
     Scanner.u32 268.77  (  3.72ms) (± 0.46%)   399kB/op        fastest
Scanner.s.to_u32  97.45  ( 10.26ms) (± 0.78%)  3.46MB/op   2.76× slower
     Scanner.u64 177.34  (  5.64ms) (± 0.52%)   790kB/op        fastest
Scanner.s.to_u64  67.20  ( 14.88ms) (± 0.59%)  5.31MB/op   2.64× slower
```

