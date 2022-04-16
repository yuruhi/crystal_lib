---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/tuple/get_spec.cr
    title: spec/tuple/get_spec.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "struct Tuple\n  macro method_missing(call)\n    {% str = call.stringify\
    \ %}\n    {% if str =~ /_\\d+/ %}\n      self[{{ str[1...str.size].id }}]\n  \
    \  {% else %}\n      {% raise call %}\n    {% end %}\n  end\nend\n"
  code: "struct Tuple\n  macro method_missing(call)\n    {% str = call.stringify %}\n\
    \    {% if str =~ /_\\d+/ %}\n      self[{{ str[1...str.size].id }}]\n    {% else\
    \ %}\n      {% raise call %}\n    {% end %}\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/tuple/get.cr
  requiredBy:
  - spec/tuple/get_spec.cr
  timestamp: '2022-04-16 07:49:21+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/tuple/get.cr
layout: document
redirect_from:
- /library/src/tuple/get.cr
- /library/src/tuple/get.cr.html
title: src/tuple/get.cr
---
