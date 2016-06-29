class BikeResult < LegResult

  field :mph, type: Float

  def calc_ave
    if self.event and self.secs
      miles = self.event.miles
      self.mph = miles.nil? ? nil : 12.1
    end
  end
end
