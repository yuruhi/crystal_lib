# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 153.25k (  6.53µs) (± 2.35%)  4.73kB/op  fastest
Int32 10^2 dence  142.71k (  7.01µs) (± 1.93%)  4.73kB/op  fastest
Int32 10^6 sparse 945.14m (  1.06s ) (± 1.55%)  45.8MB/op  fastest
Int32 10^6 dence    2.43  (410.92ms) (± 5.26%)  45.8MB/op  fastest
Array 10^6 * 10^2 309.00m (  3.24s ) (± 1.12%)  45.8MB/op  fastest
class 10^6          1.59  (630.28ms) (± 5.05%)  45.8MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 112.39k (  8.90µs) (± 1.63%)  1.72kB/op  fastest
Int32 10^2 dence   98.59k ( 10.14µs) (± 0.98%)  1.72kB/op  fastest
Int32 10^6 sparse   3.65  (274.25ms) (± 2.14%)  12.0MB/op  fastest
Int32 10^6 dence    3.50  (285.60ms) (± 2.12%)  12.0MB/op  fastest
Array 10^6 * 10^2 442.96m (  2.26s ) (± 1.45%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 136.32k (  7.34µs) (± 2.05%)  528B/op  12.26× slower
 each_sort   1.67M (598.25ns) (± 2.56%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 130.27k (  7.68µs) (± 2.24%)  528B/op  10.31× slower
 each_sort   1.34M (744.76ns) (± 1.25%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.78  (264.64ms) (± 2.19%)  3.81MB/op  23.70× slower
 each_sort  89.57  ( 11.16ms) (± 1.50%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.75  (266.77ms) (± 1.52%)  3.81MB/op   7.28× slower
 each_sort  27.29  ( 36.64ms) (± 2.73%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 428.74m (  2.33s ) (± 0.82%)   465MB/op   3.36× slower
 each_sort   1.44  (695.04ms) (± 1.64%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.78  (359.59ms) (± 3.20%)  387MB/op   5.48× slower
 each_sort  15.25  ( 65.59ms) (± 2.45%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   6.16  (162.46ms) (± 1.47%)   382MB/op   8.16× slower
 each_sort  50.22  ( 19.91ms) (± 1.77%)  96.1kB/op        fastest
```

