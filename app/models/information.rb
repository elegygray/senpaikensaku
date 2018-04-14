class Information < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :highschool, presence: true
  validates :university, presence: true
  validates :faculty, presence: true
  validates :content, presence: true
end
