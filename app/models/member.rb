class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attachment :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
