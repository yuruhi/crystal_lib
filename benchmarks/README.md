# benchmark results

## [datastructure/sset_benchmark_helper.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset_benchmark_helper.cr)

```

```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.55k (281.33µs) (± 3.35%)  141kB/op  fastest
Int32 1e3          2.58k (387.17µs) (± 2.36%)  141kB/op  fastest
Int32 1e6 sorted 818.40m (  1.22s ) (± 2.36%)  137MB/op  fastest
Int32 1e6        448.94m (  2.23s ) (± 1.27%)  137MB/op  fastest
Int32 1e3 * 1e3   11.28  ( 88.64ms) (± 3.40%)  141kB/op  fastest
Array 1e6 * 1e2  182.91m (  5.47s ) (± 0.00%)  244MB/op  fastest
class 1e6         20.69  ( 48.34ms) (± 3.76%)  22.0kB/op  fastest
SlowC 1e6 * 1e2  191.52m (  5.22s ) (± 0.00%)  711kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.79  (357.89ms) (±12.93%)  137MB/op  fastest
Int32 1e5+9e5   3.36  (297.64ms) (± 6.96%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.81k (262.17µs) (± 3.43%)  188kB/op  fastest
Int32 1e3          2.78k (360.20µs) (± 2.87%)  188kB/op  fastest
Int32 1e6 sorted 708.50m (  1.41s ) (± 2.09%)  183MB/op  fastest
Int32 1e6        362.93m (  2.76s ) (± 0.24%)  183MB/op  fastest
Int32 1e3 * 1e3    5.01  (199.44ms) (± 2.26%)  137MB/op  fastest
Array 1e6 * 1e2  141.45m (  7.07s ) (± 0.00%)  336MB/op  fastest
class 1e6          4.75  (210.32ms) (± 8.48%)  215MB/op  fastest
SlowC 1e6 * 1e2  127.41m (  7.85s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.66  (214.63ms) (±28.24%)  137MB/op  fastest
Int32 1e5+9e5   6.54  (152.92ms) (±12.52%)  137MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.12k (242.64µs) (± 2.50%)  141kB/op  fastest
Int32 1e3          3.38k (296.28µs) (± 2.57%)  141kB/op  fastest
Int32 1e6 sorted 932.37m (  1.07s ) (± 1.89%)  137MB/op  fastest
Int32 1e6        538.78m (  1.86s ) (± 3.65%)  137MB/op  fastest
Int32 1e3 * 1e3  781.43m (  1.28s ) (± 1.22%)  137MB/op  fastest
Array 1e6 * 1e2  214.72m (  4.66s ) (± 2.43%)  244MB/op  fastest
class 1e6        990.12m (  1.01s ) (± 2.54%)  214MB/op  fastest
SlowC 1e6 * 1e2   90.09m ( 11.10s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.90  (256.12ms) (±19.25%)  137MB/op  fastest
Int32 1e5+9e5   4.92  (203.40ms) (± 9.83%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.89k (257.18µs) (± 5.26%)  188kB/op  fastest
Int32 1e3          2.94k (339.97µs) (± 4.58%)  188kB/op  fastest
Int32 1e6 sorted 758.47m (  1.32s ) (± 1.70%)  183MB/op  fastest
Int32 1e6        393.10m (  2.54s ) (± 4.26%)  183MB/op  fastest
Int32 1e3 * 1e3  445.13m (  2.25s ) (± 0.53%)  183MB/op  fastest
Array 1e6 * 1e2  152.07m (  6.58s ) (± 0.00%)  336MB/op  fastest
class 1e6        406.44m (  2.46s ) (± 2.41%)  290MB/op  fastest
SlowC 1e6 * 1e2   32.49m ( 30.78s ) (± 0.00%)  427MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.03  (165.94ms) (±23.27%)  137MB/op  fastest
Int32 1e5+9e5   6.96  (143.68ms) (±14.47%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 106.75k (  9.37µs) (± 2.39%)  1.72kB/op  fastest
Int32 10^2 dence   94.24k ( 10.61µs) (± 1.59%)  1.72kB/op  fastest
Int32 10^6 sparse   3.34  (299.51ms) (± 1.67%)  12.0MB/op  fastest
Int32 10^6 dence    3.18  (314.16ms) (± 1.38%)  12.0MB/op  fastest
Array 10^6 * 10^2 283.55m (  3.53s ) (± 2.39%)  24.0MB/op  fastest
```

