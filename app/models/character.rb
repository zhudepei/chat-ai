class Character < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :base_video
  has_one_attached :default_video
end
