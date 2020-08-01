class FavoritesController < ApplicationController
  def create
    simplepost = Simplepost.find(params[:simplepost_id])
    current_user.favorite(simplepost)
    flash[:success] = 'お気に入りしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    simplepost = Simplepost.find(params[:simplepost_id])
    current_user.unfavorite(simplepost)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
