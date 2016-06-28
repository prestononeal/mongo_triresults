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

  embeds_many :events, as: :parent, order: [:order.asc]

  scope :upcoming, -> { where(:date.gte => Date.current) }
  scope :past, -> { where(:date.lt => Date.current) }
end
