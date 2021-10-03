# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 141.44k (  7.07µs) (± 4.78%)  1.72kB/op  fastest
Int32 10^2 dence  115.67k (  8.65µs) (± 4.60%)  1.72kB/op  fastest
Int32 10^6 sparse   3.94  (253.50ms) (± 5.93%)  12.0MB/op  fastest
Int32 10^6 dence    3.97  (251.70ms) (± 3.45%)  12.0MB/op  fastest
Array 10^6 * 10^2 518.72m (  1.93s ) (± 2.61%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.89k (204.67µs) (± 4.00%)  141kB/op  fastest
Int32 1e3          4.38k (228.56µs) (± 4.10%)  141kB/op  fastest
Int32 1e6 sorted   1.25  (801.67ms) (± 3.00%)  137MB/op  fastest
Int32 1e6        723.48m (  1.38s ) (± 4.23%)  137MB/op  fastest
Int32 1e3 * 1e3    1.02  (975.77ms) (± 2.96%)  137MB/op  fastest
Array 1e6 * 1e2  331.05m (  3.02s ) (± 1.82%)  183MB/op  fastest
class 1e6          1.12  (892.59ms) (± 5.28%)  183MB/op  fastest
SlowC 1e6 * 1e2  132.26m (  7.56s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.28  (233.88ms) (±17.56%)  137MB/op  fastest
Int32 1e5+9e5   5.43  (184.05ms) (±10.51%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.46k (224.44µs) (± 5.37%)  188kB/op  fastest
Int32 1e3          3.20k (312.24µs) (± 3.16%)  188kB/op  fastest
Int32 1e6 sorted 977.52m (  1.02s ) (± 0.88%)  183MB/op  fastest
Int32 1e6        611.35m (  1.64s ) (± 1.80%)  183MB/op  fastest
Int32 1e3 * 1e3  536.85m (  1.86s ) (± 1.84%)  183MB/op  fastest
Array 1e6 * 1e2  226.59m (  4.41s ) (± 0.20%)  244MB/op  fastest
class 1e6        590.90m (  1.69s ) (± 2.70%)  244MB/op  fastest
SlowC 1e6 * 1e2   67.22m ( 14.88s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.35  (187.06ms) (±23.00%)  137MB/op  fastest
Int32 1e5+9e5   7.37  (135.69ms) (±14.22%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.32k (231.23µs) (± 3.54%)  141kB/op  fastest
Int32 1e3          3.29k (303.81µs) (± 6.01%)  141kB/op  fastest
Int32 1e6 sorted   1.13  (882.13ms) (± 3.46%)  137MB/op  fastest
Int32 1e6        738.93m (  1.35s ) (± 2.34%)  137MB/op  fastest
Int32 1e3 * 1e3   14.67  ( 68.16ms) (± 5.36%)  141kB/op  fastest
Array 1e6 * 1e2  306.83m (  3.26s ) (± 0.17%)  183MB/op  fastest
class 1e6         24.48  ( 40.85ms) (± 5.14%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  399.93m (  2.50s ) (± 2.07%)  427kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.91  (343.81ms) (± 8.89%)  137MB/op  fastest
Int32 1e5+9e5   3.57  (279.93ms) (± 6.77%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.34k (230.23µs) (± 4.14%)  188kB/op  fastest
Int32 1e3          3.35k (298.89µs) (± 5.29%)  188kB/op  fastest
Int32 1e6 sorted   1.02  (984.30ms) (± 5.32%)  183MB/op  fastest
Int32 1e6        550.15m (  1.82s ) (± 4.33%)  183MB/op  fastest
Int32 1e3 * 1e3    5.95  (168.11ms) (± 2.82%)  137MB/op  fastest
Array 1e6 * 1e2  245.00m (  4.08s ) (± 4.45%)  244MB/op  fastest
class 1e6          7.62  (131.32ms) (±11.67%)  183MB/op  fastest
SlowC 1e6 * 1e2  294.63m (  3.39s ) (± 1.30%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.53  (180.85ms) (±20.59%)  137MB/op  fastest
Int32 1e5+9e5   7.32  (136.63ms) (±14.59%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 332.50  (  3.01ms) (± 3.60%)   106kB/op        fastest
 Scanner.s.to_i8 163.49  (  6.12ms) (± 4.32%)  2.51MB/op   2.03× slower
     Scanner.i16 306.78  (  3.26ms) (± 4.06%)   204kB/op        fastest
Scanner.s.to_i16 138.23  (  7.23ms) (± 9.67%)  3.26MB/op   2.22× slower
     Scanner.i32 194.50  (  5.14ms) (± 1.98%)   399kB/op        fastest
Scanner.s.to_i32 107.05  (  9.34ms) (± 2.02%)  3.46MB/op   1.82× slower
     Scanner.i64 145.97  (  6.85ms) (± 4.16%)  790kB/op        fastest
Scanner.s.to_i64  92.92  ( 10.76ms) (± 4.77%)  5.3MB/op   1.57× slower
      Scanner.u8 426.56  (  2.34ms) (± 5.06%)   106kB/op        fastest
 Scanner.s.to_u8 159.34  (  6.28ms) (± 3.86%)  2.57MB/op   2.68× slower
     Scanner.u16 475.93  (  2.10ms) (± 4.96%)   204kB/op        fastest
Scanner.s.to_u16 152.07  (  6.58ms) (± 3.27%)  3.26MB/op   3.13× slower
     Scanner.u32 357.99  (  2.79ms) (± 4.60%)   399kB/op        fastest
Scanner.s.to_u32 128.65  (  7.77ms) (± 3.44%)  3.46MB/op   2.78× slower
     Scanner.u64 206.57  (  4.84ms) (± 5.97%)   790kB/op        fastest
Scanner.s.to_u64  94.72  ( 10.56ms) (± 4.74%)  5.31MB/op   2.18× slower
```

