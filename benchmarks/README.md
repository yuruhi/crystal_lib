# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 169.83k (  5.89µs) (± 5.69%)  4.73kB/op  fastest
Int32 10^2 dence  163.43k (  6.12µs) (± 3.28%)  4.73kB/op  fastest
Int32 10^6 sparse   1.29  (773.34ms) (± 3.13%)  45.8MB/op  fastest
Int32 10^6 dence    2.22  (451.07ms) (± 1.59%)  45.8MB/op  fastest
Array 10^6 * 10^2 350.22m (  2.86s ) (± 0.18%)  45.8MB/op  fastest
class 10^6          1.59  (628.88ms) (± 4.12%)  45.8MB/op  fastest
```

## [datastructure/set/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.74k (210.79µs) (± 5.24%)  188kB/op  fastest
Int32 1e3          3.45k (289.59µs) (± 3.90%)  188kB/op  fastest
Int32 1e6 sorted   1.07  (935.80ms) (± 4.95%)  183MB/op  fastest
Int32 1e6        597.36m (  1.67s ) (± 2.39%)  183MB/op  fastest
Int32 1e3 * 1e3    6.28  (159.26ms) (± 5.18%)  137MB/op  fastest
Array 1e6 * 1e2  242.00m (  4.13s ) (± 0.62%)  336MB/op  fastest
class 1e6        414.13m (  2.41s ) (± 4.00%)  290MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.07  (164.67ms) (±21.64%)  137MB/op  fastest
Int32 1e5+9e5   8.02  (124.73ms) (±13.78%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 146.20k (  6.84µs) (± 2.82%)  1.72kB/op  fastest
Int32 10^2 dence  128.51k (  7.78µs) (± 3.76%)  1.72kB/op  fastest
Int32 10^6 sparse   4.48  (223.15ms) (± 2.48%)  12.0MB/op  fastest
Int32 10^6 dence    4.25  (235.13ms) (± 4.17%)  12.0MB/op  fastest
Array 10^6 * 10^2 585.59m (  1.71s ) (± 1.68%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 171.90k (  5.82µs) (± 3.03%)  528B/op  10.55× slower
 each_sort   1.81M (551.60ns) (± 2.71%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 157.45k (  6.35µs) (± 8.18%)  528B/op   9.57× slower
 each_sort   1.51M (663.74ns) (± 3.70%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   4.67  (213.99ms) (± 2.30%)  3.81MB/op  27.24× slower
 each_sort 127.30  (  7.86ms) (± 3.66%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   4.65  (214.93ms) (± 3.82%)  3.81MB/op   7.58× slower
 each_sort  35.27  ( 28.35ms) (± 3.27%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 502.38m (  1.99s ) (± 1.85%)   465MB/op   3.52× slower
 each_sort   1.77  (565.28ms) (± 2.11%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   3.08  (324.32ms) (± 4.21%)  387MB/op   5.72× slower
 each_sort  17.64  ( 56.68ms) (± 3.21%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   6.35  (157.59ms) (± 2.31%)   382MB/op   9.25× slower
 each_sort  58.67  ( 17.05ms) (± 4.30%)  96.0kB/op        fastest
```

