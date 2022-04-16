---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/compress_spec.cr
    title: spec/collection/compress_spec.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/collection/compress_test.cr
    title: test/collection/compress_test.cr
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
  path: src/collection/compress.cr
  requiredBy:
  - spec/collection/compress_spec.cr
  timestamp: '2022-04-16 07:49:21+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/dp/inversion_test.cr
  - test/collection/compress_test.cr
documentation_of: src/collection/compress.cr
layout: document
redirect_from:
- /library/src/collection/compress.cr
- /library/src/collection/compress.cr.html
title: src/collection/compress.cr
---
