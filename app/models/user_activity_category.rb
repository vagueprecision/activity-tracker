class UserActivityCategory < ApplicationRecord
  belongs_to :user_activity
  belongs_to :category
end
