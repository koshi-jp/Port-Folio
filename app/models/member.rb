class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true, length: { maximum: 17 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :playing_now, length: { maximum: 51 }, presence: true
  validates :introduction, length: { maximum: 85 }, presence: true

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

  # 以下通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def follow(member_id)
    following.create(follower_id: member_id)
  end

  def unfollow(member_id)
    following.find_by(follower_id: member_id).destroy
  end

  def following?(member_id)
    following_member.include?(member_id)
  end

  def create_notification_follow!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @member = Member.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @member = Member.where("nickname LIKE?", "#{word}%")
    elsif search == "backward_match"
      @member = Member.where("nickname LIKE?", "%#{word}")
    elsif search == "partial_match"
      @member = Member.where("nickname LIKE?", "%#{word}%")
    else
      @member = Member.all
    end
  end
end
