class LegResult
  include Mongoid::Document

  store_in collection: "results"

  field :secs, type: Float

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
