# benchmark results

## [datastructure/sset_benchmark_helper.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset_benchmark_helper.cr)

```

```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.68k (213.59µs) (± 4.73%)  141kB/op  fastest
Int32 1e3          3.77k (265.23µs) (± 4.29%)  141kB/op  fastest
Int32 1e6 sorted   1.27  (789.16ms) (± 2.25%)  137MB/op  fastest
Int32 1e6        794.24m (  1.26s ) (± 3.40%)  137MB/op  fastest
Int32 1e3 * 1e3   16.58  ( 60.30ms) (± 2.85%)  141kB/op  fastest
Array 1e6 * 1e2  318.75m (  3.14s ) (± 1.13%)  244MB/op  fastest
class 1e6         27.41  ( 36.48ms) (± 2.09%)  22.0kB/op  fastest
SlowC 1e6 * 1e2  448.71m (  2.23s ) (± 1.33%)  710kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.40  (294.00ms) (±11.81%)  137MB/op  fastest
Int32 1e5+9e5   4.02  (248.57ms) (± 7.57%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.89k (204.33µs) (± 4.33%)  188kB/op  fastest
Int32 1e3          3.52k (283.99µs) (± 6.62%)  188kB/op  fastest
Int32 1e6 sorted   1.14  (879.86ms) (± 3.32%)  183MB/op  fastest
Int32 1e6        649.00m (  1.54s ) (± 1.58%)  183MB/op  fastest
Int32 1e3 * 1e3    6.33  (157.95ms) (± 2.74%)  137MB/op  fastest
Array 1e6 * 1e2  261.72m (  3.82s ) (± 0.57%)  336MB/op  fastest
class 1e6          5.96  (167.77ms) (±10.15%)  215MB/op  fastest
SlowC 1e6 * 1e2  319.47m (  3.13s ) (± 4.40%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.89  (169.76ms) (±26.43%)  137MB/op  fastest
Int32 1e5+9e5   8.29  (120.65ms) (±13.98%)  137MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   5.39k (185.40µs) (± 4.50%)  141kB/op  fastest
Int32 1e3          4.75k (210.68µs) (± 3.16%)  141kB/op  fastest
Int32 1e6 sorted   1.41  (707.96ms) (± 2.32%)  137MB/op  fastest
Int32 1e6        849.63m (  1.18s ) (± 7.02%)  137MB/op  fastest
Int32 1e3 * 1e3    1.14  (880.21ms) (± 1.76%)  137MB/op  fastest
Array 1e6 * 1e2  343.66m (  2.91s ) (± 1.09%)  244MB/op  fastest
class 1e6          1.22  (818.53ms) (± 2.76%)  214MB/op  fastest
SlowC 1e6 * 1e2  143.98m (  6.95s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.59  (217.91ms) (±17.27%)  137MB/op  fastest
Int32 1e5+9e5   5.85  (171.01ms) (±10.62%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   5.06k (197.75µs) (± 2.96%)  188kB/op  fastest
Int32 1e3          3.83k (261.07µs) (± 2.93%)  188kB/op  fastest
Int32 1e6 sorted   1.16  (863.77ms) (± 2.87%)  183MB/op  fastest
Int32 1e6        652.34m (  1.53s ) (± 2.09%)  183MB/op  fastest
Int32 1e3 * 1e3  668.51m (  1.50s ) (± 2.69%)  183MB/op  fastest
Array 1e6 * 1e2  258.56m (  3.87s ) (± 1.74%)  336MB/op  fastest
class 1e6        630.71m (  1.59s ) (± 3.05%)  290MB/op  fastest
SlowC 1e6 * 1e2   75.99m ( 13.16s ) (± 0.00%)  427MB/op  fastest

-------- split --------
Int32 5e5+5e5   7.34  (136.32ms) (±22.48%)  137MB/op  fastest
Int32 1e5+9e5   8.51  (117.53ms) (±13.64%)  137MB/op  fastest
```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 151.63k (  6.59µs) (± 2.94%)  1.72kB/op  fastest
Int32 10^2 dence  134.37k (  7.44µs) (± 2.60%)  1.72kB/op  fastest
Int32 10^6 sparse   4.50  (222.01ms) (± 4.99%)  12.0MB/op  fastest
Int32 10^6 dence    4.30  (232.41ms) (± 5.38%)  12.0MB/op  fastest
Array 10^6 * 10^2 609.74m (  1.64s ) (± 1.33%)  24.0MB/op  fastest
```

