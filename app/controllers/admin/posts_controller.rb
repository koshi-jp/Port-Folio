class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def  index
    @posts = Post.all
  end

  def  show
    @post = Post.find(params[:id])
    @member = Member.find(@post.member.id)
    @posts = Post.all
  end

end
