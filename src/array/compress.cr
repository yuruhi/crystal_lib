class Array(T)
  def compress(values : Array(T))
    map do |x|
      values.bsearch_index { |y| y >= x }.not_nil!
    end
  end

  def compress : Array(Int32)
    compress(uniq.sort!)
  end
end
