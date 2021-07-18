class Array(T)
  def chmin(i : Int, value : T)
    (self[i] > value).tap do |f|
      self[i] = value if f
    end
  end

  protected def chmin(i : Int, *indexes, value)
    self[i].chmin(*indexes, value: value)
  end

  def chmin(indexes : Tuple, value)
    chmin(*indexes, value: value)
  end

  def chmax(i : Int, value : T)
    (self[i] < value).tap do |f|
      self[i] = value if f
    end
  end

  protected def chmax(i : Int, *indexes, value)
    self[i].chmax(*indexes, value: value)
  end

  def chmax(indexes : Tuple, value)
    chmax(*indexes, value: value)
  end
end
