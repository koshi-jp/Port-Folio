class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: [:edit, :update, :withdraw]

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).reverse_order.per(20)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.id == current_member.id
      @member.update(member_params)
      redirect_to member_path, notice: 'プロフィールを編集しました'
    else
      redirect_to root_path, notice: '他人のプロフィールは編集できません'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    if @member.id == current_member.id
      member.destroy
      redirect_to root_path, notice: 'アカウントを削除しました　当サイトをご利用頂きありがとうございました'
    else
      redirect_to root_path, notice: '他人のアカウントは削除できません'
    end
  end

  def following
    member = Member.find(params[:id])
    @members = member.following_member
    @members = @members.page(params[:page]).reverse_order.per(20)
  end

  def following_index
    @posts = Post.where(member_id: [current_member.id, *current_member.following_member_ids])
    @posts = @posts.page(params[:page]).reverse_order.per(20)
  end

  def follower
    member = Member.find(params[:id])
    @members = member.follower_member
    @members = @members.page(params[:page]).reverse_order.per(20)
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
