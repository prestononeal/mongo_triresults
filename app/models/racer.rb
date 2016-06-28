class Racer
  """
  Represents a single individual and reference to all race entries.
  """
  include Mongoid::Document

  store_in collection: "racers"

  embeds_one :info, as: :parent, class_name: "RacerInfo", autobuild: true

  before_create do |racer|
    racer.info.id = racer.id
  end
end
