---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: src/datastructure/persistent_array.cr
    title: src/datastructure/persistent_array.cr
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: test/datastructure/persistent_union_find.test.cr
    title: test/datastructure/persistent_union_find.test.cr
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes: {}
  bundledCode: "# require \"./persistent_array\"\nclass PersistentArray(T)\n  CHILD_SIZE\
    \ = 32\n\n  private struct Node(T)\n    property value : T\n    property child\
    \ : Node(T)*[CHILD_SIZE]\n\n    def initialize\n      @value = T.zero\n      @child\
    \ = StaticArray(Node(T)*, CHILD_SIZE).new(Pointer(Node(T)).null)\n    end\n  end\n\
    \n  protected def self.set(i : Int, value : T, ptr : Node(T)*) : Node(T)*\n  \
    \  result = Pointer(Node(T)).malloc\n    result.copy_from(ptr, 1) if ptr\n   \
    \ if i == 0\n      result.value.value = value\n    else\n      index = i % CHILD_SIZE\n\
    \      result.value.child[index] = set(i // CHILD_SIZE, value, result.value.child[index])\n\
    \    end\n    result\n  end\n\n  @root : Node(T)*\n\n  protected def initialize(@root)\n\
    \  end\n\n  def initialize\n    @root = Pointer(Node(T)).null\n  end\n\n  def\
    \ initialize(array : Array(T))\n    @root = Pointer(Node(T)).null\n    array.each_with_index\
    \ do |x, i|\n      destractive_set(i, x)\n    end\n  end\n\n  def [](i : Int)\
    \ : T\n    get(i)\n  end\n\n  def get(i : Int) : T\n    ptr = @root\n    loop\
    \ do\n      if ptr.null?\n        return T.zero\n      elsif i == 0\n        return\
    \ ptr.value.value\n      else\n        ptr = ptr.value.child[i % CHILD_SIZE]\n\
    \        i //= CHILD_SIZE\n      end\n    end\n  end\n\n  def set(i : Int, val\
    \ : T) : self\n    PersistentArray(T).new self.class.set(i, val, @root)\n  end\n\
    \n  def destractive_set(i : Int, val : T) : T\n    ptr = pointerof(@root)\n  \
    \  loop do\n      if ptr.value.null?\n        ptr.value = Pointer(Node(T)).malloc\n\
    \      end\n      if i == 0\n        ptr.value.value.value = val\n        break\n\
    \      else\n        ptr = ptr.value.value.child.to_unsafe + (i % CHILD_SIZE)\n\
    \        i //= CHILD_SIZE\n      end\n    end\n    val\n  end\n\n  def to_a(size\
    \ : Int) : Array(T)\n    (0...size).map { |i| get(i) }\n  end\nend\n\nclass PersistentUnionFind\n\
    \  protected def initialize(@data : PersistentArray(Int32))\n  end\n\n  def initialize(size\
    \ : Int)\n    @data = PersistentArray(Int32).new Array.new(size, -1)\n  end\n\n\
    \  def root(x : Int)\n    p = @data[x]\n    p >= 0 ? root(p) : x\n  end\n\n  def\
    \ same?(x : Int, y : Int)\n    root(x) == root(y)\n  end\n\n  def size(x : Int)\n\
    \    -@data[root(x)]\n  end\n\n  def unite(x : Int, y : Int) : {Bool, PersistentUnionFind}\n\
    \    x, y = root(x), root(y)\n    return {false, self} if x == y\n    dx, dy =\
    \ @data[x], @data[y]\n    if dx > dy\n      x, y = y, x\n      dx, dy = dy, dx\n\
    \    end\n    {true, PersistentUnionFind.new(@data.set(x, dx + dy).set(y, x))}\n\
    \  end\nend\n"
  code: "require \"./persistent_array\"\n\nclass PersistentUnionFind\n  protected\
    \ def initialize(@data : PersistentArray(Int32))\n  end\n\n  def initialize(size\
    \ : Int)\n    @data = PersistentArray(Int32).new Array.new(size, -1)\n  end\n\n\
    \  def root(x : Int)\n    p = @data[x]\n    p >= 0 ? root(p) : x\n  end\n\n  def\
    \ same?(x : Int, y : Int)\n    root(x) == root(y)\n  end\n\n  def size(x : Int)\n\
    \    -@data[root(x)]\n  end\n\n  def unite(x : Int, y : Int) : {Bool, PersistentUnionFind}\n\
    \    x, y = root(x), root(y)\n    return {false, self} if x == y\n    dx, dy =\
    \ @data[x], @data[y]\n    if dx > dy\n      x, y = y, x\n      dx, dy = dy, dx\n\
    \    end\n    {true, PersistentUnionFind.new(@data.set(x, dx + dy).set(y, x))}\n\
    \  end\nend\n"
  dependsOn:
  - src/datastructure/persistent_array.cr
  isVerificationFile: false
  path: src/datastructure/persistent_union_find.cr
  requiredBy: []
  timestamp: '2021-07-12 15:23:17+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - test/datastructure/persistent_union_find.test.cr
documentation_of: src/datastructure/persistent_union_find.cr
layout: document
redirect_from:
- /library/src/datastructure/persistent_union_find.cr
- /library/src/datastructure/persistent_union_find.cr.html
title: src/datastructure/persistent_union_find.cr
---
