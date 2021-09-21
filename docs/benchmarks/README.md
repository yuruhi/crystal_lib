# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 109.83k (  9.11µs) (± 2.46%)  1.72kB/op  fastest
Int32 10^2 dence   98.21k ( 10.18µs) (± 2.94%)  1.72kB/op  fastest
Int32 10^6 sparse   3.37  (296.33ms) (± 4.75%)  12.0MB/op  fastest
Int32 10^6 dence    3.28  (305.03ms) (± 2.51%)  12.0MB/op  fastest
Array 10^6 * 10^2 443.70m (  2.25s ) (± 3.10%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.31k (231.83µs) (± 2.47%)  141kB/op  fastest
Int32 1e3          3.75k (266.81µs) (± 2.44%)  141kB/op  fastest
Int32 1e6 sorted   1.05  (950.48ms) (± 3.06%)  137MB/op  fastest
Int32 1e6        643.91m (  1.55s ) (± 5.60%)  137MB/op  fastest
Int32 1e3 * 1e3    1.04  (964.02ms) (± 2.07%)  137MB/op  fastest
Array 1e6 * 1e2  275.73m (  3.63s ) (± 1.53%)  244MB/op  fastest
class 1e6          1.07  (933.61ms) (± 2.70%)  214MB/op  fastest
SlowC 1e6 * 1e2  109.06m (  9.17s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.67  (272.82ms) (±16.58%)  137MB/op  fastest
Int32 1e5+9e5   4.79  (208.96ms) (± 9.97%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.99k (250.83µs) (± 2.55%)  188kB/op  fastest
Int32 1e3          2.96k (337.93µs) (± 2.78%)  188kB/op  fastest
Int32 1e6 sorted 863.35m (  1.16s ) (± 3.40%)  183MB/op  fastest
Int32 1e6        495.54m (  2.02s ) (± 1.22%)  183MB/op  fastest
Int32 1e3 * 1e3  573.30m (  1.74s ) (± 0.62%)  183MB/op  fastest
Array 1e6 * 1e2  199.83m (  5.00s ) (± 0.00%)  336MB/op  fastest
class 1e6        492.36m (  2.03s ) (± 0.71%)  290MB/op  fastest
SlowC 1e6 * 1e2   55.49m ( 18.02s ) (± 0.00%)  427MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.03  (165.79ms) (±23.92%)  137MB/op  fastest
Int32 1e5+9e5   6.92  (144.56ms) (±13.79%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.67k (272.72µs) (± 3.05%)  141kB/op  fastest
Int32 1e3          2.90k (345.36µs) (± 3.34%)  141kB/op  fastest
Int32 1e6 sorted 891.69m (  1.12s ) (± 1.42%)  137MB/op  fastest
Int32 1e6        580.23m (  1.72s ) (± 2.58%)  137MB/op  fastest
Int32 1e3 * 1e3   12.09  ( 82.72ms) (± 4.07%)  141kB/op  fastest
Array 1e6 * 1e2  240.12m (  4.16s ) (± 2.38%)  244MB/op  fastest
class 1e6         19.30  ( 51.81ms) (± 3.80%)  22.0kB/op  fastest
SlowC 1e6 * 1e2  352.66m (  2.84s ) (± 2.77%)  708kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.69  (372.09ms) (±12.47%)  137MB/op  fastest
Int32 1e5+9e5   3.01  (331.78ms) (±12.96%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.99k (250.79µs) (± 0.86%)  188kB/op  fastest
Int32 1e3          2.89k (345.94µs) (± 2.23%)  188kB/op  fastest
Int32 1e6 sorted 784.11m (  1.28s ) (±12.74%)  183MB/op  fastest
Int32 1e6        492.38m (  2.03s ) (± 5.17%)  183MB/op  fastest
Int32 1e3 * 1e3    5.36  (186.53ms) (± 4.52%)  137MB/op  fastest
Array 1e6 * 1e2  197.53m (  5.06s ) (± 3.48%)  336MB/op  fastest
class 1e6          5.77  (173.22ms) (±11.46%)  214MB/op  fastest
SlowC 1e6 * 1e2  241.22m (  4.15s ) (± 0.84%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.63  (215.82ms) (±27.17%)  137MB/op  fastest
Int32 1e5+9e5   6.61  (151.28ms) (±15.57%)  137MB/op  fastest
```

