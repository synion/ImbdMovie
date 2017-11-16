class Genre < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :movies

  def name_with_initial
    "tda"
  end
end
