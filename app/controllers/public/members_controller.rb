class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  # ストロングパラメーターの受け渡し
  before_action :set_member, only: [:show, :edit, :update, :withdraw]

  def show
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to members_my_page_path
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    @member.update(is_deleted: true)
    redirect_to root_path
  end

  private

  def set_member
    @member = Member.find(current_member.id)
  end

  def member_params
    list = [
      :name,
      :nickname,
      :image,
      :playing_now,
      :introduction,
      :is_deleted,
      :email,
    ]
    params.require(:member).permit(list)
  end
end