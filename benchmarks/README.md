# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 131.63k (  7.60µs) (± 5.96%)  4.73kB/op  fastest
Int32 10^2 dence  128.81k (  7.76µs) (± 3.09%)  4.73kB/op  fastest
Int32 10^6 sparse   1.05  (950.95ms) (± 6.29%)  45.8MB/op  fastest
Int32 10^6 dence    1.94  (515.53ms) (± 1.58%)  45.8MB/op  fastest
Array 10^6 * 10^2 332.64m (  3.01s ) (± 1.53%)  45.8MB/op  fastest
class 10^6          1.36  (737.18ms) (± 4.65%)  45.8MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 123.31k (  8.11µs) (± 3.57%)  1.72kB/op  fastest
Int32 10^2 dence  108.56k (  9.21µs) (± 3.72%)  1.72kB/op  fastest
Int32 10^6 sparse   3.80  (263.36ms) (± 2.19%)  12.0MB/op  fastest
Int32 10^6 dence    3.64  (274.36ms) (± 2.17%)  12.0MB/op  fastest
Array 10^6 * 10^2 506.21m (  1.98s ) (± 2.35%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 143.76k (  6.96µs) (± 4.18%)  528B/op  10.93× slower
 each_sort   1.57M (636.61ns) (± 2.91%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 138.34k (  7.23µs) (± 3.60%)  528B/op   8.80× slower
 each_sort   1.22M (821.30ns) (± 4.51%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.72  (268.71ms) (± 3.34%)  3.81MB/op  25.72× slower
 each_sort  95.71  ( 10.45ms) (± 5.55%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.67  (272.57ms) (± 3.69%)  3.81MB/op   7.44× slower
 each_sort  27.28  ( 36.65ms) (± 3.74%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 417.88m (  2.39s ) (± 3.34%)   465MB/op   3.65× slower
 each_sort   1.52  (655.89ms) (± 1.08%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.66  (375.92ms) (± 4.87%)  387MB/op   5.76× slower
 each_sort  15.32  ( 65.27ms) (± 3.21%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.63  (177.46ms) (± 1.87%)   382MB/op   8.72× slower
 each_sort  49.13  ( 20.35ms) (± 3.96%)  96.1kB/op        fastest
```

