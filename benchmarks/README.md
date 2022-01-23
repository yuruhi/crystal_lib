# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   258.67k (  3.87µs) (± 0.90%)  1.72kB/op  fastest
Int32 10^2 dence    256.22k (  3.90µs) (± 0.09%)  1.72kB/op  fastest
Int32 10^6 sparse     6.39  (156.38ms) (± 0.20%)  12.0MB/op  fastest
Int32 10^6 dence      5.66  (176.68ms) (± 0.42%)  12.0MB/op  fastest
Int32 10^6 sparse R   3.48  (287.64ms) (± 0.05%)  12.0MB/op  fastest
Int32 10^6 dence  R   4.05  (246.99ms) (± 0.13%)  12.0MB/op  fastest
SlowC 10^6 * 10^2   114.80m (  8.71s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.86k (258.76µs) (±27.75%)  141kB/op           fastest
Int32 1e3          3.35k (298.57µs) (±24.77%)  141kB/op      1.15× slower
Int32 1e6 sorted   1.06  (944.05ms) (± 6.07%)  137MB/op   3648.38× slower
Int32 1e6        688.73m (  1.45s ) (± 5.19%)  137MB/op   5611.22× slower
Int32 1e3 * 1e3    1.24  (807.15ms) (± 6.87%)  137MB/op   3119.32× slower
Array 1e6 * 1e2  296.67m (  3.37s ) (± 1.84%)  183MB/op  13026.57× slower
class 1e6          1.31  (760.49ms) (±11.18%)  183MB/op   2939.00× slower
SlowC 1e6 * 1e2  143.29m (  6.98s ) (± 0.00%)  183MB/op  26970.90× slower

-------- split --------
Int32 5e5+5e5   4.34  (230.15ms) (±28.30%)  137MB/op   1.00× slower
Int32 1e5+9e5   4.35  (229.79ms) (±28.69%)  137MB/op        fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.50k (286.10µs) (±26.76%)  188kB/op           fastest
Int32 1e3          2.72k (367.84µs) (±23.65%)  188kB/op      1.29× slower
Int32 1e6 sorted 887.48m (  1.13s ) (± 5.23%)  183MB/op   3938.48× slower
Int32 1e6        531.73m (  1.88s ) (± 2.83%)  183MB/op   6573.42× slower
Int32 1e3 * 1e3  605.65m (  1.65s ) (± 3.75%)  183MB/op   5771.19× slower
Array 1e6 * 1e2  229.40m (  4.36s ) (± 0.68%)  244MB/op  15237.04× slower
class 1e6        564.50m (  1.77s ) (± 1.97%)  244MB/op   6191.83× slower
SlowC 1e6 * 1e2   65.07m ( 15.37s ) (± 0.00%)  244MB/op  53715.45× slower

-------- split --------
Int32 5e5+5e5   6.02  (165.98ms) (±34.30%)  137MB/op        fastest
Int32 1e5+9e5   5.93  (168.60ms) (±35.15%)  137MB/op   1.02× slower
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
Int32 1e3 sorted   3.38k (296.02µs) (±27.11%)   141kB/op           fastest
Int32 1e3          2.69k (371.16µs) (±22.81%)   141kB/op      1.25× slower
Int32 1e6 sorted 995.75m (  1.00s ) (± 4.30%)   137MB/op   3392.56× slower
Int32 1e6        656.87m (  1.52s ) (± 4.38%)   137MB/op   5142.81× slower
Int32 1e3 * 1e3   13.25  ( 75.48ms) (± 0.75%)   141kB/op    254.99× slower
Array 1e6 * 1e2  283.46m (  3.53s ) (± 2.10%)   183MB/op  11917.45× slower
class 1e6         20.87  ( 47.91ms) (± 0.08%)  18.8kB/op    161.85× slower
SlowC 1e6 * 1e2  391.26m (  2.56s ) (± 0.05%)   426kB/op   8633.95× slower

-------- split --------
Int32 5e5+5e5   3.44  (290.52ms) (±20.79%)  137MB/op        fastest
Int32 1e5+9e5   3.44  (290.70ms) (±20.64%)  137MB/op   1.00× slower
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.46k (288.99µs) (±26.77%)  188kB/op           fastest
Int32 1e3          2.68k (372.72µs) (±23.64%)  188kB/op      1.29× slower
Int32 1e6 sorted 890.85m (  1.12s ) (± 4.99%)  183MB/op   3884.35× slower
Int32 1e6        531.90m (  1.88s ) (± 3.67%)  183MB/op   6505.70× slower
Int32 1e3 * 1e3    5.10  (196.06ms) (±25.56%)  137MB/op    678.43× slower
Array 1e6 * 1e2  231.41m (  4.32s ) (± 0.55%)  244MB/op  14953.50× slower
class 1e6          5.11  (195.57ms) (±28.60%)  183MB/op    676.73× slower
SlowC 1e6 * 1e2  281.77m (  3.55s ) (± 4.11%)  183MB/op  12280.93× slower

-------- split --------
Int32 5e5+5e5   5.81  (172.12ms) (±34.04%)  137MB/op   1.01× slower
Int32 1e5+9e5   5.85  (171.02ms) (±34.90%)  137MB/op        fastest
```

## [math/barrett.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/barrett.cr)

```
-------- mod: 1 --------
 a * b % mod  88.60  ( 11.29ms) (± 0.03%)  0.0B/op  33.73× slower
a &* b % mod  88.60  ( 11.29ms) (± 0.03%)  0.0B/op  33.73× slower
 a * b % MOD   2.99k (334.61µs) (± 0.04%)  0.0B/op        fastest
a &* b % MOD   2.99k (334.62µs) (± 0.02%)  0.0B/op   1.00× slower
bt.mul(a, b) 199.19  (  5.02ms) (± 0.01%)  0.0B/op  15.00× slower

-------- mod: 100000 --------
 a * b % mod  83.45  ( 11.98ms) (± 0.44%)  0.0B/op   2.76× slower
a &* b % mod  83.50  ( 11.98ms) (± 0.02%)  0.0B/op   2.75× slower
 a * b % MOD 229.90  (  4.35ms) (± 0.03%)  0.0B/op   1.00× slower
a &* b % MOD 229.92  (  4.35ms) (± 0.01%)  0.0B/op        fastest
bt.mul(a, b) 199.18  (  5.02ms) (± 0.03%)  0.0B/op   1.15× slower

-------- mod: 1000000000 --------
 a * b % mod  83.51  ( 11.97ms) (± 0.03%)  0.0B/op   2.75× slower
a &* b % mod  83.51  ( 11.97ms) (± 0.04%)  0.0B/op   2.75× slower
 a * b % MOD 229.91  (  4.35ms) (± 0.03%)  0.0B/op   1.00× slower
a &* b % MOD 229.92  (  4.35ms) (± 0.02%)  0.0B/op        fastest
bt.mul(a, b) 199.19  (  5.02ms) (± 0.02%)  0.0B/op   1.15× slower

-------- mod: 1000000007 --------
 a * b % mod  83.51  ( 11.97ms) (± 0.03%)  0.0B/op   2.98× slower
a &* b % mod  83.50  ( 11.98ms) (± 0.02%)  0.0B/op   2.98× slower
 a * b % MOD 249.06  (  4.02ms) (± 0.02%)  0.0B/op        fastest
a &* b % MOD 249.05  (  4.02ms) (± 0.02%)  0.0B/op   1.00× slower
bt.mul(a, b) 199.16  (  5.02ms) (± 0.03%)  0.0B/op   1.25× slower

-------- mod: 2147483647 --------
 a * b % mod  83.51  ( 11.97ms) (± 0.04%)  0.0B/op   2.56× slower
a &* b % mod  83.51  ( 11.97ms) (± 0.01%)  0.0B/op   2.56× slower
 a * b % MOD 213.50  (  4.68ms) (± 0.01%)  0.0B/op        fastest
a &* b % MOD 213.34  (  4.69ms) (± 0.45%)  0.0B/op   1.00× slower
bt.mul(a, b) 199.18  (  5.02ms) (± 0.04%)  0.0B/op   1.07× slower
```

## [math/sieve.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/math/sieve.cr)

```
    Sieve#new   5.87  (170.32ms) (± 2.47%)  44.2MB/op   2.55× slower
SieveFast#new  15.00  ( 66.68ms) (± 3.26%)  27.1MB/op        fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 299.27  (  3.34ms) (± 0.08%)   106kB/op        fastest
 Scanner.s.to_i8 150.18  (  6.66ms) (± 0.27%)  2.52MB/op   1.99× slower
     Scanner.i16 271.87  (  3.68ms) (± 0.08%)   204kB/op        fastest
Scanner.s.to_i16 133.46  (  7.49ms) (± 0.32%)  3.26MB/op   2.04× slower
     Scanner.i32 219.04  (  4.57ms) (± 0.13%)   399kB/op        fastest
Scanner.s.to_i32 109.47  (  9.13ms) (± 0.20%)  3.46MB/op   2.00× slower
     Scanner.i64 149.73  (  6.68ms) (± 0.21%)  790kB/op        fastest
Scanner.s.to_i64  82.79  ( 12.08ms) (± 1.81%)  5.3MB/op   1.81× slower
      Scanner.u8 438.76  (  2.28ms) (± 0.14%)   106kB/op        fastest
 Scanner.s.to_u8 157.76  (  6.34ms) (± 0.20%)  2.57MB/op   2.78× slower
     Scanner.u16 426.46  (  2.34ms) (± 0.21%)   204kB/op        fastest
Scanner.s.to_u16 145.50  (  6.87ms) (± 0.19%)  3.26MB/op   2.93× slower
     Scanner.u32 322.81  (  3.10ms) (± 0.23%)   399kB/op        fastest
Scanner.s.to_u32 118.09  (  8.47ms) (± 0.17%)  3.46MB/op   2.73× slower
     Scanner.u64 213.56  (  4.68ms) (± 0.17%)   790kB/op        fastest
Scanner.s.to_u64  81.03  ( 12.34ms) (± 0.77%)  5.31MB/op   2.64× slower
```

