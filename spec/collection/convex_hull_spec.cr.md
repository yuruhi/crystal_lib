---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/collection/convex_hull.cr
    title: src/collection/convex_hull.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/collection/convex_hull\"\
    \nclass Array(T)\n  private def compare_slope(p1, p2, q1, q2)\n    (p2[0] - p1[0])\
    \ * (q2[1] - q1[1]) > (q2[0] - q1[0]) * (p2[1] - p1[1])\n  end\n\n  # Returns\
    \ convex hull of points that consist of `(value, index)`.\n  #\n  # ```\n  # [4,\
    \ 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull_with_index # => [{4, 0}, {2, 1}, {1,\
    \ 4}, {1, 6}, {2, 8}, {4, 9}]\n  # ```\n  #\n  # ```palin\n  #   | 0 1 2 3 4 5\
    \ 6 7 8 9\n  # --+---------------------\n  # 4 | o     x           o\n  # 3 |\
    \     x         x\n  # 2 |   o       x     o\n  # 1 |         o   o\n  # ```\n\
    \  def convex_hull_with_index : Array({T, Int32})\n    res = [] of {T, Int32}\n\
    \    each_with_index do |x, i|\n      while res.size >= 2 && compare_slope(res[-2],\
    \ res[-1], res[-2], {x, i})\n        res.pop\n      end\n      res << {x, i}\n\
    \    end\n    res\n  end\n\n  # Returns convex hull of points that consist of\
    \ `(value, index)`.\n  #\n  # ```\n  # [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull\
    \ # => [4, 2, 1, 1, 2, 4]\n  # ```\n  #\n  # ```palin\n  #   | 0 1 2 3 4 5 6 7\
    \ 8 9\n  # --+---------------------\n  # 4 | o     x           o\n  # 3 |    \
    \ x         x\n  # 2 |   o       x     o\n  # 1 |         o   o\n  # ```\n  def\
    \ convex_hull : Array(Int32)\n    convex_hull_with_index.map(&.[0])\n  end\nend\n\
    \ndescribe Array do\n  it \"#convex_hull\" do\n    [4, 2, 3, 4, 1, 2, 1, 3, 2,\
    \ 4].convex_hull.should eq [4, 2, 1, 1, 2, 4]\n  end\n\n  it \"#convex_hull_with_index\"\
    \ do\n    [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull_with_index.should eq [{4,\
    \ 0}, {2, 1}, {1, 4}, {1, 6}, {2, 8}, {4, 9}]\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/collection/convex_hull\"\n\ndescribe\
    \ Array do\n  it \"#convex_hull\" do\n    [4, 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull.should\
    \ eq [4, 2, 1, 1, 2, 4]\n  end\n\n  it \"#convex_hull_with_index\" do\n    [4,\
    \ 2, 3, 4, 1, 2, 1, 3, 2, 4].convex_hull_with_index.should eq [{4, 0}, {2, 1},\
    \ {1, 4}, {1, 6}, {2, 8}, {4, 9}]\n  end\nend\n"
  dependsOn:
  - src/collection/convex_hull.cr
  isVerificationFile: false
  path: spec/collection/convex_hull_spec.cr
  requiredBy: []
  timestamp: '2022-03-25 20:24:40+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/collection/convex_hull_spec.cr
layout: document
redirect_from:
- /library/spec/collection/convex_hull_spec.cr
- /library/spec/collection/convex_hull_spec.cr.html
title: spec/collection/convex_hull_spec.cr
---
