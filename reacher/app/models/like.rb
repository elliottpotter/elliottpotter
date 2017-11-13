class Like < ApplicationRecord
  belongs_to :client
  belongs_to :instagram_post
  belongs_to :user
end
