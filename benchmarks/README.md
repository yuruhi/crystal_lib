# benchmark results

## [datastructure/sset_benchmark_helper.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset_benchmark_helper.cr)

```

```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.50k (285.34µs) (± 1.89%)  141kB/op  fastest
Int32 1e3          2.65k (377.12µs) (± 1.17%)  141kB/op  fastest
Int32 1e6 sorted   1.00  (996.41ms) (± 1.23%)  137MB/op  fastest
Int32 1e6        615.08m (  1.63s ) (± 2.96%)  137MB/op  fastest
Int32 1e3 * 1e3   11.33  ( 88.24ms) (± 1.62%)  141kB/op  fastest
Array 1e6 * 1e2  262.09m (  3.82s ) (± 0.12%)  244MB/op  fastest
class 1e6         20.05  ( 49.87ms) (± 1.68%)  22.0kB/op  fastest
SlowC 1e6 * 1e2  348.25m (  2.87s ) (± 0.37%)  708kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.96  (337.93ms) (±13.59%)  137MB/op  fastest
Int32 1e5+9e5   3.54  (282.23ms) (± 6.57%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.63k (275.76µs) (± 1.45%)  188kB/op  fastest
Int32 1e3          2.69k (371.98µs) (± 1.35%)  188kB/op  fastest
Int32 1e6 sorted 910.57m (  1.10s ) (± 1.13%)  183MB/op  fastest
Int32 1e6        523.93m (  1.91s ) (± 2.10%)  183MB/op  fastest
Int32 1e3 * 1e3    5.62  (177.82ms) (± 2.19%)  137MB/op  fastest
Array 1e6 * 1e2  221.86m (  4.51s ) (± 1.11%)  336MB/op  fastest
class 1e6          5.63  (177.52ms) (± 8.93%)  214MB/op  fastest
SlowC 1e6 * 1e2  235.42m (  4.25s ) (± 3.43%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.79  (208.64ms) (±28.40%)  137MB/op  fastest
Int32 1e5+9e5   6.63  (150.73ms) (±13.09%)  137MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.94k (253.82µs) (± 1.39%)  141kB/op  fastest
Int32 1e3          3.31k (302.03µs) (± 1.60%)  141kB/op  fastest
Int32 1e6 sorted   1.06  (940.06ms) (± 2.62%)  137MB/op  fastest
Int32 1e6        650.70m (  1.54s ) (± 2.95%)  137MB/op  fastest
Int32 1e3 * 1e3    1.12  (891.73ms) (± 0.85%)  137MB/op  fastest
Array 1e6 * 1e2  273.62m (  3.65s ) (± 0.85%)  244MB/op  fastest
class 1e6          1.37  (729.86ms) (± 3.61%)  214MB/op  fastest
SlowC 1e6 * 1e2  109.07m (  9.17s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.79  (263.66ms) (±20.28%)  137MB/op  fastest
Int32 1e5+9e5   4.78  (209.40ms) (± 8.58%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.67k (272.18µs) (± 1.57%)  188kB/op  fastest
Int32 1e3          2.71k (369.55µs) (± 1.35%)  188kB/op  fastest
Int32 1e6 sorted 912.85m (  1.10s ) (± 1.70%)  183MB/op  fastest
Int32 1e6        523.16m (  1.91s ) (± 1.47%)  183MB/op  fastest
Int32 1e3 * 1e3  593.61m (  1.68s ) (± 0.16%)  183MB/op  fastest
Array 1e6 * 1e2  219.44m (  4.56s ) (± 1.59%)  336MB/op  fastest
class 1e6        564.50m (  1.77s ) (± 2.86%)  290MB/op  fastest
SlowC 1e6 * 1e2   52.19m ( 19.16s ) (± 0.00%)  427MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.07  (164.68ms) (±20.90%)  137MB/op  fastest
Int32 1e5+9e5   6.84  (146.13ms) (±14.26%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 115.57k (  8.65µs) (± 1.72%)  1.72kB/op  fastest
Int32 10^2 dence  100.66k (  9.93µs) (± 1.70%)  1.72kB/op  fastest
Int32 10^6 sparse   3.60  (277.74ms) (± 0.83%)  12.0MB/op  fastest
Int32 10^6 dence    3.43  (291.78ms) (± 0.87%)  12.0MB/op  fastest
Array 10^6 * 10^2 491.40m (  2.03s ) (± 0.35%)  24.0MB/op  fastest
```

