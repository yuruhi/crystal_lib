# benchmark results

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.27k (234.30µs) (± 4.72%)  188kB/op  fastest
Int32 1e3          3.24k (308.17µs) (± 6.87%)  188kB/op  fastest
Int32 1e6 sorted 844.48m (  1.18s ) (± 3.36%)  183MB/op  fastest
Int32 1e6        430.86m (  2.32s ) (± 1.87%)  183MB/op  fastest
Int32 1e3 * 1e3  521.19m (  1.92s ) (± 2.14%)  183MB/op  fastest
Array 1e6 * 1e2  190.77m (  5.24s ) (± 0.00%)  336MB/op  fastest
class 1e6        476.64m (  2.10s ) (± 2.47%)  290MB/op  fastest
SlowC 1e6 * 1e2   57.16m ( 17.49s ) (± 0.00%)  427MB/op  fastest

-------- split --------
Int32 5e5+5e5   6.24  (160.30ms) (±25.83%)  137MB/op  fastest
Int32 1e5+9e5   7.21  (138.61ms) (±14.21%)  137MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.86k (205.65µs) (± 5.25%)  141kB/op  fastest
Int32 1e3          4.09k (244.35µs) (± 5.79%)  141kB/op  fastest
Int32 1e6 sorted   1.08  (922.93ms) (± 1.82%)  137MB/op  fastest
Int32 1e6        647.13m (  1.55s ) (± 9.73%)  137MB/op  fastest
Int32 1e3 * 1e3    1.02  (982.79ms) (± 3.91%)  137MB/op  fastest
Array 1e6 * 1e2  257.93m (  3.88s ) (± 4.67%)  244MB/op  fastest
class 1e6          1.01  (991.07ms) (± 4.63%)  214MB/op  fastest
SlowC 1e6 * 1e2  117.36m (  8.52s ) (± 0.00%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   3.84  (260.34ms) (±19.47%)  137MB/op  fastest
Int32 1e5+9e5   4.79  (208.85ms) (±11.83%)  137MB/op  fastest
```

## [datastructure/sset_benchmark_helper.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset_benchmark_helper.cr)

```

```

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse 134.30k (  7.45µs) (± 6.86%)  1.72kB/op  fastest
Int32 10^2 dence  117.27k (  8.53µs) (± 5.91%)  1.72kB/op  fastest
Int32 10^6 sparse   4.01  (249.19ms) (± 4.94%)  12.0MB/op  fastest
Int32 10^6 dence    4.05  (247.04ms) (± 4.30%)  12.0MB/op  fastest
Array 10^6 * 10^2 420.44m (  2.38s ) (± 1.97%)  24.0MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.36k (229.47µs) (± 7.16%)  188kB/op  fastest
Int32 1e3          3.28k (304.68µs) (± 5.13%)  188kB/op  fastest
Int32 1e6 sorted 900.48m (  1.11s ) (± 4.47%)  183MB/op  fastest
Int32 1e6        473.67m (  2.11s ) (± 2.12%)  183MB/op  fastest
Int32 1e3 * 1e3    5.88  (170.16ms) (± 4.68%)  137MB/op  fastest
Array 1e6 * 1e2  191.12m (  5.23s ) (± 0.00%)  336MB/op  fastest
class 1e6          6.04  (165.44ms) (±14.44%)  214MB/op  fastest
SlowC 1e6 * 1e2  251.77m (  3.97s ) (± 9.49%)  305MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.69  (213.36ms) (±36.29%)  137MB/op  fastest
Int32 1e5+9e5   6.09  (164.19ms) (±26.85%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.14k (241.27µs) (± 6.12%)  141kB/op  fastest
Int32 1e3          3.13k (319.21µs) (± 4.67%)  141kB/op  fastest
Int32 1e6 sorted 918.13m (  1.09s ) (± 4.04%)  137MB/op  fastest
Int32 1e6        616.24m (  1.62s ) (± 2.85%)  137MB/op  fastest
Int32 1e3 * 1e3   14.74  ( 67.83ms) (± 5.39%)  141kB/op  fastest
Array 1e6 * 1e2  228.79m (  4.37s ) (± 0.30%)  244MB/op  fastest
class 1e6         21.76  ( 45.95ms) (± 5.98%)  22.0kB/op  fastest
SlowC 1e6 * 1e2  386.97m (  2.58s ) (± 0.34%)  708kB/op  fastest

-------- split --------
Int32 5e5+5e5   2.96  (338.11ms) (±15.59%)  137MB/op  fastest
Int32 1e5+9e5   3.54  (282.45ms) (± 8.22%)  137MB/op  fastest
```

