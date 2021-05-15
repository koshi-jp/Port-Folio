class Post < ApplicationRecord
  belongs_to :member
  attachment :image
  acts_as_taggable
end
