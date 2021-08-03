---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/int/each_combination.test.cr
    title: test/int/each_combination.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "struct Int\n  private class CombinationIterator(T, U)\n    include\
    \ Iterator(T)\n\n    @combination : T\n\n    def initialize(@n : T, @k : U)\n\
    \      @combination = (T.new(1) << @k) - 1\n      @first = true\n    end\n\n \
    \   def next\n      if @first\n        @first = false\n        @combination\n\
    \      else\n        x = @combination & -@combination\n        y = @combination\
    \ + x\n        @combination = ((@combination & ~y) // x >> 1) | y\n        @combination\
    \ < (T.new(1) << @n) ? @combination : stop\n      end\n    end\n  end\n\n  def\
    \ each_combination(k : Int)\n    CombinationIterator.new(self, k)\n  end\n\n \
    \ def each_combination(k : Int, &) : Nil\n    combination = (self.class.new(1)\
    \ << k) - 1\n    while combination < (self.class.new(1) << self)\n      yield\
    \ combination\n      x = combination & (-combination)\n      y = combination +\
    \ x\n      combination = ((combination & ~y) // x >> 1) | y\n    end\n  end\n\
    end\n"
  code: "struct Int\n  private class CombinationIterator(T, U)\n    include Iterator(T)\n\
    \n    @combination : T\n\n    def initialize(@n : T, @k : U)\n      @combination\
    \ = (T.new(1) << @k) - 1\n      @first = true\n    end\n\n    def next\n     \
    \ if @first\n        @first = false\n        @combination\n      else\n      \
    \  x = @combination & -@combination\n        y = @combination + x\n        @combination\
    \ = ((@combination & ~y) // x >> 1) | y\n        @combination < (T.new(1) << @n)\
    \ ? @combination : stop\n      end\n    end\n  end\n\n  def each_combination(k\
    \ : Int)\n    CombinationIterator.new(self, k)\n  end\n\n  def each_combination(k\
    \ : Int, &) : Nil\n    combination = (self.class.new(1) << k) - 1\n    while combination\
    \ < (self.class.new(1) << self)\n      yield combination\n      x = combination\
    \ & (-combination)\n      y = combination + x\n      combination = ((combination\
    \ & ~y) // x >> 1) | y\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/int/each_combination.cr
  requiredBy: []
  timestamp: '2021-08-03 16:39:26+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/int/each_combination.test.cr
documentation_of: src/int/each_combination.cr
layout: document
redirect_from:
- /library/src/int/each_combination.cr
- /library/src/int/each_combination.cr.html
title: src/int/each_combination.cr
---
