module Math
  # Solve `y = ax^2 + bx + c`.
  def quadratic_equation(a : Int64, b : Int64, c : Int64) : Array(Float64)?
    if a == 0 && b == 0 && c == 0
      nil
    elsif a == 0 && b == 0
      [] of Float64
    elsif a == 0
      [-(c / b)]
    elsif (d = b * b - a * c * 4) < 0
      [] of Float64
    elsif d == 0
      [-b / (a * 2)]
    else
      x1 = (b > 0) ? (-b - Math.sqrt(d)) / (a * 2) : (-b + Math.sqrt(d)) / (a * 2)
      x2 = (c / a) / x1
      [{x1, x2}.min, {x1, x2}.max]
    end
  end
end
