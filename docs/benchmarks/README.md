# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 115.46k (  8.66µs) (± 3.62%)  1.72kB/op  fastest
Int32 10^2 dence 102.86k (  9.72µs) (± 4.40%)  1.72kB/op  fastest
Int32 10^6 sparse   3.34  (299.10ms) (± 3.54%)  12.0MB/op  fastest
Int32 10^6 dence   3.35  (298.31ms) (± 3.52%)  12.0MB/op  fastest
Array 10^6 * 10^2 505.84m (  1.98s ) (± 2.00%)  24.0MB/op  fastest
```

## [datastructure/binary_heap_each.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap_each.cr)

```
Int32 10^2 sparse: 
each_clone 138.17k (  7.24µs) (± 3.29%)  528B/op  10.85× slower
 each_sort   1.50M (667.33ns) (± 2.41%)  832B/op        fastest

Int32 10^2 dence: 
each_clone 128.28k (  7.80µs) (± 2.18%)  528B/op   9.38× slower
 each_sort   1.20M (830.66ns) (± 2.12%)  832B/op        fastest

Int32 10^6 sparse: 
each_clone   3.72  (268.63ms) (± 2.44%)  3.81MB/op  27.64× slower
 each_sort 102.91  (  9.72ms) (± 3.05%)   6.0MB/op        fastest

Int32 10^6 dence: 
each_clone   3.78  (264.88ms) (± 2.56%)  3.81MB/op   7.57× slower
 each_sort  28.57  ( 35.00ms) (± 3.56%)   6.0MB/op        fastest

Array 10^6 * 10^2: 
each_clone 432.27m (  2.31s ) (± 1.44%)   465MB/op   3.58× slower
 each_sort   1.55  (646.33ms) (± 1.38%)  12.0MB/op        fastest

Array 10^5 * 10^3: 
each_clone   2.65  (376.67ms) (± 4.68%)  387MB/op   5.72× slower
 each_sort  15.18  ( 65.88ms) (± 3.00%)  1.5MB/op        fastest

Array 10^4 * 10^4: 
each_clone   5.58  (179.35ms) (± 2.70%)   382MB/op   8.19× slower
 each_sort  45.68  ( 21.89ms) (± 3.50%)  96.1kB/op        fastest
```

