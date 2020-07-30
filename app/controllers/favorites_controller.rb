class FavoritesController < ApplicationController
  def create
    simplepost = simplepost.find(params[:simplepost_id])
    current_user.favorite(simplepost)
    flash[:success] = 'お気に入りしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    simplepost = simplepost.find(params[:simplepost_id])
    current_user.unfavorite(simplepost)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
