class FavosController < ApplicationController
  before_action :require_user_logged_in

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favo(micropost)
    flash[:success] = 'このツイートをお気に入り登録しました。'
    redirect_to root_path
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavo(micropost)
    flash[:success] = 'このツイートのお気に入り登録を解除しました。'
    redirect_to root_path
  end
end