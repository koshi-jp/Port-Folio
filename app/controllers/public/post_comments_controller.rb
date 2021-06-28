class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    post = Post.find(params[:post_id])
    post_comment = current_member.post_comments.new(post_comment_params)
    @post = post_comment.post
    post_comment.post_id = post.id
    post_comment.save
    post.create_notification_comment!(current_member, post_comment.id)
    redirect_to post_path(post), notice: 'コメントが作成されました'
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました。'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
