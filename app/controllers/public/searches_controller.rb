class Public::SearchesController < ApplicationController
   def search
    @range = params[:range]

    if @range == "Member"
      @members = Member.looks(params[:search], params[:word])
    elsif @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    end
   end

end
