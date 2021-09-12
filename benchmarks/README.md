# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 176.19k (  5.68µs) (± 2.24%)  4.73kB/op  fastest
Int32 10^2 dence  166.78k (  6.00µs) (± 0.54%)  4.73kB/op  fastest
Int32 10^6 sparse   1.16  (858.38ms) (± 1.53%)  45.8MB/op  fastest
Int32 10^6 dence    2.54  (393.71ms) (± 0.60%)  45.8MB/op  fastest
Array 10^6 * 10^2 341.48m (  2.93s ) (± 0.30%)  45.8MB/op  fastest
class 10^6          1.84  (544.04ms) (± 6.35%)  45.8MB/op  fastest
```

## [datastructure/set/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.33k (230.84µs) (± 1.20%)  141kB/op  fastest
Int32 1e3          3.22k (310.48µs) (± 0.46%)  141kB/op  fastest
Int32 1e6 sorted   1.15  (872.12ms) (± 1.09%)  137MB/op  fastest
Int32 1e6        778.28m (  1.28s ) (± 1.19%)  137MB/op  fastest
Int32 1e3 * 1e3   14.18  ( 70.51ms) (± 0.53%)  141kB/op  fastest
Array 1e6 * 1e2  281.02m (  3.56s ) (± 0.06%)  244MB/op  fastest
class 1e6        559.01m (  1.79s ) (± 1.63%)  214MB/op  fastest

-------- split --------
Int32 5e5+5e5   2.89  (346.06ms) (± 0.95%)  137MB/op  fastest
Int32 1e5+9e5   3.87  (258.73ms) (± 6.27%)  137MB/op  fastest
```

## [datastructure/set/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.44k (225.07µs) (± 0.17%)  188kB/op  fastest
Int32 1e3          3.24k (308.35µs) (± 0.69%)  188kB/op  fastest
Int32 1e6 sorted   1.04  (957.68ms) (± 0.86%)  183MB/op  fastest
Int32 1e6        616.47m (  1.62s ) (± 0.84%)  183MB/op  fastest
Int32 1e3 * 1e3    6.09  (164.18ms) (± 2.36%)  137MB/op  fastest
Array 1e6 * 1e2  234.13m (  4.27s ) (± 0.80%)  336MB/op  fastest
class 1e6        434.22m (  2.30s ) (± 1.00%)  290MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.08  (164.41ms) (±21.13%)  137MB/op  fastest
Int32 1e5+9e5   7.63  (131.11ms) (±12.50%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 132.75k (  7.53µs) (± 0.10%)  1.72kB/op  fastest
Int32 10^2 dence  117.17k (  8.53µs) (± 0.10%)  1.72kB/op  fastest
Int32 10^6 sparse   4.16  (240.30ms) (± 0.10%)  12.0MB/op  fastest
Int32 10^6 dence    3.98  (251.46ms) (± 0.04%)  12.0MB/op  fastest
Array 10^6 * 10^2 561.99m (  1.78s ) (± 0.88%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 154.76k (  6.46µs) (± 0.07%)  528B/op  12.47× slower
 each_sort   1.93M (518.15ns) (± 1.27%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 150.54k (  6.64µs) (± 0.07%)  528B/op  10.51× slower
 each_sort   1.58M (632.17ns) (± 0.17%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   4.34  (230.55ms) (± 0.26%)  3.81MB/op  26.05× slower
 each_sort 113.01  (  8.85ms) (± 0.73%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   4.28  (233.40ms) (± 0.14%)  3.81MB/op   7.10× slower
 each_sort  30.44  ( 32.86ms) (± 0.45%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 480.10m (  2.08s ) (± 1.02%)   465MB/op   3.31× slower
 each_sort   1.59  (628.41ms) (± 0.65%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.80  (356.51ms) (± 4.04%)  387MB/op   5.91× slower
 each_sort  16.58  ( 60.32ms) (± 0.54%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   6.04  (165.63ms) (± 1.00%)   382MB/op   8.72× slower
 each_sort  52.62  ( 19.00ms) (± 0.75%)  96.1kB/op        fastest
```

