class Public::PostsController < ApplicationController
  before_action :authenticate_member!

  def  index
    @posts = Post.page(params[:page]).reverse_order
    # @posts = Post.all.order(created_at: :desc)
    #タグ絞り込み
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
      @posts = @posts.page(params[:page]).reverse_order.per(30)
    end
  end

  def  show
    @post = Post.find(params[:id])
    @member = Member.find(@post.member.id)
    @posts = Post.all
    @post_comment = PostComment.new
    @member_posts = @member.posts.all
  end

  def  new
    @post = Post.new
  end

  def  create
    @post= Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
       redirect_to posts_path,notice: '投稿が作成されました'
    else
       render action: :new
    end
  end

  def  destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path,notice: '投稿を削除しました'
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
