# == Schema Information
#
# Table name: responses
#
#  id               :bigint(8)        not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  validates :answer_choice_id, :user_id, presence: true
  validate :not_duplicate_response, :is_author_of_this_poll?
  
  belongs_to :answer_choice,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  class_name: :AnswerChoice
  
  belongs_to :respondent,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
  
  has_one :question,
  through: :answer_choice,
  source: :question
  
  has_one :poll,
  through: :question,
  source: :poll
  
  has_one :author_of_poll,
  through: :poll,
  source: :author
  
  def sibling_responses
    self.question.responses.where.not(self.id)
  end
  
  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: (self.user_id)) 
  end
  
  def not_duplicate_response
    errors[:response] << 'You already answered!' if respondent_already_answered?  
  end
  
  def is_author_of_this_poll?
    if self.author_of_poll.id == self.user_id
      errors[:response] << 'You are responding to your own poll you corrupt ass'
    end
  end
end
