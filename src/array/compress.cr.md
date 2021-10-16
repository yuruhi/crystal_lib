---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/array/compress_test.cr
    title: test/array/compress_test.cr
  - icon: ':heavy_check_mark:'
    path: test/dp/inversion_test.cr
    title: test/dp/inversion_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Array(T)\n  def compress(values : Array(T), *, index : Int =\
    \ 0)\n    map do |x|\n      index + values.bsearch_index { |y| y >= x }.not_nil!\n\
    \    end\n  end\n\n  def compress(*, index : Int = 0) : Array(Int32)\n    compress(uniq.sort!,\
    \ index: index)\n  end\nend\n"
  code: "class Array(T)\n  def compress(values : Array(T), *, index : Int = 0)\n \
    \   map do |x|\n      index + values.bsearch_index { |y| y >= x }.not_nil!\n \
    \   end\n  end\n\n  def compress(*, index : Int = 0) : Array(Int32)\n    compress(uniq.sort!,\
    \ index: index)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/array/compress.cr
  requiredBy: []
  timestamp: '2021-10-16 13:32:38+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/array/compress_test.cr
  - test/dp/inversion_test.cr
documentation_of: src/array/compress.cr
layout: document
redirect_from:
- /library/src/array/compress.cr
- /library/src/array/compress.cr.html
title: src/array/compress.cr
---