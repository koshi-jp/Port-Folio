class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path
    else
      render 'edit'
    end
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    redirect_to root_path
  end

  private

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
