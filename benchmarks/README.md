# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 132.00k (  7.58µs) (± 3.56%)  4.73kB/op  fastest
Int32 10^2 dence  124.60k (  8.03µs) (± 3.48%)  4.73kB/op  fastest
Int32 10^6 sparse 701.02m (  1.43s ) (± 7.56%)  45.8MB/op  fastest
Int32 10^6 dence    1.57  (637.54ms) (± 4.32%)  45.8MB/op  fastest
Array 10^6 * 10^2 296.93m (  3.37s ) (± 0.03%)  45.8MB/op  fastest
class 10^6          1.18  (848.45ms) (± 2.69%)  45.8MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 106.97k (  9.35µs) (± 4.13%)  1.72kB/op  fastest
Int32 10^2 dence   94.46k ( 10.59µs) (± 3.88%)  1.72kB/op  fastest
Int32 10^6 sparse   3.07  (326.06ms) (± 7.43%)  12.0MB/op  fastest
Int32 10^6 dence    2.86  (349.25ms) (± 6.17%)  12.0MB/op  fastest
Array 10^6 * 10^2 415.59m (  2.41s ) (± 5.27%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 112.53k (  8.89µs) (± 6.19%)  528B/op  11.45× slower
 each_sort   1.29M (776.02ns) (± 9.28%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 118.06k (  8.47µs) (± 5.78%)  528B/op   9.63× slower
 each_sort   1.14M (879.62ns) (± 5.30%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.38  (296.19ms) (± 2.10%)  3.81MB/op  24.29× slower
 each_sort  82.01  ( 12.19ms) (± 9.35%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.13  (319.65ms) (± 5.18%)  3.81MB/op   7.89× slower
 each_sort  24.68  ( 40.52ms) (± 5.54%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 345.75m (  2.89s ) (± 0.64%)   465MB/op   3.79× slower
 each_sort   1.31  (762.27ms) (± 4.65%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.26  (442.59ms) (± 5.20%)  387MB/op   5.94× slower
 each_sort  13.41  ( 74.55ms) (± 4.90%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.25  (190.41ms) (± 2.11%)   382MB/op   8.12× slower
 each_sort  42.66  ( 23.44ms) (± 3.46%)  96.0kB/op        fastest
```

