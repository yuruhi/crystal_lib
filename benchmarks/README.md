# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 135.99k (  7.35µs) (± 5.58%)  1.72kB/op  fastest
Int32 10^2 dence  122.21k (  8.18µs) (± 5.90%)  1.72kB/op  fastest
Int32 10^6 sparse   4.17  (239.76ms) (± 7.45%)  12.0MB/op  fastest
Int32 10^6 dence    3.88  (257.47ms) (± 4.31%)  12.0MB/op  fastest
Array 10^6 * 10^2 474.42m (  2.11s ) (± 2.49%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.78k (209.32µs) (± 5.14%)  141kB/op  fastest
Int32 1e3          4.28k (233.72µs) (± 5.18%)  141kB/op  fastest
Int32 1e6 sorted   1.17  (853.14ms) (± 3.34%)  137MB/op  fastest
Int32 1e6        673.79m (  1.48s ) (± 2.34%)  137MB/op  fastest
Int32 1e3 * 1e3    1.00  (997.25ms) (± 2.33%)  137MB/op  fastest
Array 1e6 * 1e2  293.72m (  3.40s ) (± 0.02%)  183MB/op  fastest
class 1e6          1.10  (913.03ms) (± 2.25%)  183MB/op  fastest
SlowC 1e6 * 1e2  127.86m (  7.82s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.09  (244.41ms) (±18.60%)  137MB/op  fastest
Int32 1e5+9e5   5.28  (189.44ms) (±11.95%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.49k (222.87µs) (± 4.76%)  188kB/op  fastest
Int32 1e3          3.41k (293.41µs) (± 5.27%)  188kB/op  fastest
Int32 1e6 sorted 946.76m (  1.06s ) (± 4.55%)  183MB/op  fastest
Int32 1e6        535.98m (  1.87s ) (± 1.70%)  183MB/op  fastest
Int32 1e3 * 1e3  571.82m (  1.75s ) (± 2.27%)  183MB/op  fastest
Array 1e6 * 1e2  226.15m (  4.42s ) (± 0.45%)  244MB/op  fastest
class 1e6        552.47m (  1.81s ) (± 2.58%)  244MB/op  fastest
SlowC 1e6 * 1e2   63.25m ( 15.81s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.52  (181.16ms) (±23.52%)  137MB/op  fastest
Int32 1e5+9e5   7.28  (137.41ms) (±14.47%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.24k (236.07µs) (± 5.14%)  141kB/op  fastest
Int32 1e3          3.28k (305.31µs) (± 6.37%)  141kB/op  fastest
Int32 1e6 sorted   1.08  (923.92ms) (± 2.52%)  137MB/op  fastest
Int32 1e6        567.95m (  1.76s ) (± 3.85%)  137MB/op  fastest
Int32 1e3 * 1e3   14.69  ( 68.07ms) (± 5.64%)  141kB/op  fastest
Array 1e6 * 1e2  261.56m (  3.82s ) (± 1.64%)  183MB/op  fastest
class 1e6         23.09  ( 43.31ms) (± 5.38%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  389.56m (  2.57s ) (± 1.04%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.93  (341.48ms) (±11.95%)  137MB/op  fastest
Int32 1e5+9e5   3.69  (271.21ms) (± 7.92%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.37k (228.58µs) (± 5.57%)  188kB/op  fastest
Int32 1e3          3.19k (313.03µs) (± 6.28%)  188kB/op  fastest
Int32 1e6 sorted 927.21m (  1.08s ) (± 2.50%)  183MB/op  fastest
Int32 1e6        524.84m (  1.91s ) (± 0.72%)  183MB/op  fastest
Int32 1e3 * 1e3    5.74  (174.29ms) (± 5.00%)  137MB/op  fastest
Array 1e6 * 1e2  233.57m (  4.28s ) (± 0.29%)  244MB/op  fastest
class 1e6          6.87  (145.53ms) (±14.08%)  183MB/op  fastest
SlowC 1e6 * 1e2  281.16m (  3.56s ) (± 1.57%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.47  (182.81ms) (±38.36%)  137MB/op  fastest
Int32 1e5+9e5   6.69  (149.57ms) (±20.10%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 320.79  (  3.12ms) (± 4.57%)   106kB/op        fastest
 Scanner.s.to_i8 157.90  (  6.33ms) (± 4.66%)  2.51MB/op   2.03× slower
     Scanner.i16 294.38  (  3.40ms) (± 4.70%)   204kB/op        fastest
Scanner.s.to_i16 143.61  (  6.96ms) (± 5.13%)  3.26MB/op   2.05× slower
     Scanner.i32 221.80  (  4.51ms) (± 5.85%)   399kB/op        fastest
Scanner.s.to_i32 122.87  (  8.14ms) (± 5.07%)  3.46MB/op   1.81× slower
     Scanner.i64 149.72  (  6.68ms) (± 5.81%)  790kB/op        fastest
Scanner.s.to_i64  92.86  ( 10.77ms) (± 5.93%)  5.3MB/op   1.61× slower
      Scanner.u8 453.15  (  2.21ms) (± 5.19%)   106kB/op        fastest
 Scanner.s.to_u8 167.57  (  5.97ms) (± 5.74%)  2.57MB/op   2.70× slower
     Scanner.u16 468.96  (  2.13ms) (± 5.98%)   204kB/op        fastest
Scanner.s.to_u16 153.44  (  6.52ms) (± 6.05%)  3.26MB/op   3.06× slower
     Scanner.u32 342.60  (  2.92ms) (± 5.71%)   399kB/op        fastest
Scanner.s.to_u32 126.21  (  7.92ms) (± 6.40%)  3.46MB/op   2.71× slower
     Scanner.u64 217.44  (  4.60ms) (± 5.41%)   790kB/op        fastest
Scanner.s.to_u64  95.16  ( 10.51ms) (± 6.13%)  5.31MB/op   2.28× slower
```

