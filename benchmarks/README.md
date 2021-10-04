# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 110.03k (  9.09µs) (± 0.26%)  1.72kB/op  fastest
Int32 10^2 dence   96.69k ( 10.34µs) (± 1.72%)  1.72kB/op  fastest
Int32 10^6 sparse   3.43  (291.23ms) (± 0.21%)  12.0MB/op  fastest
Int32 10^6 dence    3.30  (303.29ms) (± 0.16%)  12.0MB/op  fastest
Array 10^6 * 10^2 417.83m (  2.39s ) (± 1.89%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.55k (282.01µs) (± 6.65%)  141kB/op  fastest
Int32 1e3          3.18k (314.65µs) (± 0.70%)  141kB/op  fastest
Int32 1e6 sorted 930.95m (  1.07s ) (± 2.26%)  137MB/op  fastest
Int32 1e6        559.14m (  1.79s ) (± 3.62%)  137MB/op  fastest
Int32 1e3 * 1e3    1.12  (896.44ms) (± 0.99%)  137MB/op  fastest
Array 1e6 * 1e2  266.84m (  3.75s ) (± 0.41%)  183MB/op  fastest
class 1e6          1.29  (775.65ms) (± 4.78%)  183MB/op  fastest
SlowC 1e6 * 1e2   89.50m ( 11.17s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.69  (271.29ms) (±15.18%)  137MB/op  fastest
Int32 1e5+9e5   4.60  (217.45ms) (± 9.26%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.50k (285.66µs) (± 0.59%)  188kB/op  fastest
Int32 1e3          2.58k (387.83µs) (± 0.44%)  188kB/op  fastest
Int32 1e6 sorted 778.92m (  1.28s ) (± 1.73%)  183MB/op  fastest
Int32 1e6        420.01m (  2.38s ) (± 0.40%)  183MB/op  fastest
Int32 1e3 * 1e3  525.10m (  1.90s ) (± 1.32%)  183MB/op  fastest
Array 1e6 * 1e2  190.87m (  5.24s ) (± 0.00%)  244MB/op  fastest
class 1e6        528.61m (  1.89s ) (± 3.29%)  244MB/op  fastest
SlowC 1e6 * 1e2   49.38m ( 20.25s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.77  (209.74ms) (±26.93%)  137MB/op  fastest
Int32 1e5+9e5   6.67  (150.00ms) (±12.79%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.33k (299.92µs) (± 0.42%)  141kB/op  fastest
Int32 1e3          2.51k (398.58µs) (± 2.09%)  141kB/op  fastest
Int32 1e6 sorted 873.62m (  1.14s ) (± 3.57%)  137MB/op  fastest
Int32 1e6        476.78m (  2.10s ) (± 3.35%)  137MB/op  fastest
Int32 1e3 * 1e3   10.98  ( 91.11ms) (± 0.22%)  141kB/op  fastest
Array 1e6 * 1e2  245.00m (  4.08s ) (± 1.17%)  183MB/op  fastest
class 1e6         17.62  ( 56.76ms) (± 0.59%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  327.65m (  3.05s ) (± 0.06%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.84  (352.65ms) (±13.85%)  137MB/op  fastest
Int32 1e5+9e5   3.38  (295.65ms) (± 6.80%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.49k (286.40µs) (± 3.65%)  188kB/op  fastest
Int32 1e3          2.50k (399.51µs) (± 4.54%)  188kB/op  fastest
Int32 1e6 sorted 740.13m (  1.35s ) (± 1.92%)  183MB/op  fastest
Int32 1e6        416.84m (  2.40s ) (± 1.27%)  183MB/op  fastest
Int32 1e3 * 1e3    5.40  (185.20ms) (± 2.65%)  137MB/op  fastest
Array 1e6 * 1e2  200.34m (  4.99s ) (± 0.07%)  244MB/op  fastest
class 1e6          6.36  (157.23ms) (±10.19%)  183MB/op  fastest
SlowC 1e6 * 1e2  225.91m (  4.43s ) (± 0.50%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.61  (216.91ms) (±27.04%)  137MB/op  fastest
Int32 1e5+9e5   6.48  (154.41ms) (±13.53%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 248.34  (  4.03ms) (± 0.16%)   106kB/op        fastest
 Scanner.s.to_i8 123.85  (  8.07ms) (± 0.61%)  2.51MB/op   2.01× slower
     Scanner.i16 224.68  (  4.45ms) (± 0.12%)   204kB/op        fastest
Scanner.s.to_i16 110.38  (  9.06ms) (± 0.39%)  3.26MB/op   2.04× slower
     Scanner.i32 179.70  (  5.56ms) (± 0.34%)   399kB/op        fastest
Scanner.s.to_i32  88.93  ( 11.24ms) (± 0.41%)  3.46MB/op   2.02× slower
     Scanner.i64 121.79  (  8.21ms) (± 0.36%)   790kB/op        fastest
Scanner.s.to_i64  66.19  ( 15.11ms) (± 0.90%)  5.29MB/op   1.84× slower
      Scanner.u8 356.84  (  2.80ms) (± 0.24%)   106kB/op        fastest
 Scanner.s.to_u8 129.00  (  7.75ms) (± 0.39%)  2.57MB/op   2.77× slower
     Scanner.u16 348.36  (  2.87ms) (± 0.19%)   204kB/op        fastest
Scanner.s.to_u16 118.42  (  8.44ms) (± 0.63%)  3.26MB/op   2.94× slower
     Scanner.u32 257.92  (  3.88ms) (± 0.25%)   399kB/op        fastest
Scanner.s.to_u32  96.27  ( 10.39ms) (± 0.42%)  3.46MB/op   2.68× slower
     Scanner.u64 169.48  (  5.90ms) (± 0.68%)   790kB/op        fastest
Scanner.s.to_u64  65.64  ( 15.23ms) (± 0.90%)  5.31MB/op   2.58× slower
```

