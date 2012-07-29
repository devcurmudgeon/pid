# feedback control response simulation
Shoes.app :width => 600, :height => 400 do
  
  @frame = para "TIME"
  @gap = para "GAP"

  @target = oval :fill => red, :left => 0, :top => 450, :radius => 5, :speed => 15, :name => 'Target'
  @dev = oval :fill => green, :left => 0, :top => 500, :radius => 5, :speed => 6, :name => 'Developer'

  l = 0
  p = 0.01
  d = 0.2
  oldgap = 0
  
  a = animate(10) do |frame|
    gap = @target.top - @dev.top
    @target.move frame, @target.top
    if (frame % 25) == 0 
      @target.top = @target.top - rand(50)
    end
    
    @dev.move frame, (@dev.top + l + p * (gap))
    stroke red;  rect(@target.left,@target.top + 5,1,1)
    stroke green; rect(@dev.left,@dev.top + 5,1,1)

    @frame.replace "TIME #{frame}"
    @gap.replace "GAP #{gap}"
    (a.stop) if @target.left > 500
    oldgap = gap
  end
  
end