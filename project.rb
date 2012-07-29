# feedback control response simulation
Shoes.app :width => 1500, :height => 1000 do

  @day = para "DAY"
  @gap = para "GAP"
  @spec = oval :fill => red, :left => 0, :top => 950, :radius => 5, :speed => 15, :name => 'Spec'
  @team = oval :fill => green, :left => 0, :top => 1000, :radius => 5, :speed => 6, :name => 'Team'
  @loc = 0
  @teamsize = 1
  @sprint = 70

  lag = 10
  error = 0
  l = 5
  p = 0.1
  d = 0.2
  oldgap = 0
  gaparray = Array.new(600) {|i| 0 }

  def active day
    if ((day % 7) == 0) or ((day % 6) == 0)
      return 0
    else
      return 1
    end
  end

  def trail id
    stroke id.fill
    oval(id.left, id.top + 5,3,3)
  end

  a = animate(25) do |day|
    gap = @spec.top - @team.top + rand(error)
    gaparray[day + lag] = gap
    @spec.move day * 3, @spec.top
    if (day % @sprint) == 0 and (@spec.top > 100)
      @spec.top = @spec.top - rand(@sprint) * 2
    end

    @team.move day * 3, @team.top + gaparray[day] * p * active(day) * @teamsize
    trail(@spec)
    trail(@team)

    @day.replace "DAY #{day}"
    @gap.replace "GAP #{gap}"
    (a.stop) if day > 400
    oldgap = gap
  end
end
