# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 110.91k (  9.02µs) (± 6.27%)  1.72kB/op  fastest
Int32 10^2 dence   99.89k ( 10.01µs) (± 3.04%)  1.72kB/op  fastest
Int32 10^6 sparse   3.43  (291.53ms) (± 1.77%)  12.0MB/op  fastest
Int32 10^6 dence    3.29  (304.31ms) (± 2.28%)  12.0MB/op  fastest
Array 10^6 * 10^2 465.98m (  2.15s ) (± 0.49%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.33k (230.86µs) (± 4.91%)  141kB/op  fastest
Int32 1e3          3.61k (277.31µs) (± 5.45%)  141kB/op  fastest
Int32 1e6 sorted   1.07  (935.88ms) (± 1.29%)  137MB/op  fastest
Int32 1e6        627.64m (  1.59s ) (± 4.90%)  137MB/op  fastest
Int32 1e3 * 1e3    1.02  (979.65ms) (± 1.46%)  137MB/op  fastest
Array 1e6 * 1e2  279.11m (  3.58s ) (± 1.29%)  183MB/op  fastest
class 1e6          1.09  (914.64ms) (± 4.37%)  183MB/op  fastest
SlowC 1e6 * 1e2  111.80m (  8.94s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.87  (258.69ms) (±15.37%)  137MB/op  fastest
Int32 1e5+9e5   4.53  (220.94ms) (±15.70%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.95k (252.94µs) (± 3.78%)  188kB/op  fastest
Int32 1e3          2.95k (339.24µs) (± 4.06%)  188kB/op  fastest
Int32 1e6 sorted 888.28m (  1.13s ) (± 2.49%)  183MB/op  fastest
Int32 1e6        489.32m (  2.04s ) (± 1.59%)  183MB/op  fastest
Int32 1e3 * 1e3  545.50m (  1.83s ) (± 0.09%)  183MB/op  fastest
Array 1e6 * 1e2  211.27m (  4.73s ) (± 0.32%)  244MB/op  fastest
class 1e6        535.21m (  1.87s ) (± 2.56%)  244MB/op  fastest
SlowC 1e6 * 1e2   56.11m ( 17.82s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.85  (206.23ms) (±25.65%)  137MB/op  fastest
Int32 1e5+9e5   6.97  (143.49ms) (±15.17%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.67k (272.71µs) (± 2.91%)  141kB/op  fastest
Int32 1e3          2.87k (348.19µs) (± 4.87%)  141kB/op  fastest
Int32 1e6 sorted 952.97m (  1.05s ) (± 1.65%)  137MB/op  fastest
Int32 1e6        590.81m (  1.69s ) (± 2.27%)  137MB/op  fastest
Int32 1e3 * 1e3   12.19  ( 82.02ms) (± 4.06%)  141kB/op  fastest
Array 1e6 * 1e2  262.83m (  3.80s ) (± 0.45%)  183MB/op  fastest
class 1e6         20.77  ( 48.15ms) (± 2.79%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  361.78m (  2.76s ) (± 0.85%)  425kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.78  (359.60ms) (±12.14%)  137MB/op  fastest
Int32 1e5+9e5   3.29  (304.09ms) (± 6.66%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.79k (263.59µs) (± 4.57%)  188kB/op  fastest
Int32 1e3          2.87k (348.18µs) (± 3.54%)  188kB/op  fastest
Int32 1e6 sorted 851.36m (  1.17s ) (± 2.49%)  183MB/op  fastest
Int32 1e6        458.80m (  2.18s ) (± 1.89%)  183MB/op  fastest
Int32 1e3 * 1e3    5.37  (186.30ms) (± 4.01%)  137MB/op  fastest
Array 1e6 * 1e2  213.07m (  4.69s ) (± 0.93%)  244MB/op  fastest
class 1e6          6.86  (145.68ms) (±11.91%)  183MB/op  fastest
SlowC 1e6 * 1e2  254.68m (  3.93s ) (± 1.31%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.82  (207.38ms) (±20.75%)  137MB/op  fastest
Int32 1e5+9e5   6.61  (151.28ms) (±14.18%)  137MB/op  fastest
```

