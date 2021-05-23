class Public::SearchesController < ApplicationController
  
   def search
    @range = params[:range]

    if @range == "名前"
      @members = Member.looks(params[:search], params[:word])
    elsif @range == "記事タイトル"
      @posts = Post.looks(params[:search], params[:word])
    end
   end

end
