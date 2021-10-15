# benchmark results

## [datastructure/binary_heap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/binary_heap.cr)

```
Int32 10^2 sparse   156.57k (  6.39µs) (± 0.24%)  1.72kB/op  fastest
Int32 10^2 dence    141.86k (  7.05µs) (± 0.32%)  1.72kB/op  fastest
Int32 10^6 sparse     5.08  (196.88ms) (± 3.15%)  12.0MB/op  fastest
Int32 10^6 dence      4.85  (206.26ms) (± 0.26%)  12.0MB/op  fastest
Int32 10^6 sparse R   2.34  (427.92ms) (± 0.10%)  12.0MB/op  fastest
Int32 10^6 dence  R   3.26  (306.45ms) (± 0.62%)  12.0MB/op  fastest
SlowC 10^6 * 10^2    99.33m ( 10.07s ) (± 0.00%)  24.0MB/op  fastest
```

## [datastructure/smultiset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.58k (218.23µs) (± 0.63%)  141kB/op  fastest
Int32 1e3          3.84k (260.50µs) (± 0.27%)  141kB/op  fastest
Int32 1e6 sorted 869.37m (  1.15s ) (± 2.29%)  137MB/op  fastest
Int32 1e6        523.69m (  1.91s ) (± 1.62%)  137MB/op  fastest
Int32 1e3 * 1e3    1.18  (849.56ms) (± 1.92%)  137MB/op  fastest
Array 1e6 * 1e2  232.72m (  4.30s ) (± 0.18%)  183MB/op  fastest
class 1e6          1.35  (741.30ms) (± 5.58%)  183MB/op  fastest
SlowC 1e6 * 1e2   96.26m ( 10.39s ) (± 0.00%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.08  (245.22ms) (±16.91%)  137MB/op  fastest
Int32 1e5+9e5   5.28  (189.55ms) (±11.87%)  137MB/op  fastest
```

## [datastructure/smultiset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/smultiset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.21k (237.46µs) (± 0.44%)  188kB/op  fastest
Int32 1e3          3.11k (321.21µs) (± 0.28%)  188kB/op  fastest
Int32 1e6 sorted 751.19m (  1.33s ) (± 0.67%)  183MB/op  fastest
Int32 1e6        411.89m (  2.43s ) (± 0.78%)  183MB/op  fastest
Int32 1e3 * 1e3  539.59m (  1.85s ) (± 2.14%)  183MB/op  fastest
Array 1e6 * 1e2  173.51m (  5.76s ) (± 0.00%)  244MB/op  fastest
class 1e6        530.38m (  1.89s ) (± 4.20%)  244MB/op  fastest
SlowC 1e6 * 1e2   54.47m ( 18.36s ) (± 0.00%)  244MB/op  fastest

-------- split --------
Int32 5e5+5e5   5.04  (198.55ms) (±26.17%)  137MB/op  fastest
Int32 1e5+9e5   7.56  (132.35ms) (±14.73%)  137MB/op  fastest
```

## [datastructure/sset/red_black_tree.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/red_black_tree.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.02k (248.80µs) (± 0.82%)  141kB/op  fastest
Int32 1e3          3.02k (331.40µs) (± 0.24%)  141kB/op  fastest
Int32 1e6 sorted 860.19m (  1.16s ) (± 1.41%)  137MB/op  fastest
Int32 1e6        499.85m (  2.00s ) (± 2.85%)  137MB/op  fastest
Int32 1e3 * 1e3   13.12  ( 76.21ms) (± 0.67%)  141kB/op  fastest
Array 1e6 * 1e2  219.20m (  4.56s ) (± 1.75%)  183MB/op  fastest
class 1e6         21.05  ( 47.50ms) (± 0.42%)  18.8kB/op  fastest
SlowC 1e6 * 1e2  386.31m (  2.59s ) (± 0.21%)  426kB/op  fastest

-------- split --------
Int32 5e5+5e5   3.24  (308.24ms) (±15.44%)  137MB/op  fastest
Int32 1e5+9e5   3.94  (253.71ms) (± 8.92%)  137MB/op  fastest
```

## [datastructure/sset/treap.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/datastructure/sset/treap.cr)

```
-------- add, delete --------
Int32 1e3 sorted   4.20k (238.19µs) (± 1.07%)  188kB/op  fastest
Int32 1e3          3.10k (322.89µs) (± 0.19%)  188kB/op  fastest
Int32 1e6 sorted 780.84m (  1.28s ) (± 0.51%)  183MB/op  fastest
Int32 1e6        435.76m (  2.29s ) (± 0.84%)  183MB/op  fastest
Int32 1e3 * 1e3    6.24  (160.36ms) (± 3.31%)  137MB/op  fastest
Array 1e6 * 1e2  201.78m (  4.96s ) (± 0.83%)  244MB/op  fastest
class 1e6          7.20  (138.90ms) (±12.55%)  183MB/op  fastest
SlowC 1e6 * 1e2  259.49m (  3.85s ) (± 2.65%)  183MB/op  fastest

-------- split --------
Int32 5e5+5e5   4.79  (208.76ms) (±29.62%)  137MB/op  fastest
Int32 1e5+9e5   7.35  (136.08ms) (±16.79%)  137MB/op  fastest
```

## [scanner.cr](https://github.com/yuruhi/crystal_lib/blob/master/benchmarks/scanner.cr)

```
      Scanner.i8 297.16  (  3.37ms) (± 0.13%)   106kB/op        fastest
 Scanner.s.to_i8 149.73  (  6.68ms) (± 0.27%)  2.52MB/op   1.98× slower
     Scanner.i16 268.67  (  3.72ms) (± 0.64%)   204kB/op        fastest
Scanner.s.to_i16 132.80  (  7.53ms) (± 0.35%)  3.26MB/op   2.02× slower
     Scanner.i32 216.44  (  4.62ms) (± 0.20%)   399kB/op        fastest
Scanner.s.to_i32 107.49  (  9.30ms) (± 0.67%)  3.46MB/op   2.01× slower
     Scanner.i64 146.56  (  6.82ms) (± 0.57%)  790kB/op        fastest
Scanner.s.to_i64  79.36  ( 12.60ms) (± 0.70%)  5.3MB/op   1.85× slower
      Scanner.u8 431.09  (  2.32ms) (± 0.12%)   106kB/op        fastest
 Scanner.s.to_u8 156.59  (  6.39ms) (± 0.25%)  2.57MB/op   2.75× slower
     Scanner.u16 419.62  (  2.38ms) (± 0.56%)   204kB/op        fastest
Scanner.s.to_u16 143.46  (  6.97ms) (± 0.28%)  3.26MB/op   2.92× slower
     Scanner.u32 304.37  (  3.29ms) (± 0.43%)   399kB/op        fastest
Scanner.s.to_u32 113.95  (  8.78ms) (± 0.55%)  3.46MB/op   2.67× slower
     Scanner.u64 200.47  (  4.99ms) (± 0.71%)  790kB/op        fastest
Scanner.s.to_u64  76.63  ( 13.05ms) (± 0.71%)  5.3MB/op   2.62× slower
```

