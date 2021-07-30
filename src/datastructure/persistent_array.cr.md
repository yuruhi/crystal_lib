---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: src/datastructure/persistent_union_find.cr
    title: src/datastructure/persistent_union_find.cr
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cr
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "class PersistentArray(T)\n  CHILD_SIZE = 32\n\n  private struct Node(T)\n\
    \    property value : T\n    property child : Node(T)*[CHILD_SIZE]\n\n    def\
    \ initialize\n      @value = T.zero\n      @child = StaticArray(Node(T)*, CHILD_SIZE).new(Pointer(Node(T)).null)\n\
    \    end\n  end\n\n  protected def self.set(i : Int, value : T, ptr : Node(T)*)\
    \ : Node(T)*\n    result = Pointer(Node(T)).malloc\n    result.copy_from(ptr,\
    \ 1) if ptr\n    if i == 0\n      result.value.value = value\n    else\n     \
    \ index = i % CHILD_SIZE\n      result.value.child[index] = set(i // CHILD_SIZE,\
    \ value, result.value.child[index])\n    end\n    result\n  end\n\n  @root : Node(T)*\n\
    \n  protected def initialize(@root)\n  end\n\n  def initialize\n    @root = Pointer(Node(T)).null\n\
    \  end\n\n  def initialize(array : Array(T))\n    @root = Pointer(Node(T)).null\n\
    \    array.each_with_index do |x, i|\n      destractive_set(i, x)\n    end\n \
    \ end\n\n  def [](i : Int) : T\n    get(i)\n  end\n\n  def get(i : Int) : T\n\
    \    ptr = @root\n    loop do\n      if ptr.null?\n        return T.zero\n   \
    \   elsif i == 0\n        return ptr.value.value\n      else\n        ptr = ptr.value.child[i\
    \ % CHILD_SIZE]\n        i //= CHILD_SIZE\n      end\n    end\n  end\n\n  def\
    \ set(i : Int, val : T) : self\n    PersistentArray(T).new self.class.set(i, val,\
    \ @root)\n  end\n\n  def destractive_set(i : Int, val : T) : T\n    ptr = pointerof(@root)\n\
    \    loop do\n      if ptr.value.null?\n        ptr.value = Pointer(Node(T)).malloc\n\
    \      end\n      if i == 0\n        ptr.value.value.value = val\n        break\n\
    \      else\n        ptr = ptr.value.value.child.to_unsafe + (i % CHILD_SIZE)\n\
    \        i //= CHILD_SIZE\n      end\n    end\n    val\n  end\n\n  def to_a(size\
    \ : Int) : Array(T)\n    (0...size).map { |i| get(i) }\n  end\nend\n"
  code: "class PersistentArray(T)\n  CHILD_SIZE = 32\n\n  private struct Node(T)\n\
    \    property value : T\n    property child : Node(T)*[CHILD_SIZE]\n\n    def\
    \ initialize\n      @value = T.zero\n      @child = StaticArray(Node(T)*, CHILD_SIZE).new(Pointer(Node(T)).null)\n\
    \    end\n  end\n\n  protected def self.set(i : Int, value : T, ptr : Node(T)*)\
    \ : Node(T)*\n    result = Pointer(Node(T)).malloc\n    result.copy_from(ptr,\
    \ 1) if ptr\n    if i == 0\n      result.value.value = value\n    else\n     \
    \ index = i % CHILD_SIZE\n      result.value.child[index] = set(i // CHILD_SIZE,\
    \ value, result.value.child[index])\n    end\n    result\n  end\n\n  @root : Node(T)*\n\
    \n  protected def initialize(@root)\n  end\n\n  def initialize\n    @root = Pointer(Node(T)).null\n\
    \  end\n\n  def initialize(array : Array(T))\n    @root = Pointer(Node(T)).null\n\
    \    array.each_with_index do |x, i|\n      destractive_set(i, x)\n    end\n \
    \ end\n\n  def [](i : Int) : T\n    get(i)\n  end\n\n  def get(i : Int) : T\n\
    \    ptr = @root\n    loop do\n      if ptr.null?\n        return T.zero\n   \
    \   elsif i == 0\n        return ptr.value.value\n      else\n        ptr = ptr.value.child[i\
    \ % CHILD_SIZE]\n        i //= CHILD_SIZE\n      end\n    end\n  end\n\n  def\
    \ set(i : Int, val : T) : self\n    PersistentArray(T).new self.class.set(i, val,\
    \ @root)\n  end\n\n  def destractive_set(i : Int, val : T) : T\n    ptr = pointerof(@root)\n\
    \    loop do\n      if ptr.value.null?\n        ptr.value = Pointer(Node(T)).malloc\n\
    \      end\n      if i == 0\n        ptr.value.value.value = val\n        break\n\
    \      else\n        ptr = ptr.value.value.child.to_unsafe + (i % CHILD_SIZE)\n\
    \        i //= CHILD_SIZE\n      end\n    end\n    val\n  end\n\n  def to_a(size\
    \ : Int) : Array(T)\n    (0...size).map { |i| get(i) }\n  end\nend\n"
  dependsOn: []
  isVerificationFile: false
  path: src/datastructure/persistent_array.cr
  requiredBy:
  - src/datastructure/persistent_union_find.cr
  timestamp: '2021-07-30 20:19:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/datastructure/persistent_array.cr
layout: document
redirect_from:
- /library/src/datastructure/persistent_array.cr
- /library/src/datastructure/persistent_array.cr.html
title: src/datastructure/persistent_array.cr
---
