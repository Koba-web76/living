class TweetsController < ApplicationController

  before_action :authenticate_user!,only: [:new, :create]

    def index
    @tweets = Tweet.all

    # タグ絞り込み
    if params[:tag_ids].present?
      selected_tags = params[:tag_ids].select { |_, v| v == "1" }.keys
      @tweets = @tweets.joins(:tags).where(tags: { name: selected_tags }).distinct
    end

    # 商品検索
    if params[:search].present?
      @tweets = @tweets.where("name LIKE ?", "%#{params[:search]}%")
    end

    # カテゴリ絞り込み
    if params[:category_ids].present?
      @tweets = @tweets.where(category_id: params[:category_ids])
    end

    # ユーザー属性絞り込み
    if params[:age_group].present?
      @tweets = @tweets.joins(:user).where(users: { age_group: params[:age_group] })
    end
    if params[:gender].present?
      @tweets = @tweets.joins(:user).where(users: { gender: params[:gender] })
    end
    if params[:stat].present?
      @tweets = @tweets.joins(:user).where(users: { stat: params[:stat] })
    end
    if params[:area].present?
      @tweets = @tweets.joins(:user).where(users: { area: params[:area] })
    end
    if params[:room_type].present?
      @tweets = @tweets.joins(:user).where(users: { room_type: params[:room_type] })
    end

    # 新しいタグ作成（重複防止）
    if params[:tag].present?
      Tag.find_or_create_by(name: params[:tag].strip)
    end

    # 最後にincludesとorderだけ
    @tweets = @tweets.includes(:comments).order(created_at: :desc)
  end
  
  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id  # ← これを追加
    tweet.user_name = current_user.name
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end
  def like
    # いいね数順にソート
      @rank_tweets = Tweet.left_joins(:likes)
                          .group(:id)
                          .order('COUNT(likes.id) DESC')
  end
  def show
         @tweet = Tweet.find(params[:id])
         @comments = @tweet.comments
         @comment = Comment.new
  end
  def edit
         @tweet = Tweet.find(params[:id])
  end
  def update
      tweet = Tweet.find(params[:id])
      if tweet.update(tweet_params)
        redirect_to :action => "show", :id => tweet.id
      else
        redirect_to :action => "new"
      end
  end
  def destroy
      tweet = Tweet.find(params[:id])
      tweet.destroy
      redirect_to action: :index
  end

    private
  def tweet_params
    params.require(:tweet).permit(:name, :setumei, :image, :category_id, :url, :overall, tag_ids: [])
  end
end