class Public::PostsController < ApplicationController

  def  index
    @posts = Post.all
  end

  def  show
    @member = Member.find(params[:id])
    @posts = Post.all
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
    ]
    params.require(:post).permit(list)
  end
end
