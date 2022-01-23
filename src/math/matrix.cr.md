---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: spec/math/matrix_spec.cr
    title: spec/math/matrix_spec.cr
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/math/matrix_product_test.cr
    title: test/math/matrix_product_test.cr
  - icon: ':heavy_check_mark:'
    path: test/math/matrix_test.cr
    title: test/math/matrix_test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "class Matrix(T)\n  include Indexable(Array(T))\n\n  def Matrix.identity(size\
    \ : Int32) : self\n    result = Matrix(T).new(size, size, T.zero)\n    (0...size).each\
    \ do |i|\n      result[i][i] = T.new(1)\n    end\n    result\n  end\n\n  macro\
    \ [](*args)\n    Matrix.new [{{args.splat}}]\n  end\n\n  getter height : Int32,\
    \ width : Int32, data : Array(Array(T))\n\n  def initialize\n    @height = 0\n\
    \    @width = 0\n    @data = Array(Array(T)).new\n  end\n\n  def initialize(@height,\
    \ @width, value : T)\n    raise ArgumentError.new(\"Negative matrix height: #{@height}\"\
    ) unless @height >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\"\
    ) unless @width >= 0\n    @data = Array.new(height) { Array(T).new(width, value)\
    \ }\n  end\n\n  def initialize(@height, @width, &block : Int32, Int32 -> T)\n\
    \    raise ArgumentError.new(\"Negative matrix height: #{@height}\") unless @height\
    \ >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\") unless\
    \ @width >= 0\n    @data = Array.new(height) { |i| Array.new(width) { |j| yield\
    \ i, j } }\n  end\n\n  def initialize(@data : Array(Array(T)))\n    @height =\
    \ @data.size\n    @width = @data[0].size\n    raise ArgumentError.new unless @data.all?\
    \ { |a| a.size == width }\n  end\n\n  def size : Int32\n    @data.size\n  end\n\
    \n  def unsafe_fetch(index : Int) : Array(T)\n    @data.unsafe_fetch(index)\n\
    \  end\n\n  private def check_index_out_of_bounds(i, j)\n    check_index_out_of_bounds(i,\
    \ j) { raise IndexError.new }\n  end\n\n  private def check_index_out_of_bounds(i,\
    \ j)\n    i += height if i < 0\n    j += width if j < 0\n    if 0 <= i < height\
    \ && 0 <= j < width\n      {i, j}\n    else\n      yield\n    end\n  end\n\n \
    \ def fetch(i : Int, j : Int, &)\n    i, j = check_index_out_of_bounds(i, j) {\
    \ return yield i, j }\n    unsafe_fetch(i, j)\n  end\n\n  def fetch(i : Int, j\
    \ : Int, default)\n    fetch(i, j) { default }\n  end\n\n  def [](i : Int, j :\
    \ Int) : T\n    fetch(i, j) { raise IndexError.new }\n  end\n\n  def []?(i : Int,\
    \ j : Int) : T?\n    fetch(i, j, nil)\n  end\n\n  def unsafe_fetch(i : Int, j\
    \ : Int) : T\n    @data.unsafe_fetch(i).unsafe_fetch(j)\n  end\n\n  def +(other\
    \ : self) : self\n    raise IndexError.new unless height == other.height && width\
    \ == other.width\n    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i,\
    \ j) + other.unsafe_fetch(i, j)\n    }\n  end\n\n  def -(other : self) : self\n\
    \    raise IndexError.new unless height == other.height && width == other.width\n\
    \    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i, j) - other.unsafe_fetch(i,\
    \ j)\n    }\n  end\n\n  def *(other : self) : self\n    raise IndexError.new unless\
    \ width == other.height\n    Matrix(T).new(height, other.width) { |i, j|\n   \
    \   (0...width).sum { |k| unsafe_fetch(i, k) * other.unsafe_fetch(k, j) }\n  \
    \  }\n  end\n\n  def **(k : Int) : self\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def ==(other\
    \ : Matrix) : Bool\n    return false unless height == other.height && width ==\
    \ other.width\n    data == other.data\n  end\n\n  def to_s(io) : Nil\n    io <<\
    \ data\n  end\n\n  def inspect(io) : Nil\n    io << \"Matrix\" << data\n  end\n\
    end\n"
  code: "class Matrix(T)\n  include Indexable(Array(T))\n\n  def Matrix.identity(size\
    \ : Int32) : self\n    result = Matrix(T).new(size, size, T.zero)\n    (0...size).each\
    \ do |i|\n      result[i][i] = T.new(1)\n    end\n    result\n  end\n\n  macro\
    \ [](*args)\n    Matrix.new [{{args.splat}}]\n  end\n\n  getter height : Int32,\
    \ width : Int32, data : Array(Array(T))\n\n  def initialize\n    @height = 0\n\
    \    @width = 0\n    @data = Array(Array(T)).new\n  end\n\n  def initialize(@height,\
    \ @width, value : T)\n    raise ArgumentError.new(\"Negative matrix height: #{@height}\"\
    ) unless @height >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\"\
    ) unless @width >= 0\n    @data = Array.new(height) { Array(T).new(width, value)\
    \ }\n  end\n\n  def initialize(@height, @width, &block : Int32, Int32 -> T)\n\
    \    raise ArgumentError.new(\"Negative matrix height: #{@height}\") unless @height\
    \ >= 0\n    raise ArgumentError.new(\"Negative matrix width: #{@width}\") unless\
    \ @width >= 0\n    @data = Array.new(height) { |i| Array.new(width) { |j| yield\
    \ i, j } }\n  end\n\n  def initialize(@data : Array(Array(T)))\n    @height =\
    \ @data.size\n    @width = @data[0].size\n    raise ArgumentError.new unless @data.all?\
    \ { |a| a.size == width }\n  end\n\n  def size : Int32\n    @data.size\n  end\n\
    \n  def unsafe_fetch(index : Int) : Array(T)\n    @data.unsafe_fetch(index)\n\
    \  end\n\n  private def check_index_out_of_bounds(i, j)\n    check_index_out_of_bounds(i,\
    \ j) { raise IndexError.new }\n  end\n\n  private def check_index_out_of_bounds(i,\
    \ j)\n    i += height if i < 0\n    j += width if j < 0\n    if 0 <= i < height\
    \ && 0 <= j < width\n      {i, j}\n    else\n      yield\n    end\n  end\n\n \
    \ def fetch(i : Int, j : Int, &)\n    i, j = check_index_out_of_bounds(i, j) {\
    \ return yield i, j }\n    unsafe_fetch(i, j)\n  end\n\n  def fetch(i : Int, j\
    \ : Int, default)\n    fetch(i, j) { default }\n  end\n\n  def [](i : Int, j :\
    \ Int) : T\n    fetch(i, j) { raise IndexError.new }\n  end\n\n  def []?(i : Int,\
    \ j : Int) : T?\n    fetch(i, j, nil)\n  end\n\n  def unsafe_fetch(i : Int, j\
    \ : Int) : T\n    @data.unsafe_fetch(i).unsafe_fetch(j)\n  end\n\n  def +(other\
    \ : self) : self\n    raise IndexError.new unless height == other.height && width\
    \ == other.width\n    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i,\
    \ j) + other.unsafe_fetch(i, j)\n    }\n  end\n\n  def -(other : self) : self\n\
    \    raise IndexError.new unless height == other.height && width == other.width\n\
    \    Matrix(T).new(height, width) { |i, j|\n      unsafe_fetch(i, j) - other.unsafe_fetch(i,\
    \ j)\n    }\n  end\n\n  def *(other : self) : self\n    raise IndexError.new unless\
    \ width == other.height\n    Matrix(T).new(height, other.width) { |i, j|\n   \
    \   (0...width).sum { |k| unsafe_fetch(i, k) * other.unsafe_fetch(k, j) }\n  \
    \  }\n  end\n\n  def **(k : Int) : self\n    result = Matrix(T).identity(height)\n\
    \    memo = Matrix.new(data)\n    while k > 0\n      result *= memo if k.odd?\n\
    \      memo *= memo\n      k >>= 1\n    end\n    result\n  end\n\n  def ==(other\
    \ : Matrix) : Bool\n    return false unless height == other.height && width ==\
    \ other.width\n    data == other.data\n  end\n\n  def to_s(io) : Nil\n    io <<\
    \ data\n  end\n\n  def inspect(io) : Nil\n    io << \"Matrix\" << data\n  end\n\
    end\n"
  dependsOn: []
  isVerificationFile: false
  path: src/math/matrix.cr
  requiredBy:
  - spec/math/matrix_spec.cr
  timestamp: '2022-01-23 00:45:43+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/math/matrix_test.cr
  - test/math/matrix_product_test.cr
documentation_of: src/math/matrix.cr
layout: document
redirect_from:
- /library/src/math/matrix.cr
- /library/src/math/matrix.cr.html
title: src/math/matrix.cr
---
