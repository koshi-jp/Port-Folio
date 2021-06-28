class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "名前"
      @members = Member.looks(params[:search], params[:word])
      @members = @members.page(params[:page]).reverse_order.per(20)
    elsif @range == "記事タイトル"
      @posts = Post.looks(params[:search], params[:word])
      @posts = @posts.page(params[:page]).reverse_order.per(20)
    end
  end
end
