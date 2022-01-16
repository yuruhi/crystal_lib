require "benchmark"
require "../sset_benchmark_helper"
require "../../../src/datastructure/sset/red_black_tree"
benchmark_sset_add_delete(SSet::RedBlackTree)
puts
benchmark_sset_split(SSet::RedBlackTree)
