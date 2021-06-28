class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :post
  # 通知機能
  has_many :notifications, dependent: :destroy
end
