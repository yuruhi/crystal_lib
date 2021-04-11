lib C
  fun strtoll(s : UInt8*, p : UInt8**, b : Int32) : Int64
end

class String
  def to_i64
    C.strtoll(self, nil, 10)
  end
end
