class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = 'このツイートをお気に入り登録しました。'
    redirect_to root_path
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'このツイートのお気に入り登録を解除しました。'
    redirect_to root_path
  end
end
