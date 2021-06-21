class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(member_id: current_member.id)
    favorite.save
    @post.create_notification_favorite!(current_member)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(member_id: current_member.id)
    favorite.destroy
  end
end
