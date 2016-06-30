class Race
  """
  Represents the overall race with its events and entrant information.
  """
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "races"

  field :n, as: :name, type: String
  field :date, as: :date, type: Date
  field :loc, as: :location, type: Address
  field :next_bib, type: Integer, :default => 0

  embeds_many :events, as: :parent, order: [:order.asc]
  has_many :entrants, foreign_key: "race._id", dependent: :delete, order: [:secs.asc, :bib.asc]

  scope :upcoming, -> { where(:date.gte => Date.current) }
  scope :past, -> { where(:date.lt => Date.current) }

  # Create a flattened view of the Race's events by dynamically creating
  # getters and setters for them
  DEFAULT_EVENTS = {
    "swim"=>{:order=>0, :name=>"swim", :distance=>1.0, :units=>"miles"},
    "t1"=>{:order=>1, :name=>"t1"},
    "bike"=>{:order=>2, :name=>"bike", :distance=>25.0, :units=>"miles"},
    "t2"=>{:order=>3, :name=>"t2"},
    "run"=>{:order=>4, :name=>"run", :distance=>10.0, :units=>"kilometers"}
  }

  DEFAULT_EVENTS.keys.each do |name|
    # Getter
    define_method("#{name}") do
      event = events.select {|event| name==event.name}.first
      event ||= events.build(DEFAULT_EVENTS["#{name}"])
    end
    # Setter for the athletic events
    ["order","distance","units"].each do |prop|
      if DEFAULT_EVENTS["#{name}"][prop.to_sym]
        define_method("#{name}_#{prop}") do
          event = self.send("#{name}").send("#{prop}")
        end

        define_method("#{name}_#{prop}=") do |value|
          event = self.send("#{name}").send("#{prop}=", value)
        end
      end
    end
  end

  # Create a default instance of the Race
  def self.default
    Race.new do |race|
      DEFAULT_EVENTS.keys.each {|leg|race.send("#{leg}")}
    end
  end

  # Provide flattened access to city and state within Race.location
  ["city", "state"].each do |action|
    define_method("#{action}") do
      self.location ? self.location.send("#{action}") : nil
    end

    define_method("#{action}=") do |name|
      object=self.location ||= Address.new
      object.send("#{action}=", name)
      self.location=object
    end
  end

  # Return a criteria result representing all the upcoming Races that the Racer
  # has not yet registered for
  def self.upcoming_available_to racer
    # Get all of the upcoming race ID's for this racer
    upcoming_race_ids = racer.races.upcoming.pluck(:race).map {|r| r[:_id]}
    Race.upcoming.not_in(:_id=>upcoming_race_ids)
  end

  # Find the next available bib
  def next_bib
    self.inc(:next_bib=>1)
    self[:next_bib]
  end

  # Return a Placing instance with its name set to the name of the age group the racer
  # will be competing in.
  def get_group racer
    if racer && racer.birth_year && racer.gender
      quotient = (date.year-racer.birth_year)/10
      min_age = quotient*10
      max_age = ((quotient+1)*10)-1
      gender = racer.gender
      name = min_age >= 60 ? "masters #{gender}" : "#{min_age} to #{max_age} (#{gender})"
      Placing.demongoize(:name=>name)
    end
  end

  # Create a new Entrant for the Race for a supplied Racer
  def create_entrant racer
    e = Entrant.new
    e.build_race(self.attributes.symbolize_keys.slice(:_id, :n, :date))
    e.build_racer(racer.info.attributes)
    e.group = get_group(racer)

    # Create a result for every Race event
    DEFAULT_EVENTS.each do |name, attrs|
      e.send("#{name}=", attrs)
    end

    # validate the new entrant and get a bib before saving it
    if e.validate
      e.bib = next_bib
      e.save
    end
    return e
  end
end
