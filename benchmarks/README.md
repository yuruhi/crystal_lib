# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 149.20k (  6.70µs) (± 4.31%)  4.73kB/op  fastest
Int32 10^2 dence  143.45k (  6.97µs) (± 3.66%)  4.73kB/op  fastest
Int32 10^6 sparse 687.26m (  1.46s ) (± 1.51%)  45.8MB/op  fastest
Int32 10^6 dence    1.55  (644.05ms) (± 1.54%)  45.8MB/op  fastest
Array 10^6 * 10^2 217.65m (  4.59s ) (± 2.23%)  45.8MB/op  fastest
class 10^6        964.17m (  1.04s ) (± 3.20%)  45.8MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 121.60k (  8.22µs) (± 3.19%)  1.72kB/op  fastest
Int32 10^2 dence 107.34k (  9.32µs) (± 4.03%)  1.72kB/op  fastest
Int32 10^6 sparse   3.71  (269.63ms) (± 2.16%)  12.0MB/op  fastest
Int32 10^6 dence   3.49  (286.60ms) (± 2.97%)  12.0MB/op  fastest
Array 10^6 * 10^2 311.19m (  3.21s ) (± 1.32%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 138.71k (  7.21µs) (± 4.19%)  528B/op  11.44× slower
 each_sort   1.59M (630.36ns) (± 3.09%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 135.51k (  7.38µs) (± 3.26%)  528B/op   9.56× slower
 each_sort   1.30M (772.03ns) (± 3.73%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.74  (267.58ms) (± 2.57%)  3.81MB/op  26.16× slower
 each_sort  97.75  ( 10.23ms) (± 4.39%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.71  (269.31ms) (± 3.63%)  3.81MB/op   7.94× slower
 each_sort  29.49  ( 33.91ms) (± 3.52%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 301.44m (  3.32s ) (± 0.57%)   465MB/op   3.02× slower
 each_sort 910.86m (  1.10s ) (± 0.91%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.34  (426.74ms) (± 5.51%)  387MB/op   4.67× slower
 each_sort  10.95  ( 91.32ms) (± 3.32%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.80  (172.55ms) (± 3.19%)   382MB/op   7.50× slower
 each_sort  43.47  ( 23.00ms) (± 4.11%)  96.0kB/op        fastest
```

