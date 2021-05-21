class Public::RelationshipsController < ApplicationController
    def follow
      current_member.follow(params[:id])
      redirect_back(fallback_location: root_path)
    end

    def unfollow
      current_member.unfollow(params[:id])
      redirect_back(fallback_location: root_path)
    end
end
