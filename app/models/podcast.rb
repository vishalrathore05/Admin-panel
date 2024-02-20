class Podcast < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  validates_uniqueness_of :title
end