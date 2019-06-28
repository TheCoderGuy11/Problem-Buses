class Edge
  attr_accessor :from, :towards, :distance, :total, :count
  STEPS = 3
  @@info = [] 

  def initialize(from)
    self.from = from
  end

  def add_edge(towards, weight)
    self.towards = towards
    self.distance = weight.to_i
    @@info << self
  end

  def self.all
    @@info
  end

# Here we will find the overall distance
  def self.distance(value1,value2,value3)
    x = Edge.all.reject{|value| value.from != "#{value1}"}
                .reject{|value| value.towards != "#{value2}"}
    z = Edge.all.reject{|value| value.from != "#{value2}"}
                .reject{|value| value.towards != "#{value3}"} 
     
    x.zip(z).each do |value1, value2|
      if value2 != nil 
        if value2.from == value1.towards              
           return (value1.distance + value2.distance)  
        end
      else
         return "PATH NOT FOUND"
      end
    end

  end

# calculating A-B-C and A-D-C and A-E-D
  def self.calculate_abc(value1,value2,value3)
    x = Edge.distance(value1,value2,value3)
    puts "Distance: " + x.to_s
  end

# calculating A-D
  def self.calculate_ad
    x = Edge.all.reject{|value| value.towards != 'D'}  
    x.each do |value|
      if value.from == 'A'
        puts "Distance: " + (value.distance).to_s
      end
    end
  end

# calculating A-E-B-C-D
  def self.calculate_aebcd(value1,value2,value3,value4,value5)
    x = Edge.distance(value1,value2,value3)
    y = Edge.distance(value3,value4,value5)
    puts "Distance :" + (x+y).to_s
  end

# calculating trips that has stating point as well as ending point at C
# And have maximum step 3 
  attr_accessor :starting_point, :ending_point, :temp, :check

  def self.trip(starting_point, ending_point)
    @starting_point, @ending_point = starting_point, ending_point
    @count, @check = 0, 0
    @neigh = []

    x = Edge.all.reject{|value| value.from != @starting_point}
    x.each{|value| @neigh << value.towards}
    @check += 1
    for i in (0...STEPS)
      @starting_point = @neigh[i]
      @temp = Edge.all.reject{|value| value.from != @starting_point}
      @temp.each do |value| 
        @check += 1
        if value.towards == @ending_point
          @check <= 3 || @check == 4 ? @count += 1 : @count = 0
          @temp.delete_if{|value| value.from == @starting_point}  
        else           
          @temp.each{|value| @neigh = value.towards}
          @temp = Edge.all.reject{|value| value.from != @neigh}
          @temp.each do |value|
            if value.towards == @ending_point 
              @check <= 3 || @check == 4 ? @count += 1 : @count = 0
            end
          end
         end
      end

     end
    puts "Total trip from #{starting_point} to #{ending_point}: " + @count.to_s
  end

# Here we will calculate nnumber of trips from A to C
# With exactly 4 counts 
  def self.short(starting, ending)
    @starting_point, @ending_point = starting, ending
    @sort = []

    @temp = Edge.all.reject{|value| value.from != @starting_point}
    @z = Edge.all.reject{|value| value.towards != @ending_point}
    @temp.zip(@z).each do |value1, value2|
      if value2 != nil
          if value2.towards == @ending_point
            @total = value1.distance + value2.distance
            @sort << @total
          end        
      end
    end
   puts "Shortest Distance from #{starting} to #{ending}: " + (@sort.min).to_s     
  end
 
end
