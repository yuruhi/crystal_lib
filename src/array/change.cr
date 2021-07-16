class Array(T)
  def chmin(i : Int, value : T)
    (self[i] > value).tap do |f|
      self[i] = value if f
    end
  end

  def chmax(i : Int, value : T)
    (self[i] < value).tap do |f|
      self[i] = value if f
    end
  end
end
