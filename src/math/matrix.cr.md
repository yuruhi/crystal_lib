---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/math/matrix.test.cr
    title: test/math/matrix.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Matrix(T)\n  include Indexable(Array(T))\n\n  getter height\
    \ : Int32, width : Int32\n  getter data : Array(Array(T))\n\n  def Matrix.identity(size\
    \ : Int32) : self\n    result = Matrix(T).new(size, size)\n    (0...size).each\
    \ do |i|\n      result[i][i] = T.new(1)\n    end\n    result\n  end\n\n  def initialize(@height,\
    \ @width, init_value : T = T.zero)\n    @data = Array(Array(T)).new(height) {\
    \ Array(T).new(width, init_value) }\n  end\n\n  def initialize(init_matrix : Array(Array(T)))\n\
    \    @height = init_matrix.size\n    @width = init_matrix[0].size\n    raise ArgumentError.new\
    \ unless init_matrix.all? { |a| a.size == width }\n    @data = init_matrix\n \
    \ end\n\n  delegate size, to: @data\n  delegate unsafe_fetch, to: @data\n\n  def\
    \ +(other : self)\n    IndexError.new unless height == other.height && width ==\
    \ other.width\n    result = Matrix(T).new(height, width)\n    (0...height).each\
    \ do |i|\n      (0...width).each do |j|\n        result[i][j] = data[i][j] + other[i][j]\n\
    \      end\n    end\n    result\n  end\n\n  def -(other : self)\n    IndexError.new\
    \ unless height == other.height && width == other.width\n    result = Matrix(T).new(height,\
    \ width)\n    (0...height).each do |i|\n      (0...width).each do |j|\n      \
    \  result[i][j] = data[i][j] - other[i][j]\n      end\n    end\n    result\n \
    \ end\n\n  def *(other : self)\n    IndexError.new unless width == other.height\n\
    \    result = Matrix(T).new(height, other.width)\n    (0...height).each do |i|\n\
    \      (0...other.width).each do |j|\n        (0...width).each do |k|\n      \
    \    result[i][j] += data[i][k] * other[k][j]\n        end\n      end\n    end\n\
    \    result\n  end\n\n  def **(k : Int)\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << data\n  end\nend\n"
  code: "class Matrix(T)\n  include Indexable(Array(T))\n\n  getter height : Int32,\
    \ width : Int32\n  getter data : Array(Array(T))\n\n  def Matrix.identity(size\
    \ : Int32) : self\n    result = Matrix(T).new(size, size)\n    (0...size).each\
    \ do |i|\n      result[i][i] = T.new(1)\n    end\n    result\n  end\n\n  def initialize(@height,\
    \ @width, init_value : T = T.zero)\n    @data = Array(Array(T)).new(height) {\
    \ Array(T).new(width, init_value) }\n  end\n\n  def initialize(init_matrix : Array(Array(T)))\n\
    \    @height = init_matrix.size\n    @width = init_matrix[0].size\n    raise ArgumentError.new\
    \ unless init_matrix.all? { |a| a.size == width }\n    @data = init_matrix\n \
    \ end\n\n  delegate size, to: @data\n  delegate unsafe_fetch, to: @data\n\n  def\
    \ +(other : self)\n    IndexError.new unless height == other.height && width ==\
    \ other.width\n    result = Matrix(T).new(height, width)\n    (0...height).each\
    \ do |i|\n      (0...width).each do |j|\n        result[i][j] = data[i][j] + other[i][j]\n\
    \      end\n    end\n    result\n  end\n\n  def -(other : self)\n    IndexError.new\
    \ unless height == other.height && width == other.width\n    result = Matrix(T).new(height,\
    \ width)\n    (0...height).each do |i|\n      (0...width).each do |j|\n      \
    \  result[i][j] = data[i][j] - other[i][j]\n      end\n    end\n    result\n \
    \ end\n\n  def *(other : self)\n    IndexError.new unless width == other.height\n\
    \    result = Matrix(T).new(height, other.width)\n    (0...height).each do |i|\n\
    \      (0...other.width).each do |j|\n        (0...width).each do |k|\n      \
    \    result[i][j] += data[i][k] * other[k][j]\n        end\n      end\n    end\n\
    \    result\n  end\n\n  def **(k : Int)\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def to_s(io)\
    \ : Nil\n    io << data\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/matrix.cr
  requiredBy: []
  timestamp: '2021-08-03 18:03:19+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/matrix.test.cr
documentation_of: src/math/matrix.cr
layout: document
redirect_from:
- /library/src/math/matrix.cr
- /library/src/math/matrix.cr.html
title: src/math/matrix.cr
---
