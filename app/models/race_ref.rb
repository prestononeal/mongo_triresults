class RaceRef
  """
  Represents race-identifying information that is copied into each Entrant.
  This is built from Entrant attributes.
  """
  include Mongoid::Document

  field :n, as: :name, type: String
  field :date, type: Date

  embedded_in :entrant

  belongs_to :race, foreign_key: "_id"
end
