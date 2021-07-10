class Array(T)
  def mex
    result = T.zero
    self.sort.each do |i|
      return result if result < i
      result = i.succ
    end
    result
  end
end
