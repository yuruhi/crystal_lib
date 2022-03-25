class Array(T)
  def chmin(i : Int, value : T)
    f = self[i] > value
    self[i] = value if f
    f
  end

  protected def chmin(i : Int, *indexes, value)
    self[i].chmin(*indexes, value: value)
  end

  def chmin(indexes : Tuple, value)
    chmin(*indexes, value: value)
  end

  def chmax(i : Int, value : T)
    f = self[i] < value
    self[i] = value if f
    f
  end

  protected def chmax(i : Int, *indexes, value)
    self[i].chmax(*indexes, value: value)
  end

  def chmax(indexes : Tuple, value)
    chmax(*indexes, value: value)
  end
end
