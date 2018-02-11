class Station

  def initialize(name)
    @name = name
    @trains = []
  end

  def name
    @name
  end

  def trains
    @trains
  end

  def list_train
     self.trains.each { |train| puts train.name }
  end

  def list_type
     cargo = 0
     passenger = 0
     self.trains.each do |train|
      train.type == "Пассажирский" ? passenger +=1 : cargo +=1
     end
     puts "Кол-во грузовых: #{cargo}"
     puts "Кол-во пассажирских: #{passenger}"
  end

  def departure(train, direction = 0)
     direction == 0 ? train.go_forward : train.go_back
  end

end

class Route
  def initialize(start, terminate)
    @start = start
    @terminate = terminate
    @way_station = [@start, @terminate]
  end
  
  def start
    @start 
  end

  def terminate
    @terminate
  end

  def way_station
    @way_station
  end

  def add_station(obj)
    @way_station.insert(-2, obj)
  end

  def del_station(name)
    @way_station.delete_if {|station| station.name == name }
  end

  def way
    puts "Маршрут следования:"
    @way_station.each { |station| puts "#{station.name}" }
  end

end

class Train

  def initialize(name, type, wagons)
    @name_train = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = 0
  end

  def name
    @name_train
  end

  def type
    @type
  end

  def add_speed(n)
    @speed += n
    puts "Едем со скоростью #{@speed}"
  end

  def speed
    @speed 
  end

  def down_speed(n)
    (@speed -n) > 0 ? @speed -= n : @speed = 0
    puts "Едем со скоростью #{@speed}"
  end

  def wagons
    @wagons 
  end

  def stop
    @speed = 0
  end

  def attach
    self.stop
    @wagons += 1
  end

  def deattach
    self.stop
    (@wagons -1) > 0 ? @wagons -= 1 : @wagons = 0
  end

  def route(route)
    @route = route
    @location = @route.start
    @location.trains << self
  end

  def go_forward
    puts "Приехали" if @location == @route.terminate
    route = @route.way_station
    ind = route.index(@location)
    @location.trains.delete(self)
    @location = route[ind + 1]
    @location.trains << self
  end

  def go_back
    puts "Приехали" if @location == @route.start
    route = @route.way_station
    ind = route.index(@location)
    @location.trains.delete(self)
    @location = route[ind -1]
    @location.trains << self
  end
  
  def current_station
    puts "Текущая станция: #{@location.name}"
  end

  def back_station
    puts "Мы на старте" if @location == @route.start
    route = @route.way_station
    ind = route.index(@location)
    backSt = route[ind - 1]
    puts "Предыдущая станция: #{backSt.name}"
  end

  def next_station
    puts "Мы на финише" if @location == @route.terminate
    route = @route.way_station
    ind = route.index(@location)
    nextSt = route[ind + 1]
    puts "Следующая станция: #{nextSt.name}"
  end

end  


