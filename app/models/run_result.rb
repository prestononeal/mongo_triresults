class RunResult < LegResult

  field :mmile, as: :minute_mile, type: Float

  def calc_ave
    if self.event and self.secs
      miles = self.event.miles
      self.minute_mile = miles.nil? ? nil : (self.secs/60)/miles
    end
  end
end
