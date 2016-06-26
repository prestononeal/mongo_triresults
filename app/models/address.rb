class Address
  attr_accessor :city, :state, :location

  def initialize(city, state, location)
    @city = city
    @state = state
    @location = Point.demongoize(location)
  end

  def mongoize
    {:city=>@city, :state=>@state, :loc=>Point.mongoize(@location)}
  end

  def self.mongoize(object)
    case object
    when nil then nil
    when Hash then object
    when Address then object.mongoize
    end
  end

  def self.demongoize(object)
    case object
    when nil then nil
    when Hash then Address.new(object[:city], object[:state], Point.demongoize(object[:loc]))
    when Address then object
    end
  end

  def self.evolve(object)
    Address.mongoize(object)
  end
end
