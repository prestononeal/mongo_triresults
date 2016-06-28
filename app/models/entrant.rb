class Entrant
  """
  Represents a single racer's registration in a race and their results,
  broken down by leg - to include swim, bike, and run events in addition
  to the two transitions between the three events
  """
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "results"

  field :bib, type: Integer
  field :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, type: Placing
  field :group, type: Placing

  embeds_many :results, class_name: "LegResult"
end
