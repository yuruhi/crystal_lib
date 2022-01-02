---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#                     _______________[57]_______________\n#      \
    \              /                                  \\\n#         ________[33]________\
    \                       ___[77]___\n#        /                    \\         \
    \            /          \\\n#    _[14]_                  _[42]_              [62]\
    \          [82]\n#   /      \\                /      \\            /    \\   \
    \          \\\n# [6]      [22]          [35]      [52]      [61]    [67]     \
    \     [84]\n#         /    \\        /    \\         \\                 \\\n#\
    \      [15]    [22]  [34]    [38]      [55]              [75]\nclass AsciiBinaryTree(Node)\n\
    \  private def self.dfs(root : Node) : {Array(Array(Char)), Range(Int32, Int32)}\n\
    \    if root.nil_node?\n      return {Array(Array(Char)).new, 0..0}\n    elsif\
    \ root.left.nil_node? && root.right.nil_node?\n      top = root.to_s.chars\n \
    \     return {[top], 0..top.size - 1}\n    end\n\n    left, range_l = dfs(root.left)\n\
    \    width_l = left.empty? ? 0 : left.first.size\n    unless left.empty?\n   \
    \   edge = [' '] * width_l\n      edge[range_l.end] = '/'\n      left.unshift\
    \ edge\n    end\n\n    right, range_r = dfs(root.right)\n    width_r = right.empty?\
    \ ? 0 : right.first.size\n    unless right.empty?\n      edge = [' '] * width_r\n\
    \      edge[range_r.begin] = '\\\\'\n      right.unshift edge\n    end\n\n   \
    \ top_str = root.to_s.chars\n    width, gap, top_space_l, top_under =\n      if\
    \ right.empty?\n        width = Math.max(width_l, range_l.end + top_str.size +\
    \ 1)\n        {width, width - width_l, range_l.end + 1, 0}\n      elsif left.empty?\n\
    \        gap = Math.max(0, top_str.size - range_r.begin)\n        top_space_l\
    \ = Math.max(0, range_r.begin - top_str.size)\n        {width_r + gap, gap, top_space_l,\
    \ 0}\n      else\n        gap = 1\n        space = (width_l - range_l.end - 1)\
    \ + gap + (range_r.begin)\n        tuple =\n          if space < top_str.size\n\
    \            gap += top_str.size - space\n            {range_l.end + 1, 0}\n \
    \         else\n            if (space - top_str.size).odd?\n              space\
    \ += 1\n              gap += 1\n            end\n            under = (space -\
    \ top_str.size) // 2\n            {range_l.end + 1, under}\n          end\n  \
    \      {width_l + gap + width_r, gap} + tuple\n      end\n\n    top_space_r =\
    \ width - top_space_l - top_under * 2 - top_str.size\n    top = [' '] * top_space_l\
    \ + ['_'] * top_under + top_str + ['_'] * top_under + [' '] * top_space_r\n\n\
    \    result = [top]\n    Math.max(left.size, right.size).times do |i|\n      result\
    \ << left.fetch(i) { [' '] * width_l } + [' '] * gap + right.fetch(i) { [' ']\
    \ * width_r }\n    end\n    now_l = top_space_l + top_under\n    now_r = now_l\
    \ + top_str.size - 1\n\n    {result, now_l..now_r}\n  end\n\n  def self.print(tree)\n\
    \    puts dfs(tree.root)[0].join('\\n', &.join)\n  end\nend\n"
  code: "#                     _______________[57]_______________\n#             \
    \       /                                  \\\n#         ________[33]________\
    \                       ___[77]___\n#        /                    \\         \
    \            /          \\\n#    _[14]_                  _[42]_              [62]\
    \          [82]\n#   /      \\                /      \\            /    \\   \
    \          \\\n# [6]      [22]          [35]      [52]      [61]    [67]     \
    \     [84]\n#         /    \\        /    \\         \\                 \\\n#\
    \      [15]    [22]  [34]    [38]      [55]              [75]\nclass AsciiBinaryTree(Node)\n\
    \  private def self.dfs(root : Node) : {Array(Array(Char)), Range(Int32, Int32)}\n\
    \    if root.nil_node?\n      return {Array(Array(Char)).new, 0..0}\n    elsif\
    \ root.left.nil_node? && root.right.nil_node?\n      top = root.to_s.chars\n \
    \     return {[top], 0..top.size - 1}\n    end\n\n    left, range_l = dfs(root.left)\n\
    \    width_l = left.empty? ? 0 : left.first.size\n    unless left.empty?\n   \
    \   edge = [' '] * width_l\n      edge[range_l.end] = '/'\n      left.unshift\
    \ edge\n    end\n\n    right, range_r = dfs(root.right)\n    width_r = right.empty?\
    \ ? 0 : right.first.size\n    unless right.empty?\n      edge = [' '] * width_r\n\
    \      edge[range_r.begin] = '\\\\'\n      right.unshift edge\n    end\n\n   \
    \ top_str = root.to_s.chars\n    width, gap, top_space_l, top_under =\n      if\
    \ right.empty?\n        width = Math.max(width_l, range_l.end + top_str.size +\
    \ 1)\n        {width, width - width_l, range_l.end + 1, 0}\n      elsif left.empty?\n\
    \        gap = Math.max(0, top_str.size - range_r.begin)\n        top_space_l\
    \ = Math.max(0, range_r.begin - top_str.size)\n        {width_r + gap, gap, top_space_l,\
    \ 0}\n      else\n        gap = 1\n        space = (width_l - range_l.end - 1)\
    \ + gap + (range_r.begin)\n        tuple =\n          if space < top_str.size\n\
    \            gap += top_str.size - space\n            {range_l.end + 1, 0}\n \
    \         else\n            if (space - top_str.size).odd?\n              space\
    \ += 1\n              gap += 1\n            end\n            under = (space -\
    \ top_str.size) // 2\n            {range_l.end + 1, under}\n          end\n  \
    \      {width_l + gap + width_r, gap} + tuple\n      end\n\n    top_space_r =\
    \ width - top_space_l - top_under * 2 - top_str.size\n    top = [' '] * top_space_l\
    \ + ['_'] * top_under + top_str + ['_'] * top_under + [' '] * top_space_r\n\n\
    \    result = [top]\n    Math.max(left.size, right.size).times do |i|\n      result\
    \ << left.fetch(i) { [' '] * width_l } + [' '] * gap + right.fetch(i) { [' ']\
    \ * width_r }\n    end\n    now_l = top_space_l + top_under\n    now_r = now_l\
    \ + top_str.size - 1\n\n    {result, now_l..now_r}\n  end\n\n  def self.print(tree)\n\
    \    puts dfs(tree.root)[0].join('\\n', &.join)\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/ascii_binary_tree.cr
  requiredBy: []
  timestamp: '2022-01-02 07:36:08+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/ascii_binary_tree.cr
layout: document
redirect_from:
- /library/src/datastructure/ascii_binary_tree.cr
- /library/src/datastructure/ascii_binary_tree.cr.html
title: src/datastructure/ascii_binary_tree.cr
---
