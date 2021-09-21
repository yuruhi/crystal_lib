---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/datastructure/smultiset/red_black_tree_spec.cr
    title: spec/datastructure/smultiset/red_black_tree_spec.cr
  - icon: ':warning:'
    path: spec/datastructure/smultiset/treap_spec.cr
    title: spec/datastructure/smultiset/treap_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\ndef run_smultiset_spec(type : MS.class, class_name\
    \ : String) forall MS\n  describe class_name + \"(Int32)\" do\n    it \"{}\" do\n\
    \      MS{3, 1, 4, 1, 5}.to_a.should eq [1, 1, 3, 4, 5]\n    end\n\n    it \"\
    #root\" do\n      s = MS(Int32).new\n      s.root.nil_node?.should be_true\n \
    \   end\n\n    it \"#size\" do\n      s = MS(Int32).new\n      s.size.should eq\
    \ 0\n      s.add 1\n      s.size.should eq 1\n      s.add 1\n      s.size.should\
    \ eq 2\n      s.delete 1\n      s.size.should eq 1\n    end\n\n    it \"#empty?\"\
    \ do\n      s = MS(Int32).new\n      s.empty?.should be_true\n      s.add 1\n\
    \      s.empty?.should be_false\n    end\n\n    it \"#clear\" do\n      s = MS(Int32).new\n\
    \      s.add 1\n      s.clear.size.should eq 0\n    end\n\n    it \"#add?\" do\n\
    \      s = MS(Int32).new\n      s.add?(1).should be_true\n      s.add?(1).should\
    \ be_true\n      s.verify\n    end\n\n    it \"#add, #<<\" do\n      s = MS(Int32).new\n\
    \      s.add(1).add(2).add(1)\n      s.size.should eq 3\n      s << 3 << 4 <<\
    \ 3\n      s.size.should eq 6\n      s.verify\n    end\n\n    it \"#min_node,\
    \ #max_node\" do\n      s = MS(Int32).new\n      s.min_node.nil_node?.should be_true\n\
    \      s.max_node.nil_node?.should be_true\n      s << 1 << 2\n      s.min_node.key?.should\
    \ eq 1\n      s.max_node.key?.should eq 2\n    end\n\n    it \"#min?, #min, #max?,\
    \ #max\" do\n      s = MS(Int32).new\n      s.min?.should be_nil\n      s.max?.should\
    \ be_nil\n      expect_raises(MS::EmptyError) { s.min }\n      expect_raises(MS::EmptyError)\
    \ { s.max }\n      s << 1 << 2\n      s.min?.should eq 1\n      s.max?.should\
    \ eq 2\n      s.min.should eq 1\n      s.max.should eq 2\n    end\n\n    it \"\
    #split\" do\n      1000.times do\n        s = MS(Int32).new(1..10)\n        l,\
    \ r = s.split(5)\n        l.to_a.should eq [1, 2, 3, 4, 5]\n        r.to_a.should\
    \ eq [6, 7, 8, 9, 10]\n        s.verify\n      end\n      10.times do\n      \
    \  s = MS(Int32).new(1..1000)\n        l, r = s.split(500)\n        l.to_a.should\
    \ eq (1..500).to_a\n        r.to_a.should eq (501..1000).to_a\n        s.verify\n\
    \      end\n    end\n\n    it \"#each\" do\n      s = MS{3, 1, 4, 1, 5}\n    \
    \  a = [] of Int32\n      s.each { |x| a << x }\n      a.should eq [1, 1, 3, 4,\
    \ 5]\n    end\n\n    it \"#reverse_each\" do\n      s = MS{3, 1, 4, 1, 5}\n  \
    \    a = [] of Int32\n      s.reverse_each { |x| a << x }\n      a.should eq [5,\
    \ 4, 3, 1, 1]\n    end\n\n    it \"#includes?\" do\n      s = MS{1, 3, 3, 5}\n\
    \      {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n      {0, 2, 4}.each\
    \ { |x| s.includes?(x).should be_false }\n    end\n\n    it \"#search\" do\n \
    \     s = MS{1, 3, 3, 5}\n      {1, 3, 5}.each { |x| s.search(x).key?.should eq\
    \ x }\n      {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n   \
    \ end\n\n    it \"#le, #le!, #le_node\" do\n      s = MS{1, 3}\n      [nil, 1,\
    \ 1, 3, 3].each_with_index { |e, x| s.le(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.le!(0) }\n      [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should\
    \ eq e }\n\n      s = MS{1, 1, 3}\n      s.le_node(0).nil_node?.should be_true\n\
    \      s.le_node(1).should eq s.min_node.succ\n      s.le_node(2).should eq s.min_node.succ\n\
    \      s.le_node(3).should eq s.max_node\n      s.le_node(4).should eq s.max_node\n\
    \    end\n\n    it \"#lt, #lt!, #lt_node\" do\n      s = MS{1, 3}\n      [nil,\
    \ nil, 1, 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n      expect_raises(NilAssertionError) { s.lt!(1) }\n      [1,\
    \ 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n\n      s = MS{1,\
    \ 1, 3}\n      s.lt_node(0).nil_node?.should be_true\n      s.lt_node(1).nil_node?.should\
    \ be_true\n      s.lt_node(2).should eq s.min_node.succ\n      s.lt_node(3).should\
    \ eq s.min_node.succ\n      s.lt_node(4).should eq s.max_node\n    end\n\n   \
    \ it \"#ge, #ge!, #ge_node\" do\n      s = MS{1, 3}\n      [1, 1, 3, 3, nil].each_with_index\
    \ { |e, x| s.ge(x).should eq e }\n      expect_raises(NilAssertionError) { s.ge!(4)\
    \ }\n      [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n\n  \
    \    s = MS{1, 1, 3}\n      s.ge_node(0).should eq s.min_node\n      s.ge_node(1).should\
    \ eq s.min_node\n      s.ge_node(2).should eq s.max_node\n      s.ge_node(3).should\
    \ eq s.max_node\n      s.ge_node(4).nil_node?.should be_true\n    end\n\n    it\
    \ \"#gt, #gt!, #gt_node\" do\n      s = MS{1, 3}\n      [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n      expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n      expect_raises(NilAssertionError) { s.gt!(4) }\n      [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n\n      s = MS{1, 1, 3}\n      s.gt_node(0).should\
    \ eq s.min_node\n      s.gt_node(1).should eq s.max_node\n      s.gt_node(2).should\
    \ eq s.max_node\n      s.gt_node(3).nil_node?.should be_true\n    end\n\n    it\
    \ \"#to_s, #inspect\" do\n      s = MS{1, 2, 3, 4}\n      s.to_s.should eq \"\
    #{class_name}{1, 2, 3, 4}\"\n      s.inspect.should eq \"#{class_name}{1, 2, 3,\
    \ 4}\"\n    end\n\n    it \"big\" do\n      n = 10**4\n      s = MS(Int32).new\n\
    \      (1..n).each do |x|\n        s << x\n        s.size.should eq x\n      \
    \  s.min.should eq 1\n        s.max.should eq x\n        s.verify\n      end\n\
    \      s.to_a.should eq (1..n).to_a\n      (-n..n*2).each do |x|\n        s.includes?(x).should\
    \ (1 <= x <= n ? be_true : be_false)\n      end\n      (1..n).each do |x|\n  \
    \      s.delete(x).should be_true\n        s.delete(x).should be_false\n     \
    \ end\n    end\n  end\n\n  it class_name + \"(String)\" do\n    MS{\"a\", \"c\"\
    , \"b\"}.to_a.should eq %w[a b c]\n    MS{\"a\", \"ab\", \"abc\", \"abc\"}.to_a.should\
    \ eq %w[a ab abc abc]\n  end\nend\n"
  code: "require \"spec\"\n\ndef run_smultiset_spec(type : MS.class, class_name :\
    \ String) forall MS\n  describe class_name + \"(Int32)\" do\n    it \"{}\" do\n\
    \      MS{3, 1, 4, 1, 5}.to_a.should eq [1, 1, 3, 4, 5]\n    end\n\n    it \"\
    #root\" do\n      s = MS(Int32).new\n      s.root.nil_node?.should be_true\n \
    \   end\n\n    it \"#size\" do\n      s = MS(Int32).new\n      s.size.should eq\
    \ 0\n      s.add 1\n      s.size.should eq 1\n      s.add 1\n      s.size.should\
    \ eq 2\n      s.delete 1\n      s.size.should eq 1\n    end\n\n    it \"#empty?\"\
    \ do\n      s = MS(Int32).new\n      s.empty?.should be_true\n      s.add 1\n\
    \      s.empty?.should be_false\n    end\n\n    it \"#clear\" do\n      s = MS(Int32).new\n\
    \      s.add 1\n      s.clear.size.should eq 0\n    end\n\n    it \"#add?\" do\n\
    \      s = MS(Int32).new\n      s.add?(1).should be_true\n      s.add?(1).should\
    \ be_true\n      s.verify\n    end\n\n    it \"#add, #<<\" do\n      s = MS(Int32).new\n\
    \      s.add(1).add(2).add(1)\n      s.size.should eq 3\n      s << 3 << 4 <<\
    \ 3\n      s.size.should eq 6\n      s.verify\n    end\n\n    it \"#min_node,\
    \ #max_node\" do\n      s = MS(Int32).new\n      s.min_node.nil_node?.should be_true\n\
    \      s.max_node.nil_node?.should be_true\n      s << 1 << 2\n      s.min_node.key?.should\
    \ eq 1\n      s.max_node.key?.should eq 2\n    end\n\n    it \"#min?, #min, #max?,\
    \ #max\" do\n      s = MS(Int32).new\n      s.min?.should be_nil\n      s.max?.should\
    \ be_nil\n      expect_raises(MS::EmptyError) { s.min }\n      expect_raises(MS::EmptyError)\
    \ { s.max }\n      s << 1 << 2\n      s.min?.should eq 1\n      s.max?.should\
    \ eq 2\n      s.min.should eq 1\n      s.max.should eq 2\n    end\n\n    it \"\
    #split\" do\n      1000.times do\n        s = MS(Int32).new(1..10)\n        l,\
    \ r = s.split(5)\n        l.to_a.should eq [1, 2, 3, 4, 5]\n        r.to_a.should\
    \ eq [6, 7, 8, 9, 10]\n        s.verify\n      end\n      10.times do\n      \
    \  s = MS(Int32).new(1..1000)\n        l, r = s.split(500)\n        l.to_a.should\
    \ eq (1..500).to_a\n        r.to_a.should eq (501..1000).to_a\n        s.verify\n\
    \      end\n    end\n\n    it \"#each\" do\n      s = MS{3, 1, 4, 1, 5}\n    \
    \  a = [] of Int32\n      s.each { |x| a << x }\n      a.should eq [1, 1, 3, 4,\
    \ 5]\n    end\n\n    it \"#reverse_each\" do\n      s = MS{3, 1, 4, 1, 5}\n  \
    \    a = [] of Int32\n      s.reverse_each { |x| a << x }\n      a.should eq [5,\
    \ 4, 3, 1, 1]\n    end\n\n    it \"#includes?\" do\n      s = MS{1, 3, 3, 5}\n\
    \      {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n      {0, 2, 4}.each\
    \ { |x| s.includes?(x).should be_false }\n    end\n\n    it \"#search\" do\n \
    \     s = MS{1, 3, 3, 5}\n      {1, 3, 5}.each { |x| s.search(x).key?.should eq\
    \ x }\n      {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n   \
    \ end\n\n    it \"#le, #le!, #le_node\" do\n      s = MS{1, 3}\n      [nil, 1,\
    \ 1, 3, 3].each_with_index { |e, x| s.le(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.le!(0) }\n      [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should\
    \ eq e }\n\n      s = MS{1, 1, 3}\n      s.le_node(0).nil_node?.should be_true\n\
    \      s.le_node(1).should eq s.min_node.succ\n      s.le_node(2).should eq s.min_node.succ\n\
    \      s.le_node(3).should eq s.max_node\n      s.le_node(4).should eq s.max_node\n\
    \    end\n\n    it \"#lt, #lt!, #lt_node\" do\n      s = MS{1, 3}\n      [nil,\
    \ nil, 1, 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n      expect_raises(NilAssertionError) { s.lt!(1) }\n      [1,\
    \ 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n\n      s = MS{1,\
    \ 1, 3}\n      s.lt_node(0).nil_node?.should be_true\n      s.lt_node(1).nil_node?.should\
    \ be_true\n      s.lt_node(2).should eq s.min_node.succ\n      s.lt_node(3).should\
    \ eq s.min_node.succ\n      s.lt_node(4).should eq s.max_node\n    end\n\n   \
    \ it \"#ge, #ge!, #ge_node\" do\n      s = MS{1, 3}\n      [1, 1, 3, 3, nil].each_with_index\
    \ { |e, x| s.ge(x).should eq e }\n      expect_raises(NilAssertionError) { s.ge!(4)\
    \ }\n      [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n\n  \
    \    s = MS{1, 1, 3}\n      s.ge_node(0).should eq s.min_node\n      s.ge_node(1).should\
    \ eq s.min_node\n      s.ge_node(2).should eq s.max_node\n      s.ge_node(3).should\
    \ eq s.max_node\n      s.ge_node(4).nil_node?.should be_true\n    end\n\n    it\
    \ \"#gt, #gt!, #gt_node\" do\n      s = MS{1, 3}\n      [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n      expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n      expect_raises(NilAssertionError) { s.gt!(4) }\n      [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n\n      s = MS{1, 1, 3}\n      s.gt_node(0).should\
    \ eq s.min_node\n      s.gt_node(1).should eq s.max_node\n      s.gt_node(2).should\
    \ eq s.max_node\n      s.gt_node(3).nil_node?.should be_true\n    end\n\n    it\
    \ \"#to_s, #inspect\" do\n      s = MS{1, 2, 3, 4}\n      s.to_s.should eq \"\
    #{class_name}{1, 2, 3, 4}\"\n      s.inspect.should eq \"#{class_name}{1, 2, 3,\
    \ 4}\"\n    end\n\n    it \"big\" do\n      n = 10**4\n      s = MS(Int32).new\n\
    \      (1..n).each do |x|\n        s << x\n        s.size.should eq x\n      \
    \  s.min.should eq 1\n        s.max.should eq x\n        s.verify\n      end\n\
    \      s.to_a.should eq (1..n).to_a\n      (-n..n*2).each do |x|\n        s.includes?(x).should\
    \ (1 <= x <= n ? be_true : be_false)\n      end\n      (1..n).each do |x|\n  \
    \      s.delete(x).should be_true\n        s.delete(x).should be_false\n     \
    \ end\n    end\n  end\n\n  it class_name + \"(String)\" do\n    MS{\"a\", \"c\"\
    , \"b\"}.to_a.should eq %w[a b c]\n    MS{\"a\", \"ab\", \"abc\", \"abc\"}.to_a.should\
    \ eq %w[a ab abc abc]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: spec/datastructure/smultiset/spec_helper.cr
  requiredBy:
  - spec/datastructure/smultiset/treap_spec.cr
  - spec/datastructure/smultiset/red_black_tree_spec.cr
  timestamp: '2021-09-21 18:31:20+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/smultiset/spec_helper.cr
layout: document
redirect_from:
- /library/spec/datastructure/smultiset/spec_helper.cr
- /library/spec/datastructure/smultiset/spec_helper.cr.html
title: spec/datastructure/smultiset/spec_helper.cr
---
