class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  # ログインしているメンバーのパラメータ受け渡し
  before_action :set_member, only: [:edit, :update, :withdraw]

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.all.order(created_at: :desc)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path,notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to root_path,notice: 'アカウントを削除しました　当サイトをご利用頂きありがとうございました'
  end

  def following
    member = Member.find(params[:id])
    @members = member.following_member
  end

   def following_index
    @posts = Post.where(member_id: [current_member.id, *current_member.following_member_ids])
    .order(created_at: :desc)
   end

  def follower
    member = Member.find(params[:id])
    @members = member.follower_member
  end

  private

  def set_member
    @member = Member.find(current_member.id)
  end

  def member_params
    list = [
      :nickname,
      :image,
      :playing_now,
      :introduction,
      :email,
    ]
    params.require(:member).permit(list)
  end
end