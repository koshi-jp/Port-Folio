class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def follow
    @member = Member.find(params[:id])
    current_member.follow(params[:id])
    @member.create_notification_follow!(current_member)
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_member.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end
end
