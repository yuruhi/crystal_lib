---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/datastructure/sset/red_black_tree_spec.cr
    title: spec/datastructure/sset/red_black_tree_spec.cr
  - icon: ':warning:'
    path: spec/datastructure/sset/treap_spec.cr
    title: spec/datastructure/sset/treap_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\ndef run_sset_spec(type : SSet.class, class_name\
    \ : String) forall SSet\n  describe class_name + \"(Int32)\" do\n    it \"{}\"\
    \ do\n      SSet{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]\n    end\n\n    it\
    \ \"#root\" do\n      s = SSet(Int32).new\n      s.root.nil_node?.should be_true\n\
    \    end\n\n    it \"#size\" do\n      s = SSet(Int32).new\n      s.size.should\
    \ eq 0\n      s.add 1\n      s.size.should eq 1\n      s.add 1\n      s.size.should\
    \ eq 1\n      s.delete 1\n      s.size.should eq 0\n    end\n\n    it \"#empty?\"\
    \ do\n      s = SSet(Int32).new\n      s.empty?.should be_true\n      s.add 1\n\
    \      s.empty?.should be_false\n    end\n\n    it \"#clear\" do\n      s = SSet(Int32).new\n\
    \      s.add 1\n      s.clear.size.should eq 0\n    end\n\n    it \"#add?\" do\n\
    \      s = SSet(Int32).new\n      s.add?(1).should be_true\n      s.add?(1).should\
    \ be_false\n      s.verify\n    end\n\n    it \"#add, #<<\" do\n      s = SSet(Int32).new\n\
    \      s.add(1).add(2).add(1)\n      s.size.should eq 2\n      s << 3 << 4 <<\
    \ 3\n      s.size.should eq 4\n      s.verify\n    end\n\n    it \"#min_node,\
    \ #max_node\" do\n      s = SSet(Int32).new\n      s.min_node.nil_node?.should\
    \ be_true\n      s.max_node.nil_node?.should be_true\n      s << 1 << 2\n    \
    \  s.min_node.key?.should eq 1\n      s.max_node.key?.should eq 2\n    end\n\n\
    \    it \"#min?, #min, #max?, #max\" do\n      s = SSet(Int32).new\n      s.min?.should\
    \ be_nil\n      s.max?.should be_nil\n      expect_raises(SSet::EmptyError) {\
    \ s.min }\n      expect_raises(SSet::EmptyError) { s.max }\n      s << 1 << 2\n\
    \      s.min?.should eq 1\n      s.max?.should eq 2\n      s.min.should eq 1\n\
    \      s.max.should eq 2\n    end\n\n    it \"#split\" do\n      1000.times do\n\
    \        s = SSet.new(1..10)\n        l, r = s.split(5)\n        l.to_a.should\
    \ eq [1, 2, 3, 4, 5]\n        r.to_a.should eq [6, 7, 8, 9, 10]\n        s.verify\n\
    \      end\n      10.times do\n        s = SSet.new(1..1000)\n        l, r = s.split(500)\n\
    \        l.to_a.should eq (1..500).to_a\n        r.to_a.should eq (501..1000).to_a\n\
    \        s.verify\n      end\n    end\n\n    it \"#each\" do\n      s = SSet{3,\
    \ 1, 4, 1, 5}\n\n      a = [] of Int32\n      s.each { |x| a << x }\n      a.should\
    \ eq [1, 3, 4, 5]\n\n      b = [] of Int32\n      s.each(s.search(3)) { |x| b\
    \ << x }\n      b.should eq [3, 4, 5]\n\n      s.each.to_a.should eq [1, 3, 4,\
    \ 5]\n      s.each(s.search(3)).to_a.should eq [3, 4, 5]\n    end\n\n    it \"\
    #reverse_each\" do\n      s = SSet{3, 1, 4, 1, 5}\n\n      a = [] of Int32\n \
    \     s.reverse_each { |x| a << x }\n      a.should eq [5, 4, 3, 1]\n\n      a\
    \ = [] of Int32\n      s.reverse_each(s.search(4)) { |x| a << x }\n      a.should\
    \ eq [4, 3, 1]\n\n      s.reverse_each.to_a.should eq [5, 4, 3, 1]\n      s.reverse_each(s.search(4)).to_a.should\
    \ eq [4, 3, 1]\n    end\n\n    it \"#includes?\" do\n      s = SSet{1, 3, 5}\n\
    \      {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n      {0, 2, 4}.each\
    \ { |x| s.includes?(x).should be_false }\n    end\n\n    it \"#search\" do\n \
    \     s = SSet{1, 3, 5}\n      {1, 3, 5}.each { |x| s.search(x).key?.should eq\
    \ x }\n      {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n   \
    \ end\n\n    it \"#le, #le!\" do\n      s = SSet{1, 3}\n      [nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.le(x).should eq e }\n      expect_raises(NilAssertionError) { s.le!(0)\
    \ }\n      [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }\n \
    \   end\n\n    it \"#lt, #lt!\" do\n      s = SSet{1, 3}\n      [nil, nil, 1,\
    \ 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n      expect_raises(NilAssertionError) { s.lt!(1) }\n      [1,\
    \ 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n    end\n\n   \
    \ it \"#ge, #ge!\" do\n      s = SSet{1, 3}\n      [1, 1, 3, 3, nil].each_with_index\
    \ { |e, x| s.ge(x).should eq e }\n      expect_raises(NilAssertionError) { s.ge!(4)\
    \ }\n      [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n    end\n\
    \n    it \"#gt, #gt!\" do\n      s = SSet{1, 3}\n      [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n      expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n      expect_raises(NilAssertionError) { s.gt!(4) }\n      [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n    end\n\n    it \"include Enumerable\" do\n\
    \      s = SSet{1, 2, 3, 4}\n      s.all? { |x| x > 0 }.should be_true\n    end\n\
    \n    it \"include Iterable\" do\n      s = SSet{1, 2, 3, 4}\n      s.cycle(2).to_a.should\
    \ eq [1, 2, 3, 4, 1, 2, 3, 4]\n    end\n\n    it \"#to_s, #inspect\" do\n    \
    \  s = SSet{1, 2, 3, 4}\n      s.to_s.should eq \"#{class_name}{1, 2, 3, 4}\"\n\
    \      s.inspect.should eq \"#{class_name}{1, 2, 3, 4}\"\n    end\n\n    it \"\
    big\" do\n      n = 10**4\n      s = SSet(Int32).new\n      (1..n).each do |x|\n\
    \        s << x\n        s.size.should eq x\n        s.min.should eq 1\n     \
    \   s.max.should eq x\n        s.verify\n      end\n      s.to_a.should eq (1..n).to_a\n\
    \      (-n..n*2).each do |x|\n        s.includes?(x).should (1 <= x <= n ? be_true\
    \ : be_false)\n      end\n      (1..n).each do |x|\n        s.delete(x).should\
    \ be_true\n        s.delete(x).should be_false\n      end\n    end\n  end\n\n\
    \  it class_name + \"(String)\" do\n    SSet{\"a\", \"c\", \"b\"}.to_a.should\
    \ eq %w[a b c]\n    SSet{\"a\", \"ab\", \"abc\", \"abc\"}.to_a.should eq %w[a\
    \ ab abc]\n  end\nend\n"
  code: "require \"spec\"\n\ndef run_sset_spec(type : SSet.class, class_name : String)\
    \ forall SSet\n  describe class_name + \"(Int32)\" do\n    it \"{}\" do\n    \
    \  SSet{3, 1, 4, 1, 5}.to_a.should eq [1, 3, 4, 5]\n    end\n\n    it \"#root\"\
    \ do\n      s = SSet(Int32).new\n      s.root.nil_node?.should be_true\n    end\n\
    \n    it \"#size\" do\n      s = SSet(Int32).new\n      s.size.should eq 0\n \
    \     s.add 1\n      s.size.should eq 1\n      s.add 1\n      s.size.should eq\
    \ 1\n      s.delete 1\n      s.size.should eq 0\n    end\n\n    it \"#empty?\"\
    \ do\n      s = SSet(Int32).new\n      s.empty?.should be_true\n      s.add 1\n\
    \      s.empty?.should be_false\n    end\n\n    it \"#clear\" do\n      s = SSet(Int32).new\n\
    \      s.add 1\n      s.clear.size.should eq 0\n    end\n\n    it \"#add?\" do\n\
    \      s = SSet(Int32).new\n      s.add?(1).should be_true\n      s.add?(1).should\
    \ be_false\n      s.verify\n    end\n\n    it \"#add, #<<\" do\n      s = SSet(Int32).new\n\
    \      s.add(1).add(2).add(1)\n      s.size.should eq 2\n      s << 3 << 4 <<\
    \ 3\n      s.size.should eq 4\n      s.verify\n    end\n\n    it \"#min_node,\
    \ #max_node\" do\n      s = SSet(Int32).new\n      s.min_node.nil_node?.should\
    \ be_true\n      s.max_node.nil_node?.should be_true\n      s << 1 << 2\n    \
    \  s.min_node.key?.should eq 1\n      s.max_node.key?.should eq 2\n    end\n\n\
    \    it \"#min?, #min, #max?, #max\" do\n      s = SSet(Int32).new\n      s.min?.should\
    \ be_nil\n      s.max?.should be_nil\n      expect_raises(SSet::EmptyError) {\
    \ s.min }\n      expect_raises(SSet::EmptyError) { s.max }\n      s << 1 << 2\n\
    \      s.min?.should eq 1\n      s.max?.should eq 2\n      s.min.should eq 1\n\
    \      s.max.should eq 2\n    end\n\n    it \"#split\" do\n      1000.times do\n\
    \        s = SSet.new(1..10)\n        l, r = s.split(5)\n        l.to_a.should\
    \ eq [1, 2, 3, 4, 5]\n        r.to_a.should eq [6, 7, 8, 9, 10]\n        s.verify\n\
    \      end\n      10.times do\n        s = SSet.new(1..1000)\n        l, r = s.split(500)\n\
    \        l.to_a.should eq (1..500).to_a\n        r.to_a.should eq (501..1000).to_a\n\
    \        s.verify\n      end\n    end\n\n    it \"#each\" do\n      s = SSet{3,\
    \ 1, 4, 1, 5}\n\n      a = [] of Int32\n      s.each { |x| a << x }\n      a.should\
    \ eq [1, 3, 4, 5]\n\n      b = [] of Int32\n      s.each(s.search(3)) { |x| b\
    \ << x }\n      b.should eq [3, 4, 5]\n\n      s.each.to_a.should eq [1, 3, 4,\
    \ 5]\n      s.each(s.search(3)).to_a.should eq [3, 4, 5]\n    end\n\n    it \"\
    #reverse_each\" do\n      s = SSet{3, 1, 4, 1, 5}\n\n      a = [] of Int32\n \
    \     s.reverse_each { |x| a << x }\n      a.should eq [5, 4, 3, 1]\n\n      a\
    \ = [] of Int32\n      s.reverse_each(s.search(4)) { |x| a << x }\n      a.should\
    \ eq [4, 3, 1]\n\n      s.reverse_each.to_a.should eq [5, 4, 3, 1]\n      s.reverse_each(s.search(4)).to_a.should\
    \ eq [4, 3, 1]\n    end\n\n    it \"#includes?\" do\n      s = SSet{1, 3, 5}\n\
    \      {1, 3, 5}.each { |x| s.includes?(x).should be_true }\n      {0, 2, 4}.each\
    \ { |x| s.includes?(x).should be_false }\n    end\n\n    it \"#search\" do\n \
    \     s = SSet{1, 3, 5}\n      {1, 3, 5}.each { |x| s.search(x).key?.should eq\
    \ x }\n      {0, 2, 4}.each { |x| s.search(x).nil_node?.should be_true }\n   \
    \ end\n\n    it \"#le, #le!\" do\n      s = SSet{1, 3}\n      [nil, 1, 1, 3, 3].each_with_index\
    \ { |e, x| s.le(x).should eq e }\n      expect_raises(NilAssertionError) { s.le!(0)\
    \ }\n      [1, 1, 3, 3].each_with_index(1) { |e, x| s.le!(x).should eq e }\n \
    \   end\n\n    it \"#lt, #lt!\" do\n      s = SSet{1, 3}\n      [nil, nil, 1,\
    \ 1, 3, 3].each_with_index { |e, x| s.lt(x).should eq e }\n      expect_raises(NilAssertionError)\
    \ { s.lt!(0) }\n      expect_raises(NilAssertionError) { s.lt!(1) }\n      [1,\
    \ 1, 3, 3].each_with_index(2) { |e, x| s.lt!(x).should eq e }\n    end\n\n   \
    \ it \"#ge, #ge!\" do\n      s = SSet{1, 3}\n      [1, 1, 3, 3, nil].each_with_index\
    \ { |e, x| s.ge(x).should eq e }\n      expect_raises(NilAssertionError) { s.ge!(4)\
    \ }\n      [1, 1, 3, 3].each_with_index { |e, x| s.ge!(x).should eq e }\n    end\n\
    \n    it \"#gt, #gt!\" do\n      s = SSet{1, 3}\n      [1, 3, 3, nil, nil].each_with_index\
    \ { |e, x| s.gt(x).should eq e }\n      expect_raises(NilAssertionError) { s.gt!(3)\
    \ }\n      expect_raises(NilAssertionError) { s.gt!(4) }\n      [1, 3, 3].each_with_index\
    \ { |e, x| s.gt!(x).should eq e }\n    end\n\n    it \"include Enumerable\" do\n\
    \      s = SSet{1, 2, 3, 4}\n      s.all? { |x| x > 0 }.should be_true\n    end\n\
    \n    it \"include Iterable\" do\n      s = SSet{1, 2, 3, 4}\n      s.cycle(2).to_a.should\
    \ eq [1, 2, 3, 4, 1, 2, 3, 4]\n    end\n\n    it \"#to_s, #inspect\" do\n    \
    \  s = SSet{1, 2, 3, 4}\n      s.to_s.should eq \"#{class_name}{1, 2, 3, 4}\"\n\
    \      s.inspect.should eq \"#{class_name}{1, 2, 3, 4}\"\n    end\n\n    it \"\
    big\" do\n      n = 10**4\n      s = SSet(Int32).new\n      (1..n).each do |x|\n\
    \        s << x\n        s.size.should eq x\n        s.min.should eq 1\n     \
    \   s.max.should eq x\n        s.verify\n      end\n      s.to_a.should eq (1..n).to_a\n\
    \      (-n..n*2).each do |x|\n        s.includes?(x).should (1 <= x <= n ? be_true\
    \ : be_false)\n      end\n      (1..n).each do |x|\n        s.delete(x).should\
    \ be_true\n        s.delete(x).should be_false\n      end\n    end\n  end\n\n\
    \  it class_name + \"(String)\" do\n    SSet{\"a\", \"c\", \"b\"}.to_a.should\
    \ eq %w[a b c]\n    SSet{\"a\", \"ab\", \"abc\", \"abc\"}.to_a.should eq %w[a\
    \ ab abc]\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: spec/datastructure/sset/spec_helper.cr
  requiredBy:
  - spec/datastructure/sset/treap_spec.cr
  - spec/datastructure/sset/red_black_tree_spec.cr
  timestamp: '2021-10-11 18:45:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/datastructure/sset/spec_helper.cr
layout: document
redirect_from:
- /library/spec/datastructure/sset/spec_helper.cr
- /library/spec/datastructure/sset/spec_helper.cr.html
title: spec/datastructure/sset/spec_helper.cr
---
