class SimplepostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @simplepost = current_user.simpleposts.build(simplepost_params)
    if @simplepost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @simpleposts = current_user.feed_simpleposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @simplepost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def search
    @simpleposts = Simplepost.search(params[:search]).page(params[:page])
  end

  private

  def simplepost_params
    params.require(:simplepost).permit(:content)
  end

  def correct_user
    @simplepost = current_user.simpleposts.find_by(id: params[:id])
    unless @simplepost
      redirect_to root_url
    end
  end

end