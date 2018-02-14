class Station

  attr_reader :name
  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def del_train(train)
    @trains.delete(train)
  end

  def list_type(type)
    self.trains.select{ |train| train.type == type }
  end

  def departure(train)
     train.go_forward
  end

  def arrive(train)
     train.go_back
  end

end

class Route
  
  attr_reader :station

  def initialize(start, terminate)
    @station = [start, terminate]
  end
  
  def start
    @station[0] 
  end

  def terminate
    @station[-1]
  end

  def add_station(station)
    @station.insert(-2, station)
  end

  def del_station(name)
    if (@station[0].name == name || @station[-1].name == name)
      puts "Начальные точки маршрута нельзя удальять"
    else  
      @station.delete_if {|station| station.name == name }
    end
  end

  def way
    puts "Маршрут следования:"
    @station.each { |station| puts "#{station.name}" }
  end

end

class Train

  attr_reader :name
  attr_reader :type
  attr_reader :speed

  def initialize(name, type, wagons, route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
  end
  
  def change_speed(speed)
    (@speed + speed) > 0 ? @speed += speed : @speed = 0
  end

  def wagons
    @wagons 
  end

  def stop
    @speed = 0
  end

  def attach
    self.speed > 0 ? "Нужно остановиться" : @wagons += 1
  end

  def deattach
    puts "Нужно остановиться" if self.speed > 0 
    @wagons -= 1 if @wagons > 0 
  end

  def route=(route)
    @route = route
    @location = @route.start
    @location.add_train(self)
  end

  def index
    route = @route.station
    route.index(@location)
  end

  def go_forward
    return if @location == @route.terminate
    @location.del_train(self)
    @location = @route.station[index + 1]
    @location.add_train(self)
  end

  def go_back
    return if @location == @route.start
    @location.del_train(self)
    @location = @route.station[index - 1]
    @location.add_train(self)
  end
  
  def current_station
    return @location
  end

  def back_station
    return if @location == @route.start
    back_st = @route.station[index - 1]
    puts "Предыдущая станция: #{back_st.name}"
  end

  def next_station
    return if @location == @route.terminate
    next_st = @route.station[index + 1]
    puts "Следующая станция: #{next_st.name}"
  end

end  


