class Public::PostsController < ApplicationController
  before_action :authenticate_member!

  def  index
    @posts = Post.all
  end

  def  show
    @post = Post.find(params[:id])
    @member = Member.find(@post.member.id)
    @posts = Post.all
    @post_comment = PostComment.new
  end

  def  new
    @post = Post.new
  end

  def  create
    @post= Post.new(post_params)
    @post.member_id = current_member.id
    @post.save
    redirect_to root_path
  end

  def  destroy
  end

 private

  def post_params
    list = [
      :title,
      :body,
      :image,
      :tag_list,
    ]
    params.require(:post).permit(list)
  end
end
