# feedback control response simulation
Shoes.app :width => 1500, :height => 1000, :title => "Project Control Simulator" do
  @push = button "Run"
  teamsize = 5
  lag = 1
  uncertainty = 0

  sprint = 20
  iterations = 10

  capacity = sprint * teamsize
  @scale = 3

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
    oval(id.left, id.top + 5,@scale, @scale)
  end

  @push.click  { 
    @anim.stop if @anim
    background white

    @spec = oval :fill => red, :left => 0, :top => 950, :radius => 5, :speed => 15, :name => 'Spec'
    @work = oval :fill => green, :left => 0, :top => 1000, :radius => 5, :speed => 6, :name => 'Work'
    window :height => 20 do
      para "SPRINT: #{sprint} days LAG: #{lag} days UNCERTAINTY: #{uncertainty}% TEAMSIZE: #{teamsize} "
    end
    @anim = animate(50) do |day|
      @anim.stop if day >= iterations * sprint - 1
      gap = @spec.top - @work.top
      error = uncertainty / 100 * (gap/2 - rand(gap.to_i))
      gaparray[day + lag] = gap + error
      @spec.move day * @scale, @spec.top
      if (day % sprint) == 0 and (@spec.top > 120)
        step = rand(sprint) * @scale
        @spec.top = @spec.top - step
      end

      workdone = active(day) * teamsize * gaparray[day] / sprint

      @work.move day * @scale, (@work.top + workdone)
      trail(@spec)
      trail(@work)
    end
  }
end
