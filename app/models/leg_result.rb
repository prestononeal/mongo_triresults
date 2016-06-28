class LegResult
  """
  Base class representing the event results within a race for a specific racer.
  A leg can represent a transition or actual sports events. Sub-classes are
  supplied to track unique information per event. All instances of this class
  and sub-types are contained within an embedded collection within Entrant.
  Instances of this class will also embed copies of the Event they are a result for.
  """
  include Mongoid::Document

  store_in collection: "results"

  field :secs, type: Float

  embedded_in :entrant

  def calc_ave
    # subclasses will calc event-specific ave
  end

  after_initialize do |doc|
    calc_ave
  end

  def secs= value
    self[:secs] = value
    calc_ave
  end
end
