require "benchmark"
require "../sset_benchmark_helper"
require "../../../src/datastructure/smultiset/red_black_tree"
benchmark_sset_add_delete(SMultiSet::RedBlackTree)
puts
benchmark_sset_split(SMultiSet::RedBlackTree)
