---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/tuple/get.cr
    title: src/tuple/get.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "require \"spec\"\n\n# require \"../../src/tuple/get\"\nstruct Tuple\n\
    \  macro method_missing(call)\n    {% str = call.stringify %}\n    {% if str =~\
    \ /_\\d+/ %}\n      self[{{ str[1...str.size].id }}]\n    {% else %}\n      {%\
    \ raise call %}\n    {% end %}\n  end\nend\n\ndescribe Tuple do\n  it \"#_N\"\
    \ do\n    a = {0}\n    a._0.should eq 0\n    b = {0, 1}\n    b._0.should eq 0\n\
    \    b._1.should eq 1\n    c = {0, 1, 2}\n    c._0.should eq 0\n    c._1.should\
    \ eq 1\n    c._2.should eq 2\n  end\nend\n"
  code: "require \"spec\"\nrequire \"../../src/tuple/get\"\n\ndescribe Tuple do\n\
    \  it \"#_N\" do\n    a = {0}\n    a._0.should eq 0\n    b = {0, 1}\n    b._0.should\
    \ eq 0\n    b._1.should eq 1\n    c = {0, 1, 2}\n    c._0.should eq 0\n    c._1.should\
    \ eq 1\n    c._2.should eq 2\n  end\nend\n"
  dependsOn:
  - src/tuple/get.cr
  isVerificationFile: false
  path: spec/tuple/get_spec.cr
  requiredBy: []
  timestamp: '2022-04-14 18:21:37+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: spec/tuple/get_spec.cr
layout: document
redirect_from:
- /library/spec/tuple/get_spec.cr
- /library/spec/tuple/get_spec.cr.html
title: spec/tuple/get_spec.cr
---
