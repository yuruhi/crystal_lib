# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 118.67k (  8.43µs) (± 4.93%)  1.72kB/op  fastest
Int32 10^2 dence  107.32k (  9.32µs) (± 3.04%)  1.72kB/op  fastest
Int32 10^6 sparse   3.81  (262.42ms) (± 2.42%)  12.0MB/op  fastest
Int32 10^6 dence    3.51  (284.99ms) (± 3.68%)  12.0MB/op  fastest
Array 10^6 * 10^2 460.55m (  2.17s ) (± 3.44%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.40k (227.21µs) (± 3.76%)  141kB/op  fastest
Int32 1e3          3.78k (264.69µs) (± 4.12%)  141kB/op  fastest
Int32 1e6 sorted   1.12  (896.55ms) (± 1.85%)  137MB/op  fastest
Int32 1e6        629.73m (  1.59s ) (± 1.64%)  137MB/op  fastest
Int32 1e3 * 1e3  943.83m (  1.06s ) (± 2.37%)  137MB/op  fastest
Array 1e6 * 1e2  277.18m (  3.61s ) (± 1.47%)  183MB/op  fastest
class 1e6          1.02  (979.68ms) (± 3.32%)  183MB/op  fastest
SlowC 1e6 * 1e2  115.03m (  8.69s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.94  (253.99ms) (±14.87%)  137MB/op  fastest
Int32 1e5+9e5   4.70  (212.81ms) (± 9.62%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.03k (248.01µs) (± 3.17%)  188kB/op  fastest
Int32 1e3          3.00k (333.36µs) (± 3.27%)  188kB/op  fastest
Int32 1e6 sorted 858.52m (  1.16s ) (± 2.94%)  183MB/op  fastest
Int32 1e6        498.35m (  2.01s ) (± 1.01%)  183MB/op  fastest
Int32 1e3 * 1e3  536.13m (  1.87s ) (± 0.18%)  183MB/op  fastest
Array 1e6 * 1e2  212.14m (  4.71s ) (± 4.19%)  244MB/op  fastest
class 1e6        495.06m (  2.02s ) (± 3.32%)  244MB/op  fastest
SlowC 1e6 * 1e2   58.81m ( 17.00s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.97  (201.25ms) (±20.18%)  137MB/op  fastest
Int32 1e5+9e5   6.74  (148.44ms) (±14.64%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.70k (270.00µs) (± 4.25%)  141kB/op  fastest
Int32 1e3          3.00k (333.19µs) (± 4.58%)  141kB/op  fastest
Int32 1e6 sorted 985.86m (  1.01s ) (± 2.17%)  137MB/op  fastest
Int32 1e6        597.89m (  1.67s ) (± 3.82%)  137MB/op  fastest
Int32 1e3 * 1e3   12.82  ( 78.02ms) (± 3.37%)  141kB/op  fastest
Array 1e6 * 1e2  270.63m (  3.70s ) (± 0.74%)  183MB/op  fastest
class 1e6         22.29  ( 44.86ms) (± 3.35%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  374.39m (  2.67s ) (± 0.91%)  424kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.80  (357.48ms) (±13.25%)  137MB/op  fastest
Int32 1e5+9e5   3.23  (309.58ms) (± 7.11%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.97k (252.09µs) (± 4.76%)  188kB/op  fastest
Int32 1e3          2.92k (342.17µs) (± 3.48%)  188kB/op  fastest
Int32 1e6 sorted 881.09m (  1.13s ) (± 2.54%)  183MB/op  fastest
Int32 1e6        466.95m (  2.14s ) (± 6.25%)  183MB/op  fastest
Int32 1e3 * 1e3    5.24  (190.71ms) (± 3.73%)  137MB/op  fastest
Array 1e6 * 1e2  219.50m (  4.56s ) (± 1.62%)  244MB/op  fastest
class 1e6          6.70  (149.30ms) (±12.05%)  183MB/op  fastest
SlowC 1e6 * 1e2  229.48m (  4.36s ) (± 1.89%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.69  (213.10ms) (±33.85%)  137MB/op  fastest
Int32 1e5+9e5   6.39  (156.49ms) (±18.57%)  137MB/op  fastest
```

