class PrototypesController < ApplicationController
  # 特定のアクションによるページに遷移しようとした際にログインページにリダイレクトする
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  # 投稿者本人でないユーザが投稿者本人の専用ページに遷移しようとするとリダイレクトする
  before_action :set_prototype, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new()
  end

  def create
    @prototype= Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user) # N+1問題解消用
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  # フォームで入力した内容と現在ログインしているユーザIDの情報を統合する
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  # プライベートメソッド内でインスタンス変数を使用できるようにする
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  # 現在ログインしているユーザIDとプロトタイプを投稿したユーザIDが一致していない場合トップページに遷移する
  def move_to_index
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
  end

end
