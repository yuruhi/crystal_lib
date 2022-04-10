---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/collection/tally_spec.cr
    title: spec/collection/tally_spec.cr
  - icon: ':warning:'
    path: src/template.cr
    title: src/template.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "module Enumerable(T)\n  def tally(*, default : Int32) : Hash(T, Int32)\n\
    \    each_with_object(Hash(T, Int32).new default) do |value, hash|\n      hash[value]\
    \ += 1\n    end\n  end\nend\n"
  code: "module Enumerable(T)\n  def tally(*, default : Int32) : Hash(T, Int32)\n\
    \    each_with_object(Hash(T, Int32).new default) do |value, hash|\n      hash[value]\
    \ += 1\n    end\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/collection/tally.cr
  requiredBy:
  - spec/collection/tally_spec.cr
  - src/template.cr
  timestamp: '2022-04-10 01:35:43+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/collection/tally.cr
layout: document
redirect_from:
- /library/src/collection/tally.cr
- /library/src/collection/tally.cr.html
title: src/collection/tally.cr
---
