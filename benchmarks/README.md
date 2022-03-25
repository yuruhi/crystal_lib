# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   252.54k (  3.96µs) (± 5.57%)  1.72kB/op  fastest
Int32 10^2 dence    243.30k (  4.11µs) (± 4.50%)  1.72kB/op  fastest
Int32 10^6 sparse     7.05  (141.87ms) (± 2.27%)  12.0MB/op  fastest
Int32 10^6 dence      6.15  (162.59ms) (± 3.63%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.22  (310.64ms) (± 4.29%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.99  (250.41ms) (± 4.73%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   125.65m (  7.96s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.81k (262.71µs) (±28.73%)  141kB/op           fastest
Int32 1e3          3.40k (294.22µs) (±26.95%)  141kB/op      1.12× slower
Int32 1e6 sorted   1.16  (862.66ms) (± 7.72%)  137MB/op   3283.70× slower
Int32 1e6        688.83m (  1.45s ) (± 8.18%)  137MB/op   5526.03× slower
Int32 1e3 * 1e3    1.15  (870.00ms) (± 6.41%)  137MB/op   3311.64× slower
Array 1e6 * 1e2  303.64m (  3.29s ) (± 4.75%)  183MB/op  12536.05× slower
class 1e6        998.83m (  1.00s ) (±10.13%)  183MB/op   3810.97× slower
SlowC 1e6 * 1e2  140.04m (  7.14s ) (± 0.00%)  183MB/op  27180.88× slower

-------- split --------
Int32 5e5+5e5   3.95  (252.90ms) (±25.02%)  137MB/op   1.00× slower
Int32 1e5+9e5   3.96  (252.27ms) (±25.34%)  137MB/op        fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.73k (268.34µs) (±28.82%)  188kB/op           fastest
Int32 1e3          2.85k (351.49µs) (±25.91%)  188kB/op      1.31× slower
Int32 1e6 sorted 996.79m (  1.00s ) (± 6.68%)  183MB/op   3738.61× slower
Int32 1e6        599.02m (  1.67s ) (± 3.55%)  183MB/op   6221.18× slower
Int32 1e3 * 1e3  629.85m (  1.59s ) (± 5.16%)  183MB/op   5916.63× slower
Array 1e6 * 1e2  258.43m (  3.87s ) (± 2.05%)  244MB/op  14420.14× slower
class 1e6        598.13m (  1.67s ) (± 2.73%)  244MB/op   6230.44× slower
SlowC 1e6 * 1e2   72.68m ( 13.76s ) (± 0.00%)  244MB/op  51270.85× slower

-------- split --------
Int32 5e5+5e5   6.10  (163.99ms) (±34.36%)  137MB/op   1.00× slower
Int32 1e5+9e5   6.11  (163.56ms) (±33.99%)  137MB/op        fastest
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
Int32 1e3 sorted   3.54k (282.44µs) (±27.27%)   141kB/op           fastest
Int32 1e3          2.82k (354.24µs) (±24.56%)   141kB/op      1.25× slower
Int32 1e6 sorted   1.06  (940.23ms) (± 6.21%)   137MB/op   3328.97× slower
Int32 1e6        742.09m (  1.35s ) (± 3.83%)   137MB/op   4771.06× slower
Int32 1e3 * 1e3   13.88  ( 72.05ms) (± 3.25%)   141kB/op    255.09× slower
Array 1e6 * 1e2  301.64m (  3.32s ) (± 2.11%)   183MB/op  11737.95× slower
class 1e6         23.13  ( 43.24ms) (± 2.96%)  18.8kB/op    153.09× slower
SlowC 1e6 * 1e2  434.97m (  2.30s ) (± 1.48%)   427kB/op   8139.87× slower

-------- split --------
Int32 5e5+5e5   3.14  (318.85ms) (±18.46%)  137MB/op        fastest
Int32 1e5+9e5   3.10  (322.18ms) (±19.30%)  137MB/op   1.01× slower
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.63k (275.36µs) (±28.66%)  188kB/op           fastest
Int32 1e3          2.80k (356.80µs) (±24.86%)  188kB/op      1.30× slower
Int32 1e6 sorted 984.36m (  1.02s ) (± 3.61%)  183MB/op   3689.34× slower
Int32 1e6        591.97m (  1.69s ) (± 0.75%)  183MB/op   6134.86× slower
Int32 1e3 * 1e3    4.74  (210.85ms) (±23.63%)  137MB/op    765.72× slower
Array 1e6 * 1e2  243.60m (  4.11s ) (± 1.02%)  244MB/op  14908.36× slower
class 1e6          5.20  (192.27ms) (±29.61%)  183MB/op    698.27× slower
SlowC 1e6 * 1e2  282.56m (  3.54s ) (± 4.31%)  183MB/op  12852.37× slower

-------- split --------
Int32 5e5+5e5   5.78  (173.03ms) (±33.22%)  137MB/op   1.02× slower
Int32 1e5+9e5   5.92  (168.83ms) (±32.68%)  137MB/op        fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  84.66  ( 11.81ms) (± 4.31%)  0.0B/op  31.92× slower
a &* b % mod  84.18  ( 11.88ms) (± 5.96%)  0.0B/op  32.10× slower
 a * b % MOD   2.70k (370.10µs) (± 6.35%)  0.0B/op        fastest
a &* b % MOD   2.68k (373.77µs) (± 4.67%)  0.0B/op   1.01× slower
bt.mul(a, b) 178.57  (  5.60ms) (± 3.70%)  0.0B/op  15.13× slower

-------- mod: 100000 --------
 a * b % mod  81.24  ( 12.31ms) (± 2.62%)  0.0B/op   2.79× slower
a &* b % mod  80.42  ( 12.44ms) (± 4.63%)  0.0B/op   2.82× slower
 a * b % MOD 226.43  (  4.42ms) (± 3.14%)  0.0B/op        fastest
a &* b % MOD 225.77  (  4.43ms) (± 2.71%)  0.0B/op   1.00× slower
bt.mul(a, b) 183.90  (  5.44ms) (± 2.67%)  0.0B/op   1.23× slower

-------- mod: 1000000000 --------
 a * b % mod  75.55  ( 13.24ms) (± 2.82%)  0.0B/op   2.98× slower
a &* b % mod  75.05  ( 13.33ms) (± 2.92%)  0.0B/op   3.00× slower
 a * b % MOD 224.30  (  4.46ms) (± 3.00%)  0.0B/op   1.00× slower
a &* b % MOD 225.16  (  4.44ms) (± 3.02%)  0.0B/op        fastest
bt.mul(a, b) 182.32  (  5.48ms) (± 2.74%)  0.0B/op   1.23× slower

-------- mod: 1000000007 --------
 a * b % mod  75.45  ( 13.25ms) (± 3.40%)  0.0B/op   3.17× slower
a &* b % mod  74.98  ( 13.34ms) (± 3.25%)  0.0B/op   3.19× slower
 a * b % MOD 238.78  (  4.19ms) (± 4.09%)  0.0B/op   1.00× slower
a &* b % MOD 239.31  (  4.18ms) (± 3.76%)  0.0B/op        fastest
bt.mul(a, b) 174.32  (  5.74ms) (± 5.78%)  0.0B/op   1.37× slower

-------- mod: 2147483647 --------
 a * b % mod  72.89  ( 13.72ms) (± 5.50%)  0.0B/op   2.77× slower
a &* b % mod  73.50  ( 13.61ms) (± 2.90%)  0.0B/op   2.75× slower
 a * b % MOD 201.91  (  4.95ms) (± 3.47%)  0.0B/op        fastest
a &* b % MOD 198.84  (  5.03ms) (± 5.63%)  0.0B/op   1.02× slower
bt.mul(a, b) 181.03  (  5.52ms) (± 3.06%)  0.0B/op   1.12× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   6.53  (153.16ms) (± 3.13%)  44.2MB/op   2.62× slower
SieveFast#new  17.08  ( 58.56ms) (± 5.92%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 297.54  (  3.36ms) (± 3.82%)   106kB/op        fastest
 Scanner.s.to_i8 152.99  (  6.54ms) (± 3.50%)  2.52MB/op   1.94× slower
     Scanner.i16 271.88  (  3.68ms) (± 2.83%)   204kB/op        fastest
Scanner.s.to_i16 137.42  (  7.28ms) (± 3.28%)  3.26MB/op   1.98× slower
     Scanner.i32 219.15  (  4.56ms) (± 3.99%)   399kB/op        fastest
Scanner.s.to_i32 112.36  (  8.90ms) (± 3.24%)  3.47MB/op   1.95× slower
     Scanner.i64 147.57  (  6.78ms) (± 2.44%)  790kB/op        fastest
Scanner.s.to_i64  87.25  ( 11.46ms) (± 3.49%)  5.3MB/op   1.69× slower
      Scanner.u8 476.61  (  2.10ms) (± 4.23%)   106kB/op        fastest
 Scanner.s.to_u8 160.45  (  6.23ms) (± 4.63%)  2.57MB/op   2.97× slower
     Scanner.u16 471.96  (  2.12ms) (± 3.92%)   204kB/op        fastest
Scanner.s.to_u16 149.98  (  6.67ms) (± 3.94%)  3.26MB/op   3.15× slower
     Scanner.u32 336.30  (  2.97ms) (± 2.53%)   399kB/op        fastest
Scanner.s.to_u32 119.36  (  8.38ms) (± 4.01%)  3.46MB/op   2.82× slower
     Scanner.u64 210.15  (  4.76ms) (± 2.72%)  790kB/op        fastest
Scanner.s.to_u64  88.48  ( 11.30ms) (± 4.33%)  5.3MB/op   2.38× slower
```

