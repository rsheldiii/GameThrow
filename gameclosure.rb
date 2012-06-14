class Gameclosure
  attr_accessor :possession, :regexp, :undo
  def initialize(possession,regexp,undo)
    
    @possession = possession
    @regexp = regexp
    @undo = undo
  end
end
