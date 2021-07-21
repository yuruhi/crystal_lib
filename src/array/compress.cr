class Array(T)
  def compress(values : Array(T), *, index : Int = 0)
    map do |x|
      index + values.bsearch_index { |y| y >= x }.not_nil!
    end
  end

  def compress(*, index : Int = 0) : Array(Int32)
    compress(uniq.sort!, index: index)
  end
end
