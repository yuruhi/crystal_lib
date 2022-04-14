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
  bundledCode: "struct Tuple\n  macro method_missing(call)\n\t\t{% str = call.stringify\
    \ %}\n\t\t{% if str =~ /_\\d+/ %}\n\t\t  self[{{ str[1...str.size].id }}]\n\t\t\
    {% else %}\n\t\t\t{% raise call %}\n\t\t{% end %}\n\tend\nend\n"
  code: "struct Tuple\n  macro method_missing(call)\n\t\t{% str = call.stringify %}\n\
    \t\t{% if str =~ /_\\d+/ %}\n\t\t  self[{{ str[1...str.size].id }}]\n\t\t{% else\
    \ %}\n\t\t\t{% raise call %}\n\t\t{% end %}\n\tend\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/tuple/get.cr
  requiredBy:
  - spec/tuple/get_spec.cr
  timestamp: '2022-04-14 18:17:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/tuple/get.cr
layout: document
redirect_from:
- /library/src/tuple/get.cr
- /library/src/tuple/get.cr.html
title: src/tuple/get.cr
---
