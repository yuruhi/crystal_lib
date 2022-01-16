# reference: https://github.com/tatyam-prime/SortedSet/blob/main/SortedSet.py
class SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH)
  include Enumerable(T)
  include Iterable(T)
  include Indexable(T)

  getter size = 0
  @buckets = [] of Array(T)

  def initialize
  end

  def initialize(a : Enumerable(T))
    build a.to_a.sort!.uniq!
  end

  private def build(a : Array(T)) : Nil
    @size = a.size
    bucket_size = Math.sqrt(size / BUCKET_RATIO).ceil.to_i
    @buckets = Array.new(bucket_size) { |i| a[size * i // bucket_size...size * (i + 1) // bucket_size] }
  end

  private def build
    build to_a
  end

  def empty? : Bool
    @size == 0
  end

  def clear
    @size = 0
    @buckets.clear
  end

  def min? : T?
    empty? ? nil : @buckets.first.first
  end

  def min : T
    min? || raise EmptyError.new
  end

  def max? : T?
    empty? ? nil : @buckets.last.last
  end

  def max : T
    max? || raise EmptyError.new
  end

  def each(&) : Nil
    @buckets.each do |bucket|
      bucket.each do |object|
        yield object
      end
    end
  end

  private class ItemIterator(T)
    include Iterator(T)

    def initialize(@buckets : Array(Array(T)))
      @i, @j = 0, 0
    end

    def next
      if @buckets.size == @i
        stop
      else
        @buckets[@i][@j].tap do
          @j += 1
          @i, @j = @i + 1, 0 if @buckets[@i].size == @j
        end
      end
    end
  end

  def each
    ItemIterator(T).new(@buckets)
  end

  def reverse_each(&) : Nil
    @buckets.reverse_each do |bucket|
      bucket.reverse_each do |object|
        yield object
      end
    end
  end

  private def find_bucket(object : T)
    {% if BSEARCH > 0 %}
      @buckets.bsearch { |bucket| object <= bucket.last } || @buckets.last
    {% else %}
      @buckets.find(@buckets.last) { |bucket| object <= bucket.last }
    {% end %}
  end

  def includes?(object : T) : Bool
    false if empty?
    find_bucket(object).bsearch { |x| x >= object } == object
  end

  def unsafe_fetch(index : Int) : T
    @buckets.each do |bucket|
      return bucket.unsafe_fetch(index) if index < bucket.size
      index -= bucket.size
    end
    raise "Bug"
  end

  def add?(object : T) : Bool
    if size == 0
      @buckets = [[object]]
      @size = 1
      return true
    end

    a = find_bucket(object)
    i = a.bsearch_index { |x| x >= object }
    return false if i && a[i] == object
    i ? a.insert(i, object) : a.push(object)
    @size += 1
    build if a.size > @buckets.size * REBUILD_RATIO
    true
  end

  def add(object : T) : self
    add?(object)
    self
  end

  def <<(object : T) : self
    add(object)
  end

  def concat(elems) : self
    elems.each { |object| add(object) }
    self
  end

  def delete(object : T) : Bool
    return false if empty?
    a = find_bucket(object)
    i = a.bsearch_index { |x| x >= object }
    return false if i.nil? || a[i] != object
    a.delete_at(i)
    @size -= 1
    build if a.empty?
    true
  end

  def index(object : T, offset : Int = 0)
    @buckets.each do |bucket|
      if bucket.last >= x
        i = bucket.bsearch_index { |x| x >= object }
        return i ? offset + i : nil
      end
      offset += bucket.size
    end
  end

  def le(object : T) : T?
    @buckets.reverse_each do |bucket|
      if bucket.first <= object
        i = bucket.bsearch_index { |x| x > object } || bucket.size
        return bucket[i - 1]
      end
    end
  end

  def lt(object : T) : T?
    @buckets.reverse_each do |bucket|
      if bucket.first < object
        i = bucket.bsearch_index { |x| x >= object } || bucket.size
        return bucket[i - 1]
      end
    end
  end

  def ge(object : T) : T?
    {% if BSEARCH > 0 %}
      @buckets.bsearch { |bucket| bucket.last >= object }.try do |bucket|
        bucket.bsearch { |x| x >= object }.not_nil!
      end
    {% else %}
      @buckets.each do |bucket|
        if bucket.last >= object
          return bucket.bsearch { |x| x >= object }.not_nil!
        end
      end
    {% end %}
  end

  def gt(object : T) : T?
    @buckets.each do |bucket|
      if bucket.last > object
        return bucket.bsearch { |x| x > object }.not_nil!
      end
    end
  end

  {% for method in [:le, :lt, :ge, :gt] %}
    def {{method.id}}!(object : T) : T
      {{method.id}}(object).not_nil!
    end
  {% end %}

  {% for op in [:&, :|, :^, :+, :-] %}
    def {{op.id}}(other : Enumerable(T)) : self
      SSet::Bucket(T, BUCKET_RATIO, REBUILD_RATIO, BSEARCH).new (self.to_set {{op.id}} other.to_set)
    end
  {% end %}

  def to_a : Array(T)
    @buckets.each_with_object(Array(T).new size) do |bucket, a|
      a.concat bucket
    end
  end

  def to_s(io : IO) : Nil
    io << "Bucket{"
    join(", ", io)
    io << "}"
  end

  def inspect(io : IO) : Nil
    @buckets.inspect(io)
  end
end
