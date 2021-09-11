# benchmark results

## [datastructure/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/red_black_tree.cr)

```
Int32 10^2 sparse 139.07k (  7.19µs) (± 4.43%)  4.73kB/op  fastest
Int32 10^2 dence  132.48k (  7.55µs) (± 5.03%)  4.73kB/op  fastest
Int32 10^6 sparse 689.77m (  1.45s ) (± 0.14%)  45.8MB/op  fastest
Int32 10^6 dence    1.48  (673.72ms) (± 2.27%)  45.8MB/op  fastest
Array 10^6 * 10^2 223.16m (  4.48s ) (± 2.32%)  45.8MB/op  fastest
class 10^6        946.36m (  1.06s ) (± 3.45%)  45.8MB/op  fastest
```

## [datastructure/set/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   3.89k (256.85µs) (± 3.43%)  141kB/op  fastest
Int32 1e3          3.05k (327.45µs) (± 2.76%)  141kB/op  fastest
Int32 1e6 sorted 857.90m (  1.17s ) (± 0.65%)  137MB/op  fastest
Int32 1e6        462.65m (  2.16s ) (± 3.77%)  137MB/op  fastest
Int32 1e3 * 1e3   13.48  ( 74.20ms) (± 3.21%)  141kB/op  fastest
Array 1e6 * 1e2  180.62m (  5.54s ) (± 0.00%)  244MB/op  fastest
class 1e6        318.09m (  3.14s ) (± 0.65%)  214MB/op  fastest

-------- split --------
Int32 5e5+5e5   2.42  (413.76ms) (± 1.92%)  137MB/op  fastest
Int32 1e5+9e5   3.10  (322.36ms) (± 5.51%)  137MB/op  fastest
```

## [datastructure/set/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/set/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.06k (246.06µs) (± 2.51%)  188kB/op  fastest
Int32 1e3          3.02k (330.78µs) (± 2.69%)  188kB/op  fastest
Int32 1e6 sorted 743.83m (  1.34s ) (± 0.79%)  183MB/op  fastest
Int32 1e6        349.41m (  2.86s ) (± 1.82%)  183MB/op  fastest
Int32 1e3 * 1e3    5.34  (187.10ms) (± 3.07%)  137MB/op  fastest
Array 1e6 * 1e2  131.40m (  7.61s ) (± 0.00%)  336MB/op  fastest
class 1e6        243.98m (  4.10s ) (± 0.19%)  290MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.59  (178.74ms) (±20.62%)  137MB/op  fastest
Int32 1e5+9e5   7.00  (142.76ms) (±14.07%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 111.47k (  8.97µs) (± 3.45%)  1.72kB/op  fastest
Int32 10^2 dence   99.95k ( 10.01µs) (± 1.77%)  1.72kB/op  fastest
Int32 10^6 sparse   3.43  (291.38ms) (± 0.98%)  12.0MB/op  fastest
Int32 10^6 dence    3.24  (308.63ms) (± 3.90%)  12.0MB/op  fastest
Array 10^6 * 10^2 326.52m (  3.06s ) (± 1.91%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 128.06k (  7.81µs) (± 3.38%)  528B/op  11.45× slower
 each_sort   1.47M (682.04ns) (± 4.59%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 125.55k (  7.97µs) (± 2.79%)  528B/op   9.29× slower
 each_sort   1.17M (857.61ns) (± 5.52%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.49  (286.67ms) (± 2.75%)  3.81MB/op  26.50× slower
 each_sort  92.45  ( 10.82ms) (± 3.76%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.48  (287.14ms) (± 3.68%)  3.81MB/op   7.89× slower
 each_sort  27.47  ( 36.40ms) (± 3.68%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 306.13m (  3.27s ) (± 0.31%)   465MB/op   3.12× slower
 each_sort 955.97m (  1.05s ) (± 0.61%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.46  (406.11ms) (± 3.84%)  387MB/op   4.39× slower
 each_sort  10.82  ( 92.42ms) (± 3.40%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   6.36  (157.20ms) (± 2.19%)   382MB/op   6.65× slower
 each_sort  42.33  ( 23.62ms) (± 3.00%)  96.1kB/op        fastest
```

