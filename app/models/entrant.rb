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

  embeds_many :results, class_name: "LegResult", order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: "RaceRef"
  embeds_one :racer, as: :parent, class_name: "RacerInfo"

  def update_total(result)
    # A relationship callback to recalculate the sum of all event times
    # known to the Entrant
    self.secs = 0
    self.results.each { |res| self.secs += res.secs}
  end

  def the_race
    # Custom getter that returns the result of the embedded RaceRef's Race
    race.race if !race.nil?
  end
end
