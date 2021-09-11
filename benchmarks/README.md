# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 149.31k (  6.70µs) (± 5.88%)  4.73kB/op  fastest
Int32 10^2 dence  145.76k (  6.86µs) (± 4.57%)  4.73kB/op  fastest
Int32 10^6 sparse   1.05  (956.49ms) (± 3.59%)  45.8MB/op  fastest
Int32 10^6 dence    1.87  (535.81ms) (± 2.97%)  45.8MB/op  fastest
Array 10^6 * 10^2 334.32m (  2.99s ) (± 1.84%)  45.8MB/op  fastest
class 10^6          1.38  (724.78ms) (± 3.28%)  45.8MB/op  fastest
```

## [datastructure/set/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.47k (223.55µs) (± 4.89%)  141kB/op  fastest
Int32 1e3          3.54k (282.43µs) (± 5.25%)  141kB/op  fastest
Int32 1e6 sorted   1.18  (848.10ms) (± 3.27%)  137MB/op  fastest
Int32 1e6        696.94m (  1.43s ) (± 4.52%)  137MB/op  fastest
Int32 1e3 * 1e3    6.58  (151.89ms) (± 6.36%)  141kB/op  fastest
Array 1e6 * 1e2  256.01m (  3.91s ) (± 2.65%)  244MB/op  fastest
class 1e6        482.82m (  2.07s ) (± 0.24%)  214MB/op  fastest

-------- split --------
Int32 5e5+5e5   2.59  (385.77ms) (± 5.42%)  137MB/op  fastest
Int32 1e5+9e5   3.44  (290.71ms) (± 6.36%)  137MB/op  fastest
```

## [datastructure/set/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.12k (242.86µs) (± 3.58%)  188kB/op  fastest
Int32 1e3          3.24k (308.25µs) (± 4.48%)  188kB/op  fastest
Int32 1e6 sorted 979.03m (  1.02s ) (± 3.10%)  183MB/op  fastest
Int32 1e6        538.29m (  1.86s ) (± 0.62%)  183MB/op  fastest
Int32 1e3 * 1e3    5.47  (182.83ms) (± 5.22%)  137MB/op  fastest
Array 1e6 * 1e2  210.22m (  4.76s ) (± 0.92%)  336MB/op  fastest
class 1e6        358.73m (  2.79s ) (± 0.74%)  290MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.41  (184.80ms) (±20.58%)  137MB/op  fastest
Int32 1e5+9e5   6.90  (144.88ms) (±13.46%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 120.97k (  8.27µs) (± 6.71%)  1.72kB/op  fastest
Int32 10^2 dence  111.21k (  8.99µs) (± 5.25%)  1.72kB/op  fastest
Int32 10^6 sparse   3.90  (256.57ms) (± 4.90%)  12.0MB/op  fastest
Int32 10^6 dence    3.55  (281.37ms) (± 6.23%)  12.0MB/op  fastest
Array 10^6 * 10^2 437.14m (  2.29s ) (± 3.66%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 141.16k (  7.08µs) (± 4.80%)  528B/op  11.15× slower
 each_sort   1.57M (635.48ns) (± 3.93%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 128.72k (  7.77µs) (± 5.68%)  528B/op  10.27× slower
 each_sort   1.32M (756.55ns) (± 4.99%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.84  (260.67ms) (± 4.72%)  3.81MB/op  25.19× slower
 each_sort  96.64  ( 10.35ms) (± 5.86%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.65  (273.90ms) (± 2.02%)  3.81MB/op   7.94× slower
 each_sort  29.00  ( 34.49ms) (± 4.14%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 406.55m (  2.46s ) (± 2.02%)   465MB/op   3.64× slower
 each_sort   1.48  (675.84ms) (± 2.62%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.61  (382.71ms) (± 5.25%)  387MB/op   5.89× slower
 each_sort  15.39  ( 64.98ms) (± 4.94%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.63  (177.55ms) (± 2.68%)   382MB/op   8.65× slower
 each_sort  48.71  ( 20.53ms) (± 5.69%)  96.1kB/op        fastest
```

