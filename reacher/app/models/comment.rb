class Comment < ApplicationRecord
  belongs_to :client
  belongs_to :instagram_post
end
