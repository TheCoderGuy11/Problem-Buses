require './edge.rb'

class Implementation
  def self.execute
    IO.foreach("input.txt") do |value|
      m = Edge.new(value[0])
      m.add_edge(value[1], value[2])
    end     

    Edge.calculate_abc('A','B','C')
    Edge.calculate_ad
    Edge.calculate_abc('A','D','C')
    Edge.calculate_aebcd('A','E','B','C','D')
    Edge.calculate_abc('A','E','D')   
    Edge.trip('C','C')
    Edge.trip('A','C')
    Edge.short('A','C')
    Edge.short('B','B')
  end
end

Implementation.execute
