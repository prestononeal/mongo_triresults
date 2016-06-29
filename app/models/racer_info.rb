class RacerInfo
  """
  Represents a Racer identity required by races he/she enters. The master copy
  is embedded within Racer. A copy of this is embedded within his/her Entrant,
  which represents the entry within a race.
  """
  include Mongoid::Document

  store_in collection: "racers"

  field :racer_id, as: :_id
  field :_id, default: ->{ racer_id }
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address

  embedded_in :parent, polymorphic: true

  validates_presence_of :first_name, :last_name, :gender, :birth_year
  validates_inclusion_of :gender, :in => %w( M F )
  validates_numericality_of :birth_year, :only_integer => true, :less_than => Time.now.year

  # Use metaprogramming to dynamically create methods to get and set the city and state
  # of the custom models
  ["city", "state"].each do |action|
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil
    end

    define_method("#{action}=") do |name|
      object = self.residence ||= Address.new
      object.send("#{action}=", name)
      self.residence = object
    end
  end
end
