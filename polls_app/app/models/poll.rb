# == Schema Information
#
# Table name: polls
#
#  id         :bigint(8)        not null, primary key
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           not null
#

class Poll < ApplicationRecord
  validates :author_id, :title, presence: true
  
  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User
  
  has_many :questions,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: :Question
end
