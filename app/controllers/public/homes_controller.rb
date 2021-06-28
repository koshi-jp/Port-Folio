class Public::HomesController < ApplicationController
  def top
  end

  def guest_sign_in
    member = Member.find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.nickname = "ゲスト"
      member.introduction = "ゲストユーザーです。"
      member.playing_now = "テトリス"
    end
    sign_in member
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
