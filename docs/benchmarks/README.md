# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 154.11k (  6.49µs) (± 2.74%)  4.73kB/op  fastest
Int32 10^2 dence  146.42k (  6.83µs) (± 2.91%)  4.73kB/op  fastest
Int32 10^6 sparse   1.04  (965.40ms) (± 5.26%)  45.8MB/op  fastest
Int32 10^6 dence    1.94  (516.58ms) (± 2.27%)  45.8MB/op  fastest
Array 10^6 * 10^2 335.65m (  2.98s ) (± 0.12%)  45.8MB/op  fastest
class 10^6          1.35  (742.08ms) (± 6.31%)  45.8MB/op  fastest
```

## [datastructure/set/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/treap.cr)

```
Int32 1..1e2 * 1e1   7.76k (128.82µs) (± 2.63%)  146kB/op  fastest
Int32 1..1e2 * 1e4   9.69  (103.24ms) (± 4.11%)  137MB/op  fastest
Int32 1..1e3         3.35k (298.57µs) (± 3.49%)  188kB/op  fastest
Int32 1..1e6       578.29m (  1.73s ) (± 1.66%)  183MB/op  fastest
Array 1e6 * 1e2    219.22m (  4.56s ) (± 0.48%)  336MB/op  fastest
class 1..1e6       384.50m (  2.60s ) (± 0.81%)  290MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 128.17k (  7.80µs) (± 4.52%)  1.72kB/op  fastest
Int32 10^2 dence  114.90k (  8.70µs) (± 4.00%)  1.72kB/op  fastest
Int32 10^6 sparse   3.96  (252.33ms) (± 3.21%)  12.0MB/op  fastest
Int32 10^6 dence    3.77  (265.16ms) (± 2.54%)  12.0MB/op  fastest
Array 10^6 * 10^2 532.12m (  1.88s ) (± 3.04%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 149.61k (  6.68µs) (± 3.60%)  528B/op  11.26× slower
 each_sort   1.68M (593.54ns) (± 2.49%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 144.21k (  6.93µs) (± 4.77%)  528B/op   9.79× slower
 each_sort   1.41M (708.09ns) (± 4.33%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   4.12  (242.48ms) (± 3.01%)  3.81MB/op  25.17× slower
 each_sort 103.82  (  9.63ms) (± 5.16%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   4.02  (248.57ms) (± 2.37%)  3.81MB/op   7.42× slower
 each_sort  29.86  ( 33.49ms) (± 3.36%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 428.99m (  2.33s ) (± 1.32%)   465MB/op   3.51× slower
 each_sort   1.51  (663.39ms) (± 1.54%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.74  (365.26ms) (± 4.40%)  387MB/op   5.57× slower
 each_sort  15.24  ( 65.61ms) (± 3.34%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.68  (175.92ms) (± 2.02%)   382MB/op   8.75× slower
 each_sort  49.73  ( 20.11ms) (± 4.39%)  96.1kB/op        fastest
```

