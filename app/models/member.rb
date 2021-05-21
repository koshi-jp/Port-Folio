class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 以下フォロー機能
  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :following_member, through: :following, source: :follower
  has_many :follower_member, through: :follower, source: :following

  def follow(member_id)
    following.create(follower_id: member_id)
  end

  def unfollow(member_id)
    following.find_by(follower_id: member_id).destroy
  end

  def following?(member_id)
    following_member.include?(member_id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @member = Member.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @member = Member.where("nickname LIKE?","#{word}%")
    elsif search == "backward_match"
      @member = Member.where("nickname LIKE?","%#{word}")
    elsif search == "partial_match"
      @member = Member.where("nickname LIKE?","%#{word}%")
    else
      @member = Member.all
    end
  end
end
