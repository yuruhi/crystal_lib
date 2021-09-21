# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 116.28k (  8.60µs) (± 3.55%)  1.72kB/op  fastest
Int32 10^2 dence  103.93k (  9.62µs) (± 2.52%)  1.72kB/op  fastest
Int32 10^6 sparse   3.56  (280.54ms) (± 2.37%)  12.0MB/op  fastest
Int32 10^6 dence    3.42  (292.35ms) (± 4.28%)  12.0MB/op  fastest
Array 10^6 * 10^2 441.84m (  2.26s ) (± 1.85%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.29k (233.36µs) (± 3.44%)  141kB/op  fastest
Int32 1e3          3.64k (274.35µs) (± 3.44%)  141kB/op  fastest
Int32 1e6 sorted   1.03  (971.68ms) (± 1.47%)  137MB/op  fastest
Int32 1e6        565.45m (  1.77s ) (± 4.40%)  137MB/op  fastest
Int32 1e3 * 1e3  921.00m (  1.09s ) (± 1.29%)  137MB/op  fastest
Array 1e6 * 1e2  270.65m (  3.69s ) (± 0.78%)  183MB/op  fastest
class 1e6        995.29m (  1.00s ) (± 4.10%)  183MB/op  fastest
SlowC 1e6 * 1e2  111.35m (  8.98s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.58  (279.10ms) (±14.39%)  137MB/op  fastest
Int32 1e5+9e5   4.39  (228.02ms) (±10.59%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.65k (273.96µs) (± 5.16%)  188kB/op  fastest
Int32 1e3          2.74k (364.62µs) (± 4.40%)  188kB/op  fastest
Int32 1e6 sorted 786.97m (  1.27s ) (± 1.56%)  183MB/op  fastest
Int32 1e6        418.90m (  2.39s ) (± 0.28%)  183MB/op  fastest
Int32 1e3 * 1e3  484.49m (  2.06s ) (± 1.33%)  183MB/op  fastest
Array 1e6 * 1e2  193.68m (  5.16s ) (± 0.00%)  244MB/op  fastest
class 1e6        483.14m (  2.07s ) (± 3.90%)  244MB/op  fastest
SlowC 1e6 * 1e2   51.46m ( 19.43s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.58  (218.13ms) (±24.36%)  137MB/op  fastest
Int32 1e5+9e5   6.30  (158.75ms) (±14.33%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.41k (292.87µs) (± 4.46%)  141kB/op  fastest
Int32 1e3          2.84k (351.94µs) (± 2.55%)  141kB/op  fastest
Int32 1e6 sorted 891.36m (  1.12s ) (± 2.52%)  137MB/op  fastest
Int32 1e6        545.67m (  1.83s ) (± 3.45%)  137MB/op  fastest
Int32 1e3 * 1e3   11.99  ( 83.42ms) (± 2.85%)  141kB/op  fastest
Array 1e6 * 1e2  249.83m (  4.00s ) (± 0.47%)  183MB/op  fastest
class 1e6         20.49  ( 48.81ms) (± 3.36%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  356.54m (  2.80s ) (± 0.66%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.57  (389.08ms) (±12.56%)  137MB/op  fastest
Int32 1e5+9e5   3.00  (333.57ms) (± 6.73%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.80k (263.17µs) (± 2.43%)  188kB/op  fastest
Int32 1e3          2.76k (362.68µs) (± 2.50%)  188kB/op  fastest
Int32 1e6 sorted 718.48m (  1.39s ) (± 2.66%)  183MB/op  fastest
Int32 1e6        456.78m (  2.19s ) (± 0.95%)  183MB/op  fastest
Int32 1e3 * 1e3    5.15  (194.26ms) (± 2.60%)  137MB/op  fastest
Array 1e6 * 1e2  207.89m (  4.81s ) (± 0.54%)  244MB/op  fastest
class 1e6          6.44  (155.16ms) (±12.41%)  183MB/op  fastest
SlowC 1e6 * 1e2  236.04m (  4.24s ) (± 2.33%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.48  (223.46ms) (±27.11%)  137MB/op  fastest
Int32 1e5+9e5   6.33  (157.91ms) (±15.03%)  137MB/op  fastest
```

