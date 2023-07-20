class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_many :comments

  validates :url, presence: true
  validates :context, presence: true

end
