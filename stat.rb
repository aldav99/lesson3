class Station

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def list_by_type(type)
    self.trains.select { |train| train.type == type }
  end
end

class Route
  
  attr_reader :stations

  def initialize(start, terminate)
    @stations = [start, terminate]
  end
  
  def start
    @stations[0] 
  end

  def terminate
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(name)
    if (start.name == name || terminate.name == name)
      puts "Начальные точки маршрута нельзя удальять"
    else  
      @stations.delete_if {|station| station.name == name }
    end
  end
end

class Train

  attr_reader :name, :type, :speed
  
  def initialize(name, type, wagons, route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
  end
  
  def change_speed(speed_delta)
    @speed = [@speed + speed_delta, 0].max
  end

  def wagons
    @wagons 
  end

  def stop
    @speed = 0
  end

  def attach_wagon
    self.speed > 0 ? "Нужно остановиться" : @wagons += 1
  end

  def deattach_wagon
    @wagons -= 1 if @speed == 0 && @wagons > 0 
  end

  def route=(route)
    @route = route
    @index_location = 0
    @route.start.add_train(self)
  end

  def go_forward
    return if @route.stations[@index_location] == @route.terminate
    @route.stations[@index_location].delete_train(self)
    @index_location += 1
    @route.stations[@index_location].add_train(self)
  end

  def go_back
    return if @route.stations[@index_location] == @route.start
    @route.stations[@index_location].delete_train(self)
    @index_location -= 1
    @route.stations[@index_location].add_train(self)
  end

  def current_station
    @route.stations[@index_location]
  end

  def back_station
    return if @route.stations[@index_location] == @route.start
    @route.stations[@index_location - 1]
  end

  def next_station
    return if @route.stations[@index_location] == @route.terminate
    @route.stations[@index_location + 1]
  end
end  


