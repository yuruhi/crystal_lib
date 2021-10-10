---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: test/math/ntt_test.cr
    title: test/math/ntt_test.cr
  _isVerificationFailed: true
  _pathExtension: cr
  _verificationStatusIcon: ':x:'
  attributes: {}
  bundledCode: "# reference : https://kopricky.github.io/code/FFTs/ntt.html\nclass\
    \ NTT\n  ROOT = 3\n\n  private def self.ntt(a : Array(T), rev = false) forall\
    \ T\n    return a if a.size == 1\n    b = Array.new(a.size, T.zero)\n    r = T::MOD.pred\
    \ // a.size\n    r = T::MOD.pred - r if rev\n    s = T.new(ROOT) ** r\n    kp\
    \ = Array.new(a.size // 2 + 1, T.new(1))\n    (1...kp.size).each { |i| kp[i] =\
    \ kp[i - 1] * s }\n\n    i, l = 1, a.size // 2\n    while i < a.size\n      r\
    \ = 0\n      (0...l).each do |j|\n        s = kp[i * j]\n        (0...i).each\
    \ do |k|\n          p, q = a[k + r], a[k + r + a.size // 2]\n          b[k + 2\
    \ * r] = p + q\n          b[k + 2 * r + i] = (p - q) * s\n        end\n      \
    \  r += i\n      end\n      a, b = b, a\n      i <<= 1; l >>= 1\n    end\n   \
    \ if rev\n      s = T.new(a.size).inv\n      a.map! { |x| x * s }\n    end\n \
    \   a\n  end\n\n  def self.convolution(a : Array(T), b : Array(T)) forall T\n\
    \    size = a.size + b.size - 1\n    t = Math.pw2ceil(size)\n    aa = a + Array.new(t\
    \ - a.size, T.zero)\n    bb = b + Array.new(t - b.size, T.zero)\n    c = ntt(aa).zip(ntt(bb)).map\
    \ { |x, y| x * y }\n    ntt(c, true).first(size)\n  end\nend\n"
  code: "# reference : https://kopricky.github.io/code/FFTs/ntt.html\nclass NTT\n\
    \  ROOT = 3\n\n  private def self.ntt(a : Array(T), rev = false) forall T\n  \
    \  return a if a.size == 1\n    b = Array.new(a.size, T.zero)\n    r = T::MOD.pred\
    \ // a.size\n    r = T::MOD.pred - r if rev\n    s = T.new(ROOT) ** r\n    kp\
    \ = Array.new(a.size // 2 + 1, T.new(1))\n    (1...kp.size).each { |i| kp[i] =\
    \ kp[i - 1] * s }\n\n    i, l = 1, a.size // 2\n    while i < a.size\n      r\
    \ = 0\n      (0...l).each do |j|\n        s = kp[i * j]\n        (0...i).each\
    \ do |k|\n          p, q = a[k + r], a[k + r + a.size // 2]\n          b[k + 2\
    \ * r] = p + q\n          b[k + 2 * r + i] = (p - q) * s\n        end\n      \
    \  r += i\n      end\n      a, b = b, a\n      i <<= 1; l >>= 1\n    end\n   \
    \ if rev\n      s = T.new(a.size).inv\n      a.map! { |x| x * s }\n    end\n \
    \   a\n  end\n\n  def self.convolution(a : Array(T), b : Array(T)) forall T\n\
    \    size = a.size + b.size - 1\n    t = Math.pw2ceil(size)\n    aa = a + Array.new(t\
    \ - a.size, T.zero)\n    bb = b + Array.new(t - b.size, T.zero)\n    c = ntt(aa).zip(ntt(bb)).map\
    \ { |x, y| x * y }\n    ntt(c, true).first(size)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/ntt.cr
  requiredBy: []
  timestamp: '2021-10-10 09:12:20+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - test/math/ntt_test.cr
documentation_of: src/math/ntt.cr
layout: document
redirect_from:
- /library/src/math/ntt.cr
- /library/src/math/ntt.cr.html
title: src/math/ntt.cr
---
